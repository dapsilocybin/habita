import 'package:flutter/material.dart';

class AdminRecordVerificationPage extends StatefulWidget {
  const AdminRecordVerificationPage({super.key});

  @override
  State<AdminRecordVerificationPage> createState() =>
      _AdminRecordVerificationPageState();
}

class _AdminRecordVerificationPageState
    extends State<AdminRecordVerificationPage> {
  String _selectedFilter = 'در انتظار';

  final List<_VerificationRecord> _records = [
    const _VerificationRecord(
      id: 'REC-8821',
      username: 'ali.rezaei',
      name: 'علی رضایی',
      habit: 'باشگاه',
      caption:
          'امروز تمرین پا داشتم و با وجود خستگی توانستم برنامه کامل تمرین را انجام بدهم.',
      time: '۱۲ دقیقه پیش',
      communityVotes: 8,
      requiredVotes: 10,
      status: 'در انتظار',
    ),
    const _VerificationRecord(
      id: 'REC-8820',
      username: 'sara.m',
      name: 'سارا محمدی',
      habit: 'مطالعه روزانه',
      caption:
          'امروز ۳۰ صفحه مطالعه کردم و نکته‌های مهم کتاب را یادداشت کردم.',
      time: '۳۵ دقیقه پیش',
      communityVotes: 10,
      requiredVotes: 10,
      status: 'تأیید شده',
    ),
    const _VerificationRecord(
      id: 'REC-8819',
      username: 'mohammad.a',
      name: 'محمد احمدی',
      habit: 'یادگیری زبان',
      caption:
          'امروز ۴۵ دقیقه روی لغات و شنیداری زبان انگلیسی کار کردم.',
      time: '۱ ساعت پیش',
      communityVotes: 6,
      requiredVotes: 10,
      status: 'در انتظار',
    ),
    const _VerificationRecord(
      id: 'REC-8818',
      username: 'negar.k',
      name: 'نگار کریمی',
      habit: 'خواب منظم',
      caption:
          'دیشب قبل از ساعت ۱۲ خوابیدم و صبح طبق برنامه بیدار شدم.',
      time: '۲ ساعت پیش',
      communityVotes: 2,
      requiredVotes: 10,
      status: 'رد شده',
    ),
    const _VerificationRecord(
      id: 'REC-8817',
      username: 'amir.h',
      name: 'امیر حسین',
      habit: 'پیاده‌روی روزانه',
      caption:
          'امروز بعد از کار حدود ۴۵ دقیقه پیاده‌روی کردم.',
      time: '۳ ساعت پیش',
      communityVotes: 9,
      requiredVotes: 10,
      status: 'در انتظار',
    ),
  ];

  final List<String> _filters = const [
    'در انتظار',
    'تأیید شده',
    'رد شده',
    'همه',
  ];

  List<_VerificationRecord> get _filteredRecords {
    if (_selectedFilter == 'همه') {
      return _records;
    }

    return _records
        .where((record) => record.status == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تأیید رکوردها'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildInfoCard(context),
          _buildFilters(context),
          Expanded(
            child: _filteredRecords.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: _filteredRecords.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 14),
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

  Widget _buildInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Icon(
              Icons.verified_user_outlined,
              color: colorScheme.onPrimaryContainer,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'رکوردهایی که نیاز به بررسی انسانی دارند از این بخش تأیید یا رد می‌شوند.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
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

          return ChoiceChip(
            label: Text(filter),
            selected: filter == _selectedFilter,
            onSelected: (_) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildRecordCard(
    BuildContext context,
    _VerificationRecord record,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final progress =
        (record.communityVotes / record.requiredVotes).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.10),
            blurRadius: 14,
            offset: const Offset(5, 5),
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                _buildStatusBadge(context, record.status),
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
              style: theme.textTheme.bodyMedium?.copyWith(
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
            const SizedBox(height: 16),
            Text(
              'تأیید جامعه',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${record.communityVotes}/${record.requiredVotes}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (record.status == 'در انتظار')
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _rejectRecord(record),
                      icon: const Icon(Icons.close_rounded),
                      label: const Text('رد کردن'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _approveRecord(record),
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('تأیید'),
                    ),
                  ),
                ],
              )
            else
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _openRecordDetails(record),
                  icon: const Icon(Icons.visibility_outlined),
                  label: const Text('مشاهده جزئیات'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    BuildContext context,
    String status,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color background;
    Color foreground;

    switch (status) {
      case 'تأیید شده':
        background = colorScheme.primaryContainer;
        foreground = colorScheme.onPrimaryContainer;
        break;
      case 'رد شده':
        background = colorScheme.errorContainer;
        foreground = colorScheme.onErrorContainer;
        break;
      default:
        background = colorScheme.secondaryContainer;
        foreground = colorScheme.onSecondaryContainer;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: theme.textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.bold,
        ),
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
              Icons.verified_rounded,
              size: 70,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 18),
            Text(
              'رکوردی برای بررسی وجود ندارد',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'در این دسته رکوردی برای بررسی پیدا نشد.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _approveRecord(_VerificationRecord record) {
    setState(() {
      final index = _records.indexOf(record);

      if (index != -1) {
        _records[index] = _VerificationRecord(
          id: record.id,
          username: record.username,
          name: record.name,
          habit: record.habit,
          caption: record.caption,
          time: record.time,
          communityVotes: record.communityVotes,
          requiredVotes: record.requiredVotes,
          status: 'تأیید شده',
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('رکورد با موفقیت تأیید شد.'),
      ),
    );
  }

  void _rejectRecord(_VerificationRecord record) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('رد رکورد'),
          content: const Text(
            'آیا مطمئنی می‌خواهی این رکورد را رد کنی؟',
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
                  final index = _records.indexOf(record);

                  if (index != -1) {
                    _records[index] = _VerificationRecord(
                      id: record.id,
                      username: record.username,
                      name: record.name,
                      habit: record.habit,
                      caption: record.caption,
                      time: record.time,
                      communityVotes: record.communityVotes,
                      requiredVotes: record.requiredVotes,
                      status: 'رد شده',
                    );
                  }
                });

                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text('رکورد رد شد.'),
                  ),
                );
              },
              child: const Text('رد کردن'),
            ),
          ],
        );
      },
    );
  }

  void _openRecordDetails(_VerificationRecord record) {
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
                  'جزئیات رکورد',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailRow(
                  context,
                  'شناسه',
                  record.id,
                ),
                _buildDetailRow(
                  context,
                  'کاربر',
                  '@${record.username}',
                ),
                _buildDetailRow(
                  context,
                  'عادت',
                  record.habit,
                ),
                _buildDetailRow(
                  context,
                  'تأیید جامعه',
                  '${record.communityVotes}/${record.requiredVotes}',
                ),
                _buildDetailRow(
                  context,
                  'وضعیت',
                  record.status,
                ),
                const SizedBox(height: 12),
                Text(
                  record.caption,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            '$label:',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerificationRecord {
  final String id;
  final String username;
  final String name;
  final String habit;
  final String caption;
  final String time;
  final int communityVotes;
  final int requiredVotes;
  final String status;

  const _VerificationRecord({
    required this.id,
    required this.username,
    required this.name,
    required this.habit,
    required this.caption,
    required this.time,
    required this.communityVotes,
    required this.requiredVotes,
    required this.status,
  });
}