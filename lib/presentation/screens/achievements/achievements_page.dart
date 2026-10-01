import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  final List<_Achievement> _achievements = const [
    _Achievement(
      title: 'شروع مسیر',
      description: 'اولین رکورد خودت را ثبت کردی.',
      icon: Icons.flag_outlined,
      progress: 1,
      target: 1,
      isUnlocked: true,
    ),
    _Achievement(
      title: 'هفته اول',
      description: '۷ روز متوالی در مسیرت ماندی.',
      icon: Icons.local_fire_department_outlined,
      progress: 7,
      target: 7,
      isUnlocked: true,
    ),
    _Achievement(
      title: 'صد قدم',
      description: '۱۰۰ رکورد در هابیتا ثبت کن.',
      icon: Icons.directions_walk_outlined,
      progress: 73,
      target: 100,
      isUnlocked: false,
    ),
    _Achievement(
      title: 'عضو فعال',
      description: 'در ۵ عادت مختلف رکورد ثبت کن.',
      icon: Icons.groups_outlined,
      progress: 3,
      target: 5,
      isUnlocked: false,
    ),
    _Achievement(
      title: 'استقامت',
      description: '۳۰ روز متوالی یک عادت را دنبال کن.',
      icon: Icons.bolt_outlined,
      progress: 21,
      target: 30,
      isUnlocked: false,
    ),
    _Achievement(
      title: 'صدای جامعه',
      description: '۱۰۰ رکورد تو توسط جامعه تأیید شود.',
      icon: Icons.verified_outlined,
      progress: 42,
      target: 100,
      isUnlocked: false,
    ),
    _Achievement(
      title: 'چالش‌گر',
      description: 'در ۱۰ چالش جهانی شرکت کن.',
      icon: Icons.emoji_events_outlined,
      progress: 4,
      target: 10,
      isUnlocked: false,
    ),
    _Achievement(
      title: 'استاد عادت',
      description: '۵۰۰ رکورد موفق در هابیتا ثبت کن.',
      icon: Icons.workspace_premium_outlined,
      progress: 186,
      target: 500,
      isUnlocked: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final unlockedCount =
        _achievements.where((achievement) => achievement.isUnlocked).length;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: const Text('دستاوردها'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildSummary(
                context,
                theme,
                colorScheme,
                unlockedCount,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                context,
                'مدال‌های من',
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _AchievementCard(
                      achievement: _achievements[index],
                    );
                  },
                  childCount: _achievements.length,
                ),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.82,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    int unlockedCount,
  ) {
    final total = _achievements.length;
    final progress = unlockedCount / total;

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
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withOpacity(0.12),
                        offset: const Offset(5, 5),
                        blurRadius: 12,
                      ),
                      BoxShadow(
                        color: colorScheme.surfaceContainerHighest
                            .withOpacity(0.8),
                        offset: const Offset(-4, -4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.workspace_premium_outlined,
                    size: 36,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
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
                      const SizedBox(height: 5),
                      Text(
                        '$unlockedCount از $total مدال را به دست آورده‌ای.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer
                              .withOpacity(0.75),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 9,
                backgroundColor:
                    colorScheme.onPrimaryContainer.withOpacity(0.12),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${(progress * 100).round()}% تکمیل شده',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onPrimaryContainer.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final _Achievement achievement;

  const _AchievementCard({
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final progress =
        (achievement.progress / achievement.target).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: achievement.isUnlocked
            ? colorScheme.surfaceContainerHighest.withOpacity(0.65)
            : colorScheme.surfaceContainerHighest.withOpacity(0.35),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.07),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.7),
            offset: const Offset(-4, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withOpacity(0.10),
                          offset: const Offset(5, 5),
                          blurRadius: 12,
                        ),
                        BoxShadow(
                          color: colorScheme.surfaceContainerHighest
                              .withOpacity(0.8),
                          offset: const Offset(-4, -4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(
                      achievement.icon,
                      size: 40,
                      color: achievement.isUnlocked
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant.withOpacity(0.35),
                    ),
                  ),
                  if (!achievement.isUnlocked)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow.withOpacity(0.12),
                              offset: const Offset(2, 2),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.lock_outline_rounded,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Text(
            achievement.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: achievement.isUnlocked
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            achievement.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          if (!achievement.isUnlocked) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                backgroundColor: colorScheme.surface,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${achievement.progress} / ${achievement.target}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ] else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 16,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  'دریافت شده',
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
}

class _Achievement {
  final String title;
  final String description;
  final IconData icon;
  final int progress;
  final int target;
  final bool isUnlocked;

  const _Achievement({
    required this.title,
    required this.description,
    required this.icon,
    required this.progress,
    required this.target,
    required this.isUnlocked,
  });
}
