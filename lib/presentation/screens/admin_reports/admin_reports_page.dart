import 'package:flutter/material.dart';

class AdminReportsPage extends StatefulWidget {
  const AdminReportsPage({super.key});

  @override
  State<AdminReportsPage> createState() => _AdminReportsPageState();
}

class _AdminReportsPageState extends State<AdminReportsPage> {
  String _selectedFilter = 'همه';

  final List<_AdminReport> _reports = [
    const _AdminReport(
      id: 'R-1024',
      type: 'محتوا',
      title: 'محتوای نامناسب',
      description: 'این رکورد با قوانین جامعه سازگار نیست.',
      reporter: 'sara.m',
      target: 'ali.rezaei',
      time: '۱۲ دقیقه پیش',
      priority: 'بالا',
      status: 'در انتظار',
    ),
    const _AdminReport(
      id: 'R-1023',
      type: 'کاربر',
      title: 'رفتار نامناسب',
      description: 'کاربر چندین بار پیام نامناسب ارسال کرده است.',
      reporter: 'mohammad.a',
      target: 'user_4582',
      time: '۲۵ دقیقه پیش',
      priority: 'بالا',
      status: 'در انتظار',
    ),
    const _AdminReport(
      id: 'R-1022',
      type: 'محتوا',
      title: 'رکورد غیرمرتبط',
      description: 'رکورد با عادت انتخاب‌شده ارتباطی ندارد.',
      reporter: 'negar.k',
      target: 'record_8821',
      time: '۱ ساعت پیش',
      priority: 'متوسط',
      status: 'در حال بررسی',
    ),
    const _AdminReport(
      id: 'R-1021',
      type: 'کاربر',
      title: 'اسپم',
      description: 'ارسال مکرر محتوای تبلیغاتی.',
      reporter: 'amir.h',
      target: 'user_3921',
      time: '۳ ساعت پیش',
      priority: 'متوسط',
      status: 'در انتظار',
    ),
    const _AdminReport(
      id: 'R-1020',
      type: 'محتوا',
      title: 'اطلاعات گمراه‌کننده',
      description: 'محتوا شامل ادعاهای تأییدنشده است.',
      reporter: 'ali.rezaei',
      target: 'record_7732',
      time: 'دیروز',
      priority: 'پایین',
      status: 'حل‌شده',
    ),
  ];

  final List<String> _filters = const [
    'همه',
    'در انتظار',
    'در حال بررسی',
    'حل‌شده',
  ];

  List<_AdminReport> get _filteredReports {
    if (_selectedFilter == 'همه') {
      return _reports;
    }

    return _reports
        .where((report) => report.status == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('گزارش‌ها'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSummary(context),
          _buildFilters(context),
          Expanded(
            child: _filteredReports.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: _filteredReports.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildReportCard(
                        context,
                        _filteredReports[index],
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

    final pending = _reports
        .where((report) => report.status == 'در انتظار')
        .length;

    final reviewing = _reports
        .where((report) => report.status == 'در حال بررسی')
        .length;

    final resolved = _reports
        .where((report) => report.status == 'حل‌شده')
        .length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.12),
              blurRadius: 15,
              offset: const Offset(6, 6),
            ),
            BoxShadow(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.65),
              blurRadius: 11,
              offset: const Offset(-4, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildSummaryItem(
                context,
                value: '$pending',
                label: 'در انتظار',
                icon: Icons.pending_actions_rounded,
              ),
            ),
            _buildDivider(context),
            Expanded(
              child: _buildSummaryItem(
                context,
                value: '$reviewing',
                label: 'در بررسی',
                icon: Icons.visibility_outlined,
              ),
            ),
            _buildDivider(context),
            Expanded(
              child: _buildSummaryItem(
                context,
                value: '$resolved',
                label: 'حل‌شده',
                icon: Icons.check_circle_outline_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 1,
      height: 42,
      color: colorScheme.outlineVariant,
    );
  }

  Widget _buildSummaryItem(
    BuildContext context, {
    required String value,
    required String label,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          size: 21,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
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

  Widget _buildReportCard(
    BuildContext context,
    _AdminReport report,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.09),
            blurRadius: 13,
            offset: const Offset(5, 5),
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => _openReport(report),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildTypeIcon(context, report.type),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            report.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            report.id,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildPriorityBadge(context, report.priority),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  report.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 17,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'گزارش‌دهنده: ${report.reporter}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      report.time,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatusBadge(context, report.status),
                    const Spacer(),
                    Text(
                      'مشاهده جزئیات',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Icon(
                      Icons.chevron_left_rounded,
                      size: 18,
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

  Widget _buildTypeIcon(
    BuildContext context,
    String type,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isContent = type == 'محتوا';

    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        isContent
            ? Icons.article_outlined
            : Icons.person_outline_rounded,
        color: colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget _buildPriorityBadge(
    BuildContext context,
    String priority,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isHigh = priority == 'بالا';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: isHigh
            ? colorScheme.errorContainer
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        priority,
        style: theme.textTheme.labelSmall?.copyWith(
          color: isHigh
              ? colorScheme.onErrorContainer
              : colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.bold,
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

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onSecondaryContainer,
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
              Icons.check_circle_outline_rounded,
              size: 72,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 18),
            Text(
              'گزارشی وجود ندارد',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'در این دسته گزارشی برای بررسی وجود ندارد.',
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

  void _openReport(_AdminReport report) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
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
                  report.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  report.id,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 18),
                _buildDetailRow(
                  context,
                  'نوع',
                  report.type,
                ),
                _buildDetailRow(
                  context,
                  'گزارش‌دهنده',
                  report.reporter,
                ),
                _buildDetailRow(
                  context,
                  'هدف',
                  report.target,
                ),
                _buildDetailRow(
                  context,
                  'اولویت',
                  report.priority,
                ),
                _buildDetailRow(
                  context,
                  'وضعیت',
                  report.status,
                ),
                const SizedBox(height: 12),
                Text(
                  report.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                if (report.status != 'حل‌شده')
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _resolveReport(report);
                      },
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('حل کردن گزارش'),
                    ),
                  ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showComingSoon('مشاهده محتوای گزارش‌شده');
                    },
                    icon: const Icon(Icons.open_in_new_rounded),
                    label: const Text('مشاهده مورد گزارش‌شده'),
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

  void _resolveReport(_AdminReport report) {
    setState(() {
      final index = _reports.indexOf(report);

      if (index != -1) {
        _reports[index] = _AdminReport(
          id: report.id,
          type: report.type,
          title: report.title,
          description: report.description,
          reporter: report.reporter,
          target: report.target,
          time: report.time,
          priority: report.priority,
          status: 'حل‌شده',
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('گزارش به‌عنوان حل‌شده ثبت شد.'),
      ),
    );
  }

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message در نسخه مدیریتی کامل می‌شود.'),
      ),
    );
  }
}

class _AdminReport {
  final String id;
  final String type;
  final String title;
  final String description;
  final String reporter;
  final String target;
  final String time;
  final String priority;
  final String status;

  const _AdminReport({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.reporter,
    required this.target,
    required this.time,
    required this.priority,
    required this.status,
  });
}