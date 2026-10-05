import 'package:flutter/material.dart';

class RecordDetailPage extends StatefulWidget {
  final String? username;

  const RecordDetailPage({
    super.key,
    this.username,
  });

  @override
  State<RecordDetailPage> createState() => _RecordDetailPageState();
}

class _RecordDetailPageState extends State<RecordDetailPage> {
  bool _isLiked = false;

  int _likeCount = 128;
  final int _commentCount = 24;

  final String _habitName = 'باشگاه';

  final String _caption =
      'امروز با اینکه انرژی زیادی نداشتم، خودم را مجبور کردم بروم باشگاه. '
      'همین که شروع کردم، حالم خیلی بهتر شد. گاهی مهم‌ترین قدم فقط حاضر شدن است.';

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
  }

  void _openComments() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('صفحه نظرات در حال آماده‌سازی است.'),
      ),
    );
  }

  void _shareRecord() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('اشتراک‌گذاری در نسخه نهایی اضافه می‌شود.'),
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final theme = Theme.of(context);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.bookmark_border),
                  title: const Text('ذخیره رکورد'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.flag_outlined),
                  title: const Text('گزارش رکورد'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.close,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  title: const Text('بستن'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
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
        title: const Text('رکورد'),
        actions: [
          IconButton(
            onPressed: _showMoreOptions,
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAuthorHeader(context),
            const SizedBox(height: 20),
            _buildRecordContent(context),
            const SizedBox(height: 20),
            _buildPostImage(colorScheme),
            const SizedBox(height: 20),
            _buildInteractionSection(context),
            const SizedBox(height: 16),
            _buildCommentsPreview(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.16),
                  offset: const Offset(6, 6),
                  blurRadius: 12,
                ),
                BoxShadow(
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.8),
                  offset: const Offset(-5, -5),
                  blurRadius: 10,
                ),
              ],
            ),
            padding: const EdgeInsets.all(3),
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
                Text(
                  widget.username ?? 'مصطفی',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '@${widget.username ?? 'mostafa'}',
                  textDirection: TextDirection.ltr,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          _buildHabitChip(context),
        ],
      ),
    );
  }

  Widget _buildHabitChip(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _habitName,
        style: theme.textTheme.labelMedium?.copyWith(
          color: colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRecordContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _caption,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'امروز، ۲ ساعت پیش',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostImage(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Image.asset(
            'assets/images/post.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInteractionSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: _toggleLike,
                icon: Icon(
                  _isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: _isLiked
                      ? colorScheme.error
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '$_likeCount',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: _openComments,
                icon: const Icon(Icons.chat_bubble_outline),
              ),
              Text(
                '$_commentCount',
                style: theme.textTheme.bodyMedium,
              ),
              const Spacer(),
              IconButton(
                onPressed: _shareRecord,
                icon: const Icon(Icons.share_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildCommentsPreview(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'نظرات',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _buildComment(
            context,
            username: 'علی',
            comment: 'دقیقاً همینطوره. مهم شروع کردنه.',
          ),
          const SizedBox(height: 14),
          _buildComment(
            context,
            username: 'سارا',
            comment: 'خیلی خوب گفتی، ادامه بده 💪',
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _openComments,
            child: const Text('مشاهده همه نظرات'),
          ),
        ],
      ),
    );
  }

  Widget _buildComment(
    BuildContext context, {
    required String username,
    required String comment,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/man.jpg',
            width: 38,
            height: 38,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: '$username  ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: comment,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}