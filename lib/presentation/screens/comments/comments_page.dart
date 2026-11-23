import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/models/post_comment_model.dart';
import 'package:habita/data/providers/comments_provider.dart';
import 'package:habita/data/repositories/comments_repository.dart';
import 'package:habita/logic/blocs/comments/comments_bloc.dart';
import 'package:habita/logic/blocs/comments/comments_event.dart';
import 'package:habita/logic/blocs/comments/comments_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key, required this.recordId});

  final String recordId;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late final CommentsBloc _commentsBloc;
  final _commentController = TextEditingController();
  PostComment? _replyingTo;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = Supabase.instance.client.auth.currentUser?.id;
    _commentsBloc = CommentsBloc(
      commentsRepository: CommentsRepository(
        commentsProvider: CommentsProvider(),
      ),
    )..add(CommentsRequested(widget.recordId));
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentsBloc.close();
    super.dispose();
  }

  void _submitComment() {
    _commentsBloc.add(
      CommentSubmitted(
        recordId: widget.recordId,
        content: _commentController.text,
        parentCommentId: _replyingTo?.id,
      ),
    );
  }

  Future<void> _deleteComment(PostComment comment) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف نظر'),
        content: const Text(
          'این نظر برای دیگران به‌صورت حذف‌شده نمایش داده می‌شود.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('انصراف'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (shouldDelete == true && mounted) {
      _commentsBloc.add(
        CommentDeleted(recordId: widget.recordId, commentId: comment.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocProvider.value(
      value: _commentsBloc,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: colors.surface,
          appBar: AppBar(
            backgroundColor: colors.surface,
            elevation: 0,
            centerTitle: true,
            leading: BlocBuilder<CommentsBloc, CommentsState>(
              builder: (context, state) => IconButton(
                tooltip: 'بازگشت',
                onPressed: () =>
                    Navigator.of(context).pop(_countComments(state.comments)),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            title: Text(
              'نظرات',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: BlocConsumer<CommentsBloc, CommentsState>(
                    listenWhen: (previous, current) =>
                        previous.submissionSucceeded !=
                            current.submissionSucceeded ||
                        previous.submissionError != current.submissionError,
                    listener: (context, state) {
                      if (state.submissionSucceeded) {
                        _commentController.clear();
                        setState(() {
                          _replyingTo = null;
                        });
                      } else if (state.submissionError != null) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(state.submissionError!),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                      }
                    },
                    builder: (context, state) {
                      if (state.isLoading && state.comments.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.error != null && state.comments.isEmpty) {
                        return _buildError(context, state.error!);
                      }

                      if (state.comments.isEmpty) {
                        return _buildEmptyState(context);
                      }

                      return Column(
                        children: [
                          if (state.error != null)
                            MaterialBanner(
                              content: Text(state.error!),
                              actions: [
                                TextButton(
                                  onPressed: () => _commentsBloc.add(
                                    CommentsRequested(widget.recordId),
                                  ),
                                  child: const Text('تلاش دوباره'),
                                ),
                              ],
                            ),
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                _commentsBloc.add(
                                  CommentsRequested(widget.recordId),
                                );
                                await _commentsBloc.stream.firstWhere(
                                  (state) => !state.isLoading,
                                );
                              },
                              child: ListView.separated(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  12,
                                  16,
                                  20,
                                ),
                                itemCount: state.comments.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 18),
                                itemBuilder: (context, index) =>
                                    _buildCommentTree(
                                      context,
                                      state.comments[index],
                                    ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                BlocBuilder<CommentsBloc, CommentsState>(
                  builder: (context, state) =>
                      _buildCommentComposer(context, state),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentTree(BuildContext context, PostComment comment) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 21,
              backgroundColor: colors.primaryContainer,
              child: Text(
                _avatarLetter(comment.displayName),
                style: TextStyle(
                  color: colors.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.isDeleted
                              ? 'نظر حذف‌شده'
                              : comment.displayName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          comment.isDeleted
                              ? 'این نظر در دسترس نیست.'
                              : comment.content,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.onSurface,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        _formatTimestamp(comment.createdAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      if (!comment.isDeleted)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _replyingTo = comment;
                            });
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                          child: const Text('پاسخ'),
                        ),
                      if (!comment.isDeleted &&
                          comment.userId == _currentUserId)
                        IconButton(
                          tooltip: 'حذف نظر',
                          onPressed: () => _deleteComment(comment),
                          icon: Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: colors.error,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (comment.replies.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: colors.outlineVariant, width: 2),
                ),
              ),
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                children: comment.replies
                    .map(
                      (reply) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _buildCommentTree(context, reply),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCommentComposer(BuildContext context, CommentsState state) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(
        14,
        10,
        14,
        10 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.10),
            offset: const Offset(0, -4),
            blurRadius: 14,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_replyingTo != null)
            Row(
              children: [
                Expanded(
                  child: Text(
                    'پاسخ به ${_replyingTo!.displayName}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'لغو پاسخ',
                  onPressed: () => setState(() => _replyingTo = null),
                  icon: const Icon(Icons.close, size: 18),
                ),
              ],
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: colors.surfaceContainerHighest,
                child: Icon(Icons.person_outline, color: colors.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _commentController,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(
                    hintText: 'نظرت را بنویس...',
                    prefixIcon: Icon(Icons.chat_bubble_outline),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: state.isSubmitting ? null : _submitComment,
                tooltip: _replyingTo == null ? 'ثبت نظر' : 'ثبت پاسخ',
                icon: state.isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 60, color: colors.primary),
            const SizedBox(height: 18),
            Text(
              'هنوز نظری وجود ندارد',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'اولین نفری باش که درباره این رکورد نظر می‌دهد.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: colors.error, size: 42),
            const SizedBox(height: 12),
            Text(error, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () =>
                  _commentsBloc.add(CommentsRequested(widget.recordId)),
              child: const Text('تلاش دوباره'),
            ),
          ],
        ),
      ),
    );
  }

  String _avatarLetter(String name) {
    final trimmed = name.trim();
    return trimmed.isEmpty ? '؟' : trimmed.substring(0, 1);
  }

  int _countComments(List<PostComment> comments) {
    return comments.fold<int>(
      0,
      (count, comment) => count + 1 + _countComments(comment.replies),
    );
  }

  String _formatTimestamp(DateTime dateTime) {
    const digits = '۰۱۲۳۴۵۶۷۸۹';

    String persian(int number) {
      return number.toString().split('').map((digit) {
        final value = int.parse(digit);
        return digits[value];
      }).join();
    }

    final difference = DateTime.now().difference(dateTime);
    if (difference.isNegative || difference.inMinutes == 0) {
      return 'همین الان';
    }
    if (difference.inHours == 0) {
      return '${persian(difference.inMinutes)} دقیقه پیش';
    }
    if (difference.inDays == 0) {
      return '${persian(difference.inHours)} ساعت پیش';
    }
    if (difference.inDays < 7) {
      return '${persian(difference.inDays)} روز پیش';
    }

    return '${persian(dateTime.year)}/${persian(dateTime.month)}/${persian(dateTime.day)}';
  }
}
