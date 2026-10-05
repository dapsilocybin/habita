import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('آمار و تحلیل'),
          centerTitle: false,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              _buildOverview(theme),
              const SizedBox(height: 24),
              _buildSectionTitle(theme, 'روند فعالیت'),
              const SizedBox(height: 12),
              _buildActivityChart(theme),
              const SizedBox(height: 24),
              _buildSectionTitle(theme, 'عملکرد عادت‌ها'),
              const SizedBox(height: 12),
              _buildHabitPerformance(theme),
              const SizedBox(height: 24),
              _buildSectionTitle(theme, 'تحلیل مسیر'),
              const SizedBox(height: 12),
              _buildInsights(theme),
              const SizedBox(height: 24),
              _buildSectionTitle(theme, 'روزهای فعال'),
              const SizedBox(height: 12),
              _buildActiveDays(theme),
              const SizedBox(height: 24),
              _buildMonthlySummary(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverview(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.12),
        ),
      ),
      child: Column(
        children: [
          Text(
            'عملکرد این ماه',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: CircularProgressIndicator(
                        value: 0.78,
                        strokeWidth: 10,
                        backgroundColor:
                            colorScheme.primary.withOpacity(0.10),
                        color: colorScheme.primary,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '۷۸٪',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        Text(
                          'پیشرفت',
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'این ماه نسبت به ماه قبل ۱۲٪ بهتر عمل کرده‌ای.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    ThemeData theme,
    String title,
  ) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildActivityChart(ThemeData theme) {
    final values = [0.45, 0.65, 0.38, 0.82, 0.70, 0.92, 0.58];
    final labels = [
      'ش',
      'ی',
      'د',
      'س',
      'چ',
      'پ',
      'ج',
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      decoration: _cardDecoration(theme),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'رکوردهای روزانه',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '۷ روز گذشته',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 190,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                values.length,
                (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${(values[index] * 10).round()}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FractionallySizedBox(
                                heightFactor: values[index],
                                child: Container(
                                  width: 24,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            labels[index],
                            style: theme.textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitPerformance(ThemeData theme) {
    final habits = [
      _HabitStatistic(
        name: 'یادگیری زبان',
        progress: 0.94,
        records: 103,
        streak: 21,
      ),
      _HabitStatistic(
        name: 'باشگاه',
        progress: 0.86,
        records: 48,
        streak: 12,
      ),
      _HabitStatistic(
        name: 'مطالعه روزانه',
        progress: 0.79,
        records: 76,
        streak: 8,
      ),
      _HabitStatistic(
        name: 'خواب منظم',
        progress: 0.64,
        records: 32,
        streak: 5,
      ),
    ];

    return Column(
      children: habits.map((habit) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildHabitStatisticCard(
            theme,
            habit,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHabitStatisticCard(
    ThemeData theme,
    _HabitStatistic habit,
  ) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _cardDecoration(theme),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  habit.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${(habit.progress * 100).round()}٪',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: habit.progress,
              minHeight: 8,
              backgroundColor: colorScheme.primary.withOpacity(0.10),
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildSmallStat(
                theme,
                Icons.article_outlined,
                '${habit.records}',
                'رکورد',
              ),
              const SizedBox(width: 20),
              _buildSmallStat(
                theme,
                Icons.local_fire_department_outlined,
                '${habit.streak}',
                'روز متوالی',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStat(
    ThemeData theme,
    IconData icon,
    String value,
    String label,
  ) {
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 17,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 5),
        Text(
          '$value $label',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildInsights(ThemeData theme) {
    final insights = [
      _Insight(
        icon: Icons.trending_up_rounded,
        title: 'بهترین عملکرد',
        text: 'یادگیری زبان در حال حاضر قوی‌ترین عادت توست.',
      ),
      _Insight(
        icon: Icons.schedule_rounded,
        title: 'زمان مناسب',
        text: 'بیشتر رکوردهای موفق تو در ساعات صبح ثبت شده‌اند.',
      ),
      _Insight(
        icon: Icons.local_fire_department_rounded,
        title: 'روند مثبت',
        text: 'رکوردهای تو در سه هفته اخیر روند صعودی داشته‌اند.',
      ),
      _Insight(
        icon: Icons.lightbulb_outline_rounded,
        title: 'پیشنهاد',
        text: 'برای خواب منظم هدف کوچک‌تری تعیین کن تا استمرار بیشتر شود.',
      ),
    ];

    return Column(
      children: insights.map((insight) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _buildInsightCard(
            theme,
            insight,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInsightCard(
    ThemeData theme,
    _Insight insight,
  ) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _cardDecoration(theme),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              insight.icon,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  insight.text,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveDays(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    final days = [
      _DayActivity('شنبه', 0.45),
      _DayActivity('یکشنبه', 0.70),
      _DayActivity('دوشنبه', 0.85),
      _DayActivity('سه‌شنبه', 0.62),
      _DayActivity('چهارشنبه', 0.92),
      _DayActivity('پنجشنبه', 0.76),
      _DayActivity('جمعه', 0.38),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(theme),
      child: Column(
        children: days.map((day) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 65,
                  child: Text(
                    day.name,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: day.activity,
                      minHeight: 9,
                      backgroundColor:
                          colorScheme.primary.withOpacity(0.08),
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 35,
                  child: Text(
                    '${(day.activity * 100).round()}٪',
                    textAlign: TextAlign.end,
                    style: theme.textTheme.labelSmall,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMonthlySummary(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    final stats = [
      _SummaryStat(
        icon: Icons.article_outlined,
        value: '۴۲',
        label: 'رکورد این ماه',
      ),
      _SummaryStat(
        icon: Icons.local_fire_department_outlined,
        value: '۲۱',
        label: 'بهترین استریک',
      ),
      _SummaryStat(
        icon: Icons.emoji_events_outlined,
        value: '۴',
        label: 'چالش تکمیل‌شده',
      ),
      _SummaryStat(
        icon: Icons.monetization_on_outlined,
        value: '۲٬۴۸۰',
        label: 'HBC کسب‌شده',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(3, 4),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 8,
            offset: const Offset(-3, -3),
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stats.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 1.35,
        ),
        itemBuilder: (context, index) {
          final stat = stats[index];

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  stat.icon,
                  color: colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(height: 7),
                Text(
                  stat.value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  stat.label,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _cardDecoration(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return BoxDecoration(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: colorScheme.shadow.withOpacity(0.08),
          blurRadius: 12,
          offset: const Offset(3, 4),
        ),
        BoxShadow(
          color: colorScheme.surface.withOpacity(0.8),
          blurRadius: 8,
          offset: const Offset(-3, -3),
        ),
      ],
    );
  }
}

class _HabitStatistic {
  final String name;
  final double progress;
  final int records;
  final int streak;

  const _HabitStatistic({
    required this.name,
    required this.progress,
    required this.records,
    required this.streak,
  });
}

class _Insight {
  final IconData icon;
  final String title;
  final String text;

  const _Insight({
    required this.icon,
    required this.title,
    required this.text,
  });
}

class _DayActivity {
  final String name;
  final double activity;

  const _DayActivity(
    this.name,
    this.activity,
  );
}

class _SummaryStat {
  final IconData icon;
  final String value;
  final String label;

  const _SummaryStat({
    required this.icon,
    required this.value,
    required this.label,
  });
}