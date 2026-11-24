import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/models/chat_message_model.dart';
import 'package:habita/data/models/conversation_model.dart';
import 'package:habita/data/providers/messaging_provider.dart';
import 'package:habita/data/repositories/messaging_repository.dart';
import 'package:habita/logic/blocs/chatbox/chatbox_bloc.dart';
import 'package:habita/logic/blocs/chatbox/chatbox_event.dart';
import 'package:habita/logic/blocs/chatbox/chatbox_state.dart';
import 'package:habita/presentation/widgets/shared_post_message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatboxPage extends StatelessWidget {
  const ChatboxPage({super.key, required this.conversation});

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatboxBloc(
        repository: MessagingRepository(provider: MessagingProvider()),
      )..add(ChatboxMessagesRequested(conversation.id)),
      child: _ChatboxContent(conversation: conversation),
    );
  }
}

class _ChatboxContent extends StatefulWidget {
  const _ChatboxContent({required this.conversation});

  final Conversation conversation;

  @override
  State<_ChatboxContent> createState() => _ChatboxContentState();
}

class _ChatboxContentState extends State<_ChatboxContent> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _wasSending = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;
    context.read<ChatboxBloc>().add(ChatboxMessageSendRequested(content));
  }

  void _scrollToLatest() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final user = widget.conversation.otherUser;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: user.avatarUrl == null
                    ? null
                    : NetworkImage(user.avatarUrl!),
                child: user.avatarUrl == null
                    ? Text(
                        user.displayName.isEmpty
                            ? '?'
                            : user.displayName.substring(0, 1),
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName.isNotEmpty ? user.displayName : 'کاربر',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (user.username.isNotEmpty)
                      Text(
                        '@${user.username}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<ChatboxBloc, ChatboxState>(
                  listener: (context, state) {
                    if (state is ChatboxLoaded) {
                      if (_wasSending &&
                          !state.isSending &&
                          state.error == null) {
                        _messageController.clear();
                      }
                      if (state.error != null) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text('ارسال/دریافت پیام ناموفق بود.'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                      }
                      _wasSending = state.isSending;
                      _scrollToLatest();
                    }
                  },
                  builder: (context, state) {
                    if (state is ChatboxInitial || state is ChatboxLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ChatboxError) {
                      return _errorView(context, state.message);
                    }

                    final loaded = state as ChatboxLoaded;
                    final currentUserId =
                        Supabase.instance.client.auth.currentUser?.id;

                    return Column(
                      children: [
                        if (loaded.realtimeError != null)
                          MaterialBanner(
                            content: const Text(
                              'اتصال زنده پیام‌ها برقرار نشد؛ برای دریافت پیام‌های تازه صفحه را تازه‌سازی کنید.',
                            ),
                            leading: const Icon(Icons.wifi_off_rounded),
                            actions: [
                              TextButton(
                                onPressed: () => context
                                    .read<ChatboxBloc>()
                                    .add(const ChatboxMessagesRefreshed()),
                                child: const Text('تازه‌سازی'),
                              ),
                            ],
                          ),
                        if (loaded.error != null)
                          MaterialBanner(
                            content: Text(loaded.error!),
                            leading: const Icon(Icons.error_outline_rounded),
                            actions: [
                              TextButton(
                                onPressed: () => context
                                    .read<ChatboxBloc>()
                                    .add(const ChatboxMessagesRefreshed()),
                                child: const Text('تلاش دوباره'),
                              ),
                            ],
                          ),
                        Expanded(
                          child: loaded.messages.isEmpty
                              ? _emptyConversation(context)
                              : RefreshIndicator(
                                  onRefresh: () => _refresh(context),
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    padding: const EdgeInsets.fromLTRB(
                                      14,
                                      18,
                                      14,
                                      16,
                                    ),
                                    itemCount: loaded.messages.length,
                                    itemBuilder: (context, index) {
                                      final message = loaded.messages[index];
                                      return _MessageBubble(
                                        message: message,
                                        isMine:
                                            message.senderId == currentUserId,
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              _buildComposer(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<ChatboxBloc>();
    bloc.add(const ChatboxMessagesRefreshed());
    await bloc.stream.firstWhere(
      (state) => state is ChatboxLoaded && !state.isRefreshing,
    );
  }

  Widget _emptyConversation(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'هنوز پیامی در این گفتگو نیست. اولین پیام را بفرستید.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorView(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.read<ChatboxBloc>().add(
                ChatboxMessagesRequested(widget.conversation.id),
              ),
              child: const Text('تلاش دوباره'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComposer(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
        child: BlocBuilder<ChatboxBloc, ChatboxState>(
          builder: (context, state) {
            final isSending = state is ChatboxLoaded && state.isSending;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'پیامت را بنویس...',
                      filled: true,
                      fillColor: colors.surfaceContainerHighest.withValues(
                        alpha: 0.45,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  tooltip: 'ارسال',
                  onPressed: isSending ? null : _sendMessage,
                  icon: isSending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send_rounded),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.isMine});

  final ChatMessage message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final background = isMine
        ? colors.primaryContainer
        : colors.surfaceContainerHigh;
    final foreground = isMine ? colors.onPrimaryContainer : colors.onSurface;

    return Align(
      alignment: isMine
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.82,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isMine ? 4 : 18),
            bottomRight: Radius.circular(isMine ? 18 : 4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.isSharedPost && message.sharedRecordId != null) ...[
              SharedPostMessage(recordId: message.sharedRecordId!),
            ] else if (message.isSharedPost) ...[
              const Text('این پست در دسترس نیست.'),
            ] else
              Text(
                message.content,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: foreground,
                ),
              ),
            const SizedBox(height: 4),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                '${message.createdAt.hour.toString().padLeft(2, '0')}:${message.createdAt.minute.toString().padLeft(2, '0')}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
