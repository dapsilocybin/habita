import 'package:flutter/material.dart';

import '../record_detail/record_detail_page.dart';

class FollowingFeedPage extends StatefulWidget {
  const FollowingFeedPage({super.key});

  @override
  State<FollowingFeedPage> createState() => _FollowingFeedPageState();
}

class _FollowingFeedPageState extends State<FollowingFeedPage> {
  final List<_FollowingRecord> _records = [
    const _FollowingRecord(
      username: 'ali.rezaei',
      name: 'علی رضایی',
      habit: 'باشگاه',
      caption: 'امروز هم تمرین انجام شد. حتی وقتی حوصله نداری، فقط شروع کن.',
      time: '۱۰ دقیقه پیش',
      likes: 184,
      comments: 23,
    ),
    const _FollowingRecord(
      username: 'sara.m',
      name: 'سارا محمدی',
      habit: 'مطالعه روزانه',
      caption: 'امروز ۳۰ صفحه مطالعه کردم. کم‌کم این عادت داره تبدیل به بخشی از روزم میشه.',
      time: '۱ ساعت پیش',
      likes: 327,
      comments: 41,
    ),
    const _FollowingRecord(
      username: 'negar.k',
      name: 'نگار کریمی',
      habit: 'یادگیری زبان',
      caption: 'امروز فقط ۲۰ دقیقه تمرین کردم، ولی مهم اینه که زنجیره رو نشکنم.',
      time: '۳ ساعت پیش',
      likes: 241,
      comments: 28,
    ),
    const _FollowingRecord(
      username: 'mohammad.a',
      name: 'محمد احمدی',
      habit: 'پیاده‌روی روزانه',
      caption: 'بعد از کار یک پیاده‌روی کوتاه داشتم. انرژی خیلی بیشتری پیدا کردم.',
      time: '۵ ساعت پیش',
      likes: 96,
      comments: 12,
    ),
    const _FollowingRecord(
      username: 'amir.h',
      name: 'امیر حسین',
      habit: 'خواب منظم',
      caption: 'هفتمین شب پشت سر هم که قبل از نیمه‌شب خوابیدم.',
      time: 'دیروز',
      likes: 153,
      comments: 19,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('دنبال‌شده‌ها'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'تنظیمات فید',
            onPressed: _showFeedOptions,
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
      body: _records.isEmpty
          ? _buildEmptyState(context)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: _records.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildRecordCard(
                  context,
                  _records[index],
                );
              },
            ),
    );
  }

  Widget _buildRecordCard(
    BuildContext context,
    _FollowingRecord record,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(6, 6),
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.65),
            blurRadius: 12,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RecordDetailPage(
                  username: record.username,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAuthor(context, record),
                const SizedBox(height: 14),
                _buildHabitChip(context, record.habit),
                const SizedBox(height: 12),
                Text(
                  record.caption,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/images/post.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _buildAction(
                      context,
                      Icons.favorite_border_rounded,
                      record.likes.toString(),
                    ),
                    const SizedBox(width: 20),
                    _buildAction(
                      context,
                      Icons.chat_bubble_outline_rounded,
                      record.comments.toString(),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'ذخیره',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('رکورد ذخیره شد.'),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.bookmark_border_rounded,
                      ),
                    ),
                    IconButton(
                      tooltip: 'اشتراک‌گذاری',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('اشتراک‌گذاری به‌زودی اضافه می‌شود.'),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.share_outlined,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthor(
    BuildContext context,
    _FollowingRecord record,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        const CircleAvatar(
          radius: 23,
          backgroundImage: AssetImage(
            'assets/images/man.jpg',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                record.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '@${record.username} • ${record.time}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'گزینه‌ها',
          onPressed: () => _showRecordOptions(record),
          icon: const Icon(Icons.more_horiz_rounded),
        ),
      ],
    );
  }

  Widget _buildHabitChip(
    BuildContext context,
    String habit,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.track_changes_rounded,
            size: 17,
            color: colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 6),
          Text(
            habit,
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction(
    BuildContext context,
    IconData icon,
    String value,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 19,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
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
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.15),
                    blurRadius: 18,
                    offset: const Offset(7, 7),
                  ),
                  BoxShadow(
                    color: colorScheme.surfaceContainerHighest,
                    blurRadius: 14,
                    offset: const Offset(-5, -5),
                  ),
                ],
              ),
              child: Icon(
                Icons.people_outline_rounded,
                size: 42,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'هنوز کسی را دنبال نمی‌کنی',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'افرادی را که مسیر رشدشان برایت جالب است دنبال کن تا رکوردهایشان را اینجا ببینی.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRecordOptions(_FollowingRecord record) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.bookmark_border_rounded),
                title: const Text('ذخیره رکورد'),
                onTap: () {
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(
                      content: Text('رکورد ذخیره شد.'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_remove_outlined),
                title: Text('لغو دنبال کردن ${record.name}'),
                onTap: () {
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${record.name} دیگر دنبال نمی‌شود.',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.flag_outlined),
                title: const Text('گزارش رکورد'),
                onTap: () {
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'صفحه گزارش به‌زودی باز می‌شود.',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFeedOptions() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final theme = Theme.of(context);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تنظیمات فید',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.schedule_rounded),
                  title: const Text('جدیدترین رکوردها'),
                  subtitle: const Text(
                    'رکوردهای جدیدتر را بالاتر نمایش بده',
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.auto_awesome_rounded),
                  title: const Text('مرتبط‌ترین رکوردها'),
                  subtitle: const Text(
                    'محتوای مرتبط با عادت‌ها و علایقت را نمایش بده',
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FollowingRecord {
  final String username;
  final String name;
  final String habit;
  final String caption;
  final String time;
  final int likes;
  final int comments;

  const _FollowingRecord({
    required this.username,
    required this.name,
    required this.habit,
    required this.caption,
    required this.time,
    required this.likes,
    required this.comments,
  });
}