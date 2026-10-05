import 'package:flutter/material.dart';

import '../record_detail/record_detail_page.dart';

class MyRecordsPage extends StatefulWidget {
  const MyRecordsPage({super.key});

  @override
  State<MyRecordsPage> createState() => _MyRecordsPageState();
}

class _MyRecordsPageState extends State<MyRecordsPage> {
  String _selectedFilter = 'همه';

  final List<_MyRecord> _records = [
    const _MyRecord(
      habit: 'باشگاه',
      caption: 'امروز تمرینم را کامل انجام دادم، حتی با اینکه انرژی زیادی نداشتم.',
      time: '۲ ساعت پیش',
      likes: 184,
      comments: 23,
    ),
    const _MyRecord(
      habit: 'یادگیری زبان',
      caption: 'امروز ۳۰ دقیقه برای یادگیری زبان وقت گذاشتم.',
      time: 'دیروز',
      likes: 126,
      comments: 14,
    ),
    const _MyRecord(
      habit: 'مطالعه روزانه',
      caption: '۲۰ صفحه از کتابی که شروع کرده بودم را خواندم.',
      time: '۲ روز پیش',
      likes: 94,
      comments: 11,
    ),
    const _MyRecord(
      habit: 'خواب منظم',
      caption: 'دیشب قبل از ساعت ۱۲ خوابیدم و صبح هم طبق برنامه بیدار شدم.',
      time: '۳ روز پیش',
      likes: 76,
      comments: 8,
    ),
    const _MyRecord(
      habit: 'پیاده‌روی روزانه',
      caption: 'امروز ۴۵ دقیقه پیاده‌روی کردم و احساس خیلی بهتری داشتم.',
      time: '۵ روز پیش',
      likes: 112,
      comments: 17,
    ),
    const _MyRecord(
      habit: 'باشگاه',
      caption: 'یک جلسه دیگر هم انجام شد. مهم این است که زنجیره را قطع نکنیم.',
      time: '۶ روز پیش',
      likes: 203,
      comments: 31,
    ),
  ];

  List<String> get _filters {
    final habits = _records.map((record) => record.habit).toSet().toList();

    return [
      'همه',
      ...habits,
    ];
  }

  List<_MyRecord> get _filteredRecords {
    if (_selectedFilter == 'همه') {
      return _records;
    }

    return _records
        .where((record) => record.habit == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('رکوردهای من'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSummary(context),
          _buildFilters(context),
          Expanded(
            child: _filteredRecords.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: _filteredRecords.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return _buildRecordCard(
                        context,
                        _filteredRecords[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(18),
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
        child: Row(
          children: [
            Expanded(
              child: _buildSummaryItem(
                context,
                icon: Icons.edit_note_rounded,
                value: '${_records.length}',
                label: 'کل رکوردها',
              ),
            ),
            Container(
              width: 1,
              height: 44,
              color: colorScheme.outlineVariant,
            ),
            Expanded(
              child: _buildSummaryItem(
                context,
                icon: Icons.favorite_rounded,
                value: '795',
                label: 'پسندها',
              ),
            ),
            Container(
              width: 1,
              height: 44,
              color: colorScheme.outlineVariant,
            ),
            Expanded(
              child: _buildSummaryItem(
                context,
                icon: Icons.local_fire_department_rounded,
                value: '21',
                label: 'بهترین استریک',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          size: 22,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 58,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final selected = filter == _selectedFilter;

          return ChoiceChip(
            label: Text(filter),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedFilter = filter;
              });
            },
            avatar: selected
                ? Icon(
                    Icons.check_rounded,
                    size: 17,
                    color: colorScheme.onPrimaryContainer,
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _buildRecordCard(
    BuildContext context,
    _MyRecord record,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.13),
            blurRadius: 15,
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
                builder: (_) => const RecordDetailPage(
                  username: 'mostafa',
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
                      radius: 22,
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
                            'مصطفی',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            record.time,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'delete') {
                          _deleteRecord(record);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline_rounded),
                              SizedBox(width: 10),
                              Text('حذف رکورد'),
                            ],
                          ),
                        ),
                      ],
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
                    Text(
                      'مشاهده',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_left_rounded,
                      size: 20,
                      color: colorScheme.primary,
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
          size: 18,
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
              width: 90,
              height: 90,
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
                Icons.edit_note_rounded,
                size: 42,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'هنوز رکوردی ثبت نکرده‌ای',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'اولین قدم خودت را ثبت کن و مسیر پیشرفتت را شروع کن.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('صفحه ثبت رکورد به‌زودی باز می‌شود.'),
                  ),
                );
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('ثبت رکورد'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteRecord(_MyRecord record) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('حذف رکورد'),
          content: const Text(
            'آیا مطمئنی می‌خواهی این رکورد را حذف کنی؟',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('انصراف'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();

                setState(() {
                  _records.remove(record);
                });

                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text('رکورد حذف شد.'),
                  ),
                );
              },
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }
}

class _MyRecord {
  final String habit;
  final String caption;
  final String time;
  final int likes;
  final int comments;

  const _MyRecord({
    required this.habit,
    required this.caption,
    required this.time,
    required this.likes,
    required this.comments,
  });
}