import 'package:flutter/material.dart';

class HabitTrackerPage extends StatefulWidget {
  const HabitTrackerPage({super.key});

  @override
  State<HabitTrackerPage> createState() => _HabitTrackerPageState();
}

class _HabitTrackerPageState extends State<HabitTrackerPage> {
  final List<_TrackedHabit> _habits = [
    _TrackedHabit(
      name: 'باشگاه',
      icon: Icons.fitness_center_outlined,
      currentStreak: 12,
      longestStreak: 24,
      weeklyProgress: 5,
      weeklyTarget: 6,
      totalRecords: 48,
    ),
    _TrackedHabit(
      name: 'مطالعه روزانه',
      icon: Icons.menu_book_outlined,
      currentStreak: 8,
      longestStreak: 17,
      weeklyProgress: 6,
      weeklyTarget: 7,
      totalRecords: 76,
    ),
    _TrackedHabit(
      name: 'خواب منظم',
      icon: Icons.bedtime_outlined,
      currentStreak: 5,
      longestStreak: 14,
      weeklyProgress: 4,
      weeklyTarget: 7,
      totalRecords: 32,
    ),
    _TrackedHabit(
      name: 'یادگیری زبان',
      icon: Icons.language_outlined,
      currentStreak: 21,
      longestStreak: 21,
      weeklyProgress: 7,
      weeklyTarget: 7,
      totalRecords: 103,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: const Text('ردیاب عادت‌ها'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.insights_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildOverview(
                context,
                theme,
                colorScheme,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildTodayHeader(
                context,
                theme,
                colorScheme,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _TrackedHabitCard(
                    habit: _habits[index],
                    onTap: () {},
                    onRecordTap: () {},
                  );
                },
                childCount: _habits.length,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildWeeklySummary(
                context,
                theme,
                colorScheme,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildQuickActions(
                context,
                theme,
                colorScheme,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverview(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.14),
              offset: const Offset(8, 8),
              blurRadius: 18,
            ),
            BoxShadow(
              color: colorScheme.surface.withOpacity(0.8),
              offset: const Offset(-7, -7),
              blurRadius: 18,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مسیرت را ادامه بده',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'امروز هم یک قدم کوچک کافی است.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer
                              .withOpacity(0.75),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                _CircularProgress(
                  progress: 0.72,
                  value: '72%',
                ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                _OverviewStat(
                  value: '4',
                  label: 'عادت فعال',
                ),
                _OverviewDivider(),
                _OverviewStat(
                  value: '21',
                  label: 'بهترین استریک',
                ),
                _OverviewDivider(),
                _OverviewStat(
                  value: '259',
                  label: 'رکوردها',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayHeader(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Row(
        children: [
          Text(
            'عادت‌های امروز',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text('مشاهده همه'),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklySummary(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'این هفته',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.08),
                  offset: const Offset(5, 5),
                  blurRadius: 12,
                ),
                BoxShadow(
                  color: colorScheme.surface.withOpacity(0.8),
                  offset: const Offset(-5, -5),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '۲۲ تلاش از ۲۷ تلاش',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '81%',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: 0.81,
                    minHeight: 10,
                    backgroundColor: colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '۵ تلاش دیگر تا رسیدن به هدف هفتگی',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: _QuickAction(
              icon: Icons.account_tree_outlined,
              title: 'درخت عادت‌ها',
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _QuickAction(
              icon: Icons.add_circle_outline,
              title: 'عادت خصوصی',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackedHabitCard extends StatelessWidget {
  final _TrackedHabit habit;
  final VoidCallback onTap;
  final VoidCallback onRecordTap;

  const _TrackedHabitCard({
    required this.habit,
    required this.onTap,
    required this.onRecordTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final progress = habit.weeklyProgress / habit.weeklyTarget;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.08),
                  offset: const Offset(5, 5),
                  blurRadius: 12,
                ),
                BoxShadow(
                  color: colorScheme.surface.withOpacity(0.8),
                  offset: const Offset(-5, -5),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.shadow.withOpacity(0.10),
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                          ),
                          BoxShadow(
                            color: colorScheme.surfaceContainerHighest
                                .withOpacity(0.8),
                            offset: const Offset(-3, -3),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Icon(
                        habit.icon,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            habit.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${habit.totalRecords} رکورد ثبت شده',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onTap,
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    _HabitMiniStat(
                      icon: Icons.local_fire_department_outlined,
                      value: '${habit.currentStreak}',
                      label: 'روز استریک',
                    ),
                    const SizedBox(width: 16),
                    _HabitMiniStat(
                      icon: Icons.emoji_events_outlined,
                      value: '${habit.longestStreak}',
                      label: 'بهترین',
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        onPressed: onRecordTap,
                        child: const Text('ثبت تلاش'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text(
                      'این هفته',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: progress.clamp(0, 1),
                          minHeight: 7,
                          backgroundColor: colorScheme.surface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${habit.weeklyProgress}/${habit.weeklyTarget}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
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
}

class _HabitMiniStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _HabitMiniStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CircularProgress extends StatelessWidget {
  final double progress;
  final String value;

  const _CircularProgress({
    required this.progress,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 82,
      height: 82,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 82,
            height: 82,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 8,
              backgroundColor:
                  colorScheme.onPrimaryContainer.withOpacity(0.15),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _OverviewStat extends StatelessWidget {
  final String value;
  final String label;

  const _OverviewStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimaryContainer.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverviewDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 1,
      height: 34,
      color: colorScheme.onPrimaryContainer.withOpacity(0.15),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.07),
                offset: const Offset(4, 4),
                blurRadius: 10,
              ),
              BoxShadow(
                color: colorScheme.surface.withOpacity(0.8),
                offset: const Offset(-4, -4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrackedHabit {
  final String name;
  final IconData icon;
  final int currentStreak;
  final int longestStreak;
  final int weeklyProgress;
  final int weeklyTarget;
  final int totalRecords;

  const _TrackedHabit({
    required this.name,
    required this.icon,
    required this.currentStreak,
    required this.longestStreak,
    required this.weeklyProgress,
    required this.weeklyTarget,
    required this.totalRecords,
  });
}
