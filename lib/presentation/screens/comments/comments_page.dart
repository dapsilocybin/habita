import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  final String? recordId;

  const CommentsPage({
    super.key,
    this.recordId,
  });

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final _commentController = TextEditingController();

  final List<_Comment> _comments = [
    _Comment(
      username: 'علی',
      comment: 'دقیقاً همینطوره. مهم اینه که حتی وقتی حوصله نداری شروع کنی.',
      likes: 18,
      isLiked: true,
    ),
    _Comment(
      username: 'سارا',
      comment: 'خیلی خوب گفتی، ادامه بده 💪',
      likes: 7,
    ),
    _Comment(
      username: 'محمد',
      comment: 'منم امروز دقیقاً همین تجربه رو داشتم.',
      likes: 12,
    ),
    _Comment(
      username: 'رضا',
      comment: 'ثبات از انگیزه مهم‌تره.',
      likes: 24,
      isLiked: true,
    ),
    _Comment(
      username: 'نگار',
      comment: 'این رکورد واقعاً بهم انگیزه داد که امروز تمرین کنم.',
      likes: 5,
    ),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _commentController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      _comments.insert(
        0,
        _Comment(
          username: 'مصطفی',
          comment: text,
          likes: 0,
        ),
      );

      _commentController.clear();
    });
  }

  void _toggleLike(int index) {
    setState(() {
      final comment = _comments[index];

      _comments[index] = comment.copyWith(
        isLiked: !comment.isLiked,
        likes: comment.likes + (comment.isLiked ? -1 : 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'نظرات',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _comments.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      12,
                      20,
                      20,
                    ),
                    itemCount: _comments.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      return _buildComment(
                        context,
                        index,
                        _comments[index],
                      );
                    },
                  ),
          ),
          _buildCommentComposer(context),
        ],
      ),
    );
  }

  Widget _buildComment(
    BuildContext context,
    int index,
    _Comment comment,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.15),
                offset: const Offset(5, 5),
                blurRadius: 10,
              ),
              BoxShadow(
                color: colorScheme.surfaceContainerHighest
                    .withOpacity(0.8),
                offset: const Offset(-4, -4),
                blurRadius: 8,
              ),
            ],
          ),
          padding: const EdgeInsets.all(2),
          child: ClipOval(
            child: Image.asset(
              'assets/images/man.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
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
                  color: colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.username,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      comment.comment,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                    ),
                    child: const Text('پاسخ'),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _toggleLike(index),
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                    icon: Icon(
                      comment.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: comment.isLiked
                          ? colorScheme.error
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '${comment.likes}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommentComposer(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.10),
            offset: const Offset(0, -4),
            blurRadius: 14,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/man.jpg',
              width: 42,
              height: 42,
              fit: BoxFit.cover,
            ),
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
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary,
            ),
            child: IconButton(
              onPressed: _addComment,
              icon: Icon(
                Icons.send_rounded,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 20),
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
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Comment {
  final String username;
  final String comment;
  final int likes;
  final bool isLiked;

  const _Comment({
    required this.username,
    required this.comment,
    required this.likes,
    this.isLiked = false,
  });

  _Comment copyWith({
    String? username,
    String? comment,
    int? likes,
    bool? isLiked,
  }) {
    return _Comment(
      username: username ?? this.username,
      comment: comment ?? this.comment,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}