import 'package:flutter/material.dart';

import '../record_detail/record_detail_page.dart';

class SavedRecordsPage extends StatefulWidget {
  const SavedRecordsPage({super.key});

  @override
  State<SavedRecordsPage> createState() => _SavedRecordsPageState();
}

class _SavedRecordsPageState extends State<SavedRecordsPage> {
  final List<_SavedRecord> _records = [
    const _SavedRecord(
      username: 'ali.rezaei',
      name: 'علی رضایی',
      habit: 'باشگاه',
      caption: 'امروز با اینکه انرژی زیادی نداشتم، تمرینم را کامل انجام دادم.',
      time: '۲ ساعت پیش',
      likes: 184,
      comments: 23,
    ),
    const _SavedRecord(
      username: 'sara.m',
      name: 'سارا محمدی',
      habit: 'مطالعه روزانه',
      caption: 'فقط ۲۰ دقیقه مطالعه در روز می‌تواند بعد از چند ماه تفاوت بزرگی ایجاد کند.',
      time: 'دیروز',
      likes: 327,
      comments: 41,
    ),
    const _SavedRecord(
      username: 'mohammad.a',
      name: 'محمد احمدی',
      habit: 'خواب منظم',
      caption: 'این هفته سعی کردم هر شب تقریباً در یک ساعت مشخص بخوابم.',
      time: '۲ روز پیش',
      likes: 96,
      comments: 12,
    ),
    const _SavedRecord(
      username: 'negar.k',
      name: 'نگار کریمی',
      habit: 'یادگیری زبان',
      caption: 'امروز فقط ۱۵ دقیقه تمرین کردم، اما مهم این بود که زنجیره را قطع نکردم.',
      time: '۳ روز پیش',
      likes: 241,
      comments: 28,
    ),
    const _SavedRecord(
      username: 'ali.rezaei',
      name: 'علی رضایی',
      habit: 'پیاده‌روی روزانه',
      caption: 'گاهی برای شروع یک عادت جدید، فقط باید از خانه بیرون بروی و قدم اول را برداری.',
      time: '۵ روز پیش',
      likes: 152,
      comments: 19,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ذخیره‌شده‌ها'),
        centerTitle: true,
      ),
      body: _records.isEmpty
          ? _buildEmptyState(context)
          : ListView.separated(
              padding: const EdgeInsets.all(16),
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
    _SavedRecord record,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.14),
            blurRadius: 16,
            offset: const Offset(6, 6),
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
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
                Row(
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundImage: const AssetImage(
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
                      tooltip: 'حذف از ذخیره‌شده‌ها',
                      onPressed: () {
                        _removeRecord(record);
                      },
                      icon: Icon(
                        Icons.bookmark_rounded,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
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
                        record.habit,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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
                    _buildStat(
                      context,
                      Icons.favorite_border_rounded,
                      record.likes.toString(),
                    ),
                    const SizedBox(width: 20),
                    _buildStat(
                      context,
                      Icons.chat_bubble_outline_rounded,
                      record.comments.toString(),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.chevron_left_rounded,
                      color: colorScheme.onSurfaceVariant,
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

  Widget _buildStat(
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
                shape: BoxShape.circle,
                color: colorScheme.surface,
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
                Icons.bookmark_border_rounded,
                size: 42,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'هنوز چیزی ذخیره نکرده‌ای',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'رکوردهایی که دوست داری بعداً دوباره ببینی را ذخیره کن.',
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

  void _removeRecord(_SavedRecord record) {
    setState(() {
      _records.remove(record);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('رکورد از ذخیره‌شده‌ها حذف شد.'),
      ),
    );
  }
}

class _SavedRecord {
  final String username;
  final String name;
  final String habit;
  final String caption;
  final String time;
  final int likes;
  final int comments;

  const _SavedRecord({
    required this.username,
    required this.name,
    required this.habit,
    required this.caption,
    required this.time,
    required this.likes,
    required this.comments,
  });
}