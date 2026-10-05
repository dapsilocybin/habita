import 'package:flutter/material.dart';

class HabitProgressPage extends StatelessWidget {
  final String? habitName;

  const HabitProgressPage({
    super.key,
    this.habitName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final name = habitName ?? 'باشگاه';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('آمار پیشرفت'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HabitHeader(
                habitName: name,
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 20),
              _OverviewCard(
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 28),
              Text(
                'پیشرفت هفتگی',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              _WeeklyProgressCard(
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 28),
              Text(
                'آمار کلی',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              _StatsGrid(
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 28),
              Text(
                'روند پیشرفت',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              _ProgressChart(
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 28),
              Text(
                'تحلیل عادت',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              _InsightCard(
                theme: theme,
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HabitHeader extends StatelessWidget {
  final String habitName;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _HabitHeader({
    required this.habitName,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.14),
            blurRadius: 20,
            offset: const Offset(8, 8),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 20,
            offset: const Offset(-8, -8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.fitness_center_rounded,
              size: 30,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habitName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'آمار و روند عملکرد شما',
                  style: theme.textTheme.bodyMedium?.copyWith(
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
}

class _OverviewCard extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _OverviewCard({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.surfaceContainerHighest,
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.16),
            blurRadius: 22,
            offset: const Offset(8, 8),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 22,
            offset: const Offset(-8, -8),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 94,
            height: 94,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 94,
                  height: 94,
                  child: CircularProgressIndicator(
                    value: 0.82,
                    strokeWidth: 9,
                    backgroundColor:
                        colorScheme.surface.withOpacity(0.7),
                    valueColor: AlwaysStoppedAnimation(
                      colorScheme.primary,
                    ),
                  ),
                ),
                Text(
                  '82%',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عملکرد عالی!',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'در این ماه ۸۲٪ از هدف خود را انجام داده‌اید.',
                  style: theme.textTheme.bodyMedium?.copyWith(
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
}

class _WeeklyProgressCard extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _WeeklyProgressCard({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    const days = [
      ('ش', true),
      ('ی', true),
      ('د', true),
      ('س', true),
      ('چ', false),
      ('پ', true),
      ('ج', false),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.11),
            blurRadius: 18,
            offset: const Offset(7, 7),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 18,
            offset: const Offset(-7, -7),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '۵ از ۷ روز',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '۷۱٪',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((day) {
              final completed = day.$2;

              return Column(
                children: [
                  Text(
                    day.$1,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: completed
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                    child: completed
                        ? Icon(
                            Icons.check_rounded,
                            size: 19,
                            color: colorScheme.onPrimary,
                          )
                        : null,
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _StatsGrid({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    const stats = [
      ('رکوردها', '۴۸', Icons.article_rounded),
      ('تداوم', '۸۶٪', Icons.trending_up_rounded),
      ('رکورد متوالی', '۱۲ روز', Icons.local_fire_department_rounded),
      ('بهترین رکورد', '۲۴ روز', Icons.emoji_events_rounded),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (context, index) {
        final stat = stats[index];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.10),
                blurRadius: 14,
                offset: const Offset(5, 5),
              ),
              BoxShadow(
                color: colorScheme.surface.withOpacity(0.8),
                blurRadius: 14,
                offset: const Offset(-5, -5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                stat.$3,
                color: colorScheme.primary,
                size: 25,
              ),
              const Spacer(),
              Text(
                stat.$2,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                stat.$1,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressChart extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _ProgressChart({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    const values = [0.45, 0.55, 0.48, 0.68, 0.62, 0.78, 0.82];

    return Container(
      height: 230,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.11),
            blurRadius: 18,
            offset: const Offset(7, 7),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 18,
            offset: const Offset(-7, -7),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '۷ روز اخیر',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.trending_up_rounded,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Text(
                '+۱۸٪',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(values.length, (index) {
                final value = values[index];

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${(value * 100).round()}%',
                          style: theme.textTheme.labelSmall,
                        ),
                        const SizedBox(height: 6),
                        FractionallySizedBox(
                          heightFactor: value,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${index + 1}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _InsightCard({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.11),
            blurRadius: 18,
            offset: const Offset(7, 7),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 18,
            offset: const Offset(-7, -7),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'بینش این هفته',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'شما در نیمه دوم هفته عملکرد بهتری داشته‌اید. '
            'اگر همین روند را ادامه دهید، احتمالاً رکورد فعلی '
            'خود را بهبود خواهید داد.',
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.7,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'پیشنهاد: هدف هفته آینده را ۶ روز قرار دهید.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}