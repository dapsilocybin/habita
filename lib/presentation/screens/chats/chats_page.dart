import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/models/conversation_model.dart';
import 'package:habita/data/providers/messaging_provider.dart';
import 'package:habita/data/repositories/messaging_repository.dart';
import 'package:habita/logic/blocs/chats/chats_bloc.dart';
import 'package:habita/logic/blocs/chats/chats_event.dart';
import 'package:habita/logic/blocs/chats/chats_state.dart';
import 'package:habita/presentation/screens/chats/chatbox_page.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatsBloc(
        repository: MessagingRepository(provider: MessagingProvider()),
      )..add(const ChatsRequested()),
      child: const _ChatsContent(),
    );
  }
}

class _ChatsContent extends StatefulWidget {
  const _ChatsContent();

  @override
  State<_ChatsContent> createState() => _ChatsContentState();
}

class _ChatsContentState extends State<_ChatsContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    final bloc = context.read<ChatsBloc>();
    bloc.add(const ChatsRefreshed());
    await bloc.stream.firstWhere(
      (state) => state is ChatsLoaded || state is ChatsError,
    );
  }

  void _openConversation(Conversation conversation) {
    Navigator.of(context)
        .push<void>(
          MaterialPageRoute(
            builder: (_) => ChatboxPage(conversation: conversation),
          ),
        )
        .then((_) {
          if (mounted) context.read<ChatsBloc>().add(const ChatsRefreshed());
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('گفتگوها'), centerTitle: true),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: TextField(
                controller: _searchController,
                onChanged: (value) =>
                    context.read<ChatsBloc>().add(ChatsSearchChanged(value)),
                decoration: InputDecoration(
                  hintText: 'جستجوی نام یا نام کاربری...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _searchController.clear();
                            context.read<ChatsBloc>().add(
                              const ChatsSearchChanged(''),
                            );
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                  filled: true,
                  fillColor: colors.surfaceContainerHighest.withValues(
                    alpha: 0.45,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ChatsBloc, ChatsState>(
                builder: (context, state) {
                  if (state is ChatsInitial || state is ChatsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ChatsError) {
                    return _ErrorState(
                      message: state.message,
                      onRetry: _refresh,
                    );
                  }

                  final loaded = state as ChatsLoaded;
                  final conversations = loaded.filteredConversations;
                  if (conversations.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            child: Center(
                              child: Text(
                                loaded.conversations.isEmpty
                                    ? 'هنوز گفتگویی ندارید.'
                                    : 'گفتگویی با این نام پیدا نشد.',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                      itemCount: conversations.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final conversation = conversations[index];
                        return _ConversationTile(
                          conversation: conversation,
                          onTap: () => _openConversation(conversation),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({required this.conversation, required this.onTap});

  final Conversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final user = conversation.otherUser;

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
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
        title: Text(
          user.displayName.isNotEmpty ? user.displayName : 'کاربر',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          conversation.previewText.isEmpty
              ? 'گفتگو را شروع کنید'
              : conversation.previewText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatTime(conversation.updatedAt),
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            if (user.username.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                '@${user.username}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (now.difference(time).inDays == 0) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
    return '${time.month}/${time.day}';
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, color: colors.error, size: 44),
            const SizedBox(height: 12),
            const Text('دریافت گفتگوها ناموفق بود.'),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('تلاش دوباره'),
            ),
          ],
        ),
      ),
    );
  }
}
