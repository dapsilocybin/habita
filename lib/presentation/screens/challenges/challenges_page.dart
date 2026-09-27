import 'package:flutter/material.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('چالش‌ها'),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ChallengeSummaryCard(),
              const SizedBox(height: 28),

              Text(
                'چالش‌های فعال',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),

              _ChallengeCard(
                title: '۳۰ روز ورزش',
                description:
                    '۳۰ روز پشت سر هم برای ساختن یک عادت ورزشی پایدار.',
                icon: Icons.fitness_center_outlined,
                participants: '12.8K',
                daysLeft: '۱۸ روز باقی مانده',
                progress: 0.4,
                reward: '500 HBC',
                isJoined: true,
              ),
              const SizedBox(height: 14),

              _ChallengeCard(
                title: 'هفته مطالعه',
                description:
                    'در طول یک هفته هر روز حداقل ۳۰ دقیقه مطالعه کن.',
                icon: Icons.menu_book_outlined,
                participants: '8.4K',
                daysLeft: '۴ روز باقی مانده',
                progress: 0.71,
                reward: '250 HBC',
                isJoined: false,
              ),
              const SizedBox(height: 14),

              _ChallengeCard(
                title: 'خواب منظم',
                description:
                    'برای ۱۴ شب، ساعت خواب و بیداری منظمی داشته باش.',
                icon: Icons.bedtime_outlined,
                participants: '6.1K',
                daysLeft: '۹ روز باقی مانده',
                progress: 0.35,
                reward: '350 HBC',
                isJoined: false,
              ),
              const SizedBox(height: 14),

              _ChallengeCard(
                title: 'آب بیشتر',
                description:
                    'برای ۷ روز، مصرف آب روزانه‌ات را پیگیری کن.',
                icon: Icons.water_drop_outlined,
                participants: '18.2K',
                daysLeft: '۲ روز باقی مانده',
                progress: 0.86,
                reward: '150 HBC',
                isJoined: true,
              ),

              const SizedBox(height: 28),

              Text(
                'چالش‌های تکمیل‌شده',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),

              _CompletedChallengeCard(
                title: 'شروع صبح قدرتمند',
                subtitle: '۷ روز انجام شد',
                reward: '+200 HBC',
              ),
              const SizedBox(height: 10),

              _CompletedChallengeCard(
                title: '۱۰ هزار قدم',
                subtitle: 'چالش تکمیل شد',
                reward: '+300 HBC',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChallengeSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.18),
            offset: const Offset(12, 12),
            blurRadius: 24,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.8),
            offset: const Offset(-10, -10),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.16),
                  offset: const Offset(7, 7),
                  blurRadius: 14,
                ),
                BoxShadow(
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.8),
                  offset: const Offset(-6, -6),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Icon(
              Icons.emoji_events_outlined,
              size: 38,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'مسیرت را به یک چالش تبدیل کن',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'با دیگران همراه شو، پیشرفتت را ثبت کن و برای ادامه مسیر پاداش بگیر.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimaryContainer.withOpacity(0.75),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  value: '2',
                  label: 'در حال انجام',
                ),
              ),
              Expanded(
                child: _SummaryItem(
                  value: '4',
                  label: 'تکمیل‌شده',
                ),
              ),
              Expanded(
                child: _SummaryItem(
                  value: '700',
                  label: 'HBC دریافت‌شده',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String value;
  final String label;

  const _SummaryItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
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
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onPrimaryContainer.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String participants;
  final String daysLeft;
  final double progress;
  final String reward;
  final bool isJoined;

  const _ChallengeCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.participants,
    required this.daysLeft,
    required this.progress,
    required this.reward,
    required this.isJoined,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            offset: const Offset(7, 7),
            blurRadius: 14,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
            offset: const Offset(-6, -6),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: 27,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$participants شرکت‌کننده',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  reward,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.schedule_outlined,
                size: 17,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 5),
              Text(
                daysLeft,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Text(
                '${(progress * 100).round()}%',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: colorScheme.surfaceContainerHighest,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: isJoined
                ? OutlinedButton(
                    onPressed: () {},
                    child: const Text('مشاهده پیشرفت'),
                  )
                : ElevatedButton(
                    onPressed: () {},
                    child: const Text('پیوستن به چالش'),
                  ),
          ),
        ],
      ),
    );
  }
}

class _CompletedChallengeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String reward;

  const _CompletedChallengeCard({
    required this.title,
    required this.subtitle,
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            offset: const Offset(5, 5),
            blurRadius: 10,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
            offset: const Offset(-5, -5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            reward,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
