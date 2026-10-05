import 'package:flutter/material.dart';

class AdminAnalyticsPage extends StatefulWidget {
  const AdminAnalyticsPage({super.key});

  @override
  State<AdminAnalyticsPage> createState() => _AdminAnalyticsPageState();
}

class _AdminAnalyticsPageState extends State<AdminAnalyticsPage> {
  String _selectedPeriod = '۷ روز';

  final List<String> _periods = const [
    '۷ روز',
    '۳۰ روز',
    '۳ ماه',
    '۱ سال',
  ];

  final List<_MetricData> _userGrowth = const [
    _MetricData(label: 'شنبه', value: 42),
    _MetricData(label: 'یکشنبه', value: 58),
    _MetricData(label: 'دوشنبه', value: 51),
    _MetricData(label: 'سه‌شنبه', value: 74),
    _MetricData(label: 'چهارشنبه', value: 68),
    _MetricData(label: 'پنجشنبه', value: 92),
    _MetricData(label: 'جمعه', value: 81),
  ];

  final List<_MetricData> _recordActivity = const [
    _MetricData(label: 'شنبه', value: 68),
    _MetricData(label: 'یکشنبه', value: 82),
    _MetricData(label: 'دوشنبه', value: 74),
    _MetricData(label: 'سه‌شنبه', value: 96),
    _MetricData(label: 'چهارشنبه', value: 88),
    _MetricData(label: 'پنجشنبه', value: 112),
    _MetricData(label: 'جمعه', value: 104),
  ];

  final List<_HabitPerformance> _topHabits = const [
    _HabitPerformance(
      name: 'باشگاه',
      members: 12400,
      records: 48700,
      growth: 18,
    ),
    _HabitPerformance(
      name: 'مطالعه روزانه',
      members: 9600,
      records: 42100,
      growth: 14,
    ),
    _HabitPerformance(
      name: 'پیاده‌روی روزانه',
      members: 8400,
      records: 31600,
      growth: 11,
    ),
    _HabitPerformance(
      name: 'مدیتیشن',
      members: 7100,
      records: 28900,
      growth: 9,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('آمار و تحلیل'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _buildPeriodSelector(context),
          const SizedBox(height: 16),
          _buildOverviewGrid(context),
          const SizedBox(height: 20),
          _buildSectionTitle(
            context,
            'رشد کاربران',
            'کاربران جدید در بازه انتخاب‌شده',
          ),
          const SizedBox(height: 12),
          _buildChartCard(
            context,
            data: _userGrowth,
            unit: 'کاربر',
          ),
          const SizedBox(height: 20),
          _buildSectionTitle(
            context,
            'فعالیت رکوردها',
            'تعداد رکوردهای ثبت‌شده',
          ),
          const SizedBox(height: 12),
          _buildChartCard(
            context,
            data: _recordActivity,
            unit: 'رکورد',
          ),
          const SizedBox(height: 20),
          _buildSectionTitle(
            context,
            'محبوب‌ترین عادت‌ها',
            'بر اساس تعداد اعضا و رکوردها',
          ),
          const SizedBox(height: 12),
          _buildTopHabits(context),
          const SizedBox(height: 20),
          _buildSectionTitle(
            context,
            'شاخص‌های محصول',
            'وضعیت کلی فعالیت کاربران',
          ),
          const SizedBox(height: 12),
          _buildProductMetrics(context),
          const SizedBox(height: 20),
          _buildSectionTitle(
            context,
            'HabitaCoin',
            'فعالیت اقتصادی کاربران',
          ),
          const SizedBox(height: 12),
          _buildCoinMetrics(context),
          const SizedBox(height: 20),
          _buildInsightCard(context),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _periods.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final period = _periods[index];

          return ChoiceChip(
            label: Text(period),
            selected: period == _selectedPeriod,
            onSelected: (_) {
              setState(() {
                _selectedPeriod = period;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildOverviewGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.55,
      children: [
        _buildMetricCard(
          context,
          title: 'کاربران',
          value: '24.8K',
          change: '+12.4%',
          icon: Icons.people_alt_outlined,
        ),
        _buildMetricCard(
          context,
          title: 'رکوردها',
          value: '186K',
          change: '+18.7%',
          icon: Icons.article_outlined,
        ),
        _buildMetricCard(
          context,
          title: 'عادت‌های فعال',
          value: '428',
          change: '+8.2%',
          icon: Icons.track_changes_rounded,
        ),
        _buildMetricCard(
          context,
          title: 'چالش‌ها',
          value: '36',
          change: '+5.1%',
          icon: Icons.emoji_events_outlined,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required String change,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.10),
            blurRadius: 14,
            offset: const Offset(5, 5),
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
            blurRadius: 10,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
            size: 22,
          ),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                change,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard(
    BuildContext context, {
    required List<_MetricData> data,
    required String unit,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final maxValue = data
        .map((item) => item.value)
        .reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
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
            color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
            blurRadius: 10,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 190,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.map((item) {
                final ratio = item.value / maxValue;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${item.value}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              heightFactor: ratio,
                              child: Container(
                                width: 22,
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.label,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'واحد: $unit',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHabits(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
            color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
            blurRadius: 10,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(
          _topHabits.length,
          (index) {
            final habit = _topHabits[index];

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              habit.name,
                              style:
                                  theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_formatNumber(habit.members)} عضو • '
                              '${_formatNumber(habit.records)} رکورد',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.trending_up_rounded,
                            size: 19,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '+${habit.growth}%',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (index < _topHabits.length - 1)
                  Divider(
                    height: 1,
                    indent: 66,
                    endIndent: 16,
                    color: colorScheme.outlineVariant,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductMetrics(BuildContext context) {
    return Container(
      decoration: _cardDecoration(context),
      child: Column(
        children: [
          _buildMetricRow(
            context,
            icon: Icons.login_rounded,
            title: 'بازگشت کاربران',
            value: '68%',
            progress: 0.68,
          ),
          _buildMetricRow(
            context,
            icon: Icons.local_fire_department_outlined,
            title: 'کاربران دارای streak',
            value: '54%',
            progress: 0.54,
          ),
          _buildMetricRow(
            context,
            icon: Icons.add_task_rounded,
            title: 'کاربران ثبت‌کننده رکورد',
            value: '72%',
            progress: 0.72,
          ),
          _buildMetricRow(
            context,
            icon: Icons.emoji_events_outlined,
            title: 'مشارکت در چالش‌ها',
            value: '41%',
            progress: 0.41,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required double progress,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 21,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              Text(
                value,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildCoinMetrics(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(context),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildCoinStat(
                  context,
                  'توزیع‌شده',
                  '4.8M HBC',
                  Icons.add_circle_outline,
                ),
              ),
              Expanded(
                child: _buildCoinStat(
                  context,
                  'خرج‌شده',
                  '1.7M HBC',
                  Icons.remove_circle_outline,
                ),
              ),
            ],
          ),
          Divider(
            height: 28,
            color: colorScheme.outlineVariant,
          ),
          Row(
            children: [
              Expanded(
                child: _buildCoinStat(
                  context,
                  'تراکنش‌ها',
                  '82.4K',
                  Icons.receipt_long_outlined,
                ),
              ),
              Expanded(
                child: _buildCoinStat(
                  context,
                  'میانگین روزانه',
                  '18.2K',
                  Icons.trending_up_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoinStat(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          color: colorScheme.primary,
          size: 22,
        ),
        const SizedBox(height: 7),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.auto_awesome_outlined,
            color: colorScheme.onPrimaryContainer,
            size: 27,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'بینش مهم',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'فعالیت کاربران در پنجشنبه و جمعه بیشتر است. '
                  'باشگاه و مطالعه روزانه بیشترین رشد را در بازه '
                  'انتخاب‌شده داشته‌اند.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BoxDecoration(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: colorScheme.shadow.withOpacity(0.10),
          blurRadius: 14,
          offset: const Offset(5, 5),
        ),
        BoxShadow(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
          blurRadius: 10,
          offset: const Offset(-4, -4),
        ),
      ],
    );
  }

  String _formatNumber(int value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }

    return value.toString();
  }
}

class _MetricData {
  final String label;
  final int value;

  const _MetricData({
    required this.label,
    required this.value,
  });
}

class _HabitPerformance {
  final String name;
  final int members;
  final int records;
  final int growth;

  const _HabitPerformance({
    required this.name,
    required this.members,
    required this.records,
    required this.growth,
  });
}