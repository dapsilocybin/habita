import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  final String username;

  const UserProfilePage({
    super.key,
    this.username = 'ali.dev',
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool _isFollowing = false;

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('@${widget.username}'),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'گزینه‌ها',
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Column(
            children: [
              _UserHeader(
                username: widget.username,
                isFollowing: _isFollowing,
                onFollowPressed: _toggleFollow,
              ),
              const SizedBox(height: 24),
              const _UserStats(),
              const SizedBox(height: 28),
              const _SectionTitle(
                title: 'عادت‌های فعال',
              ),
              const SizedBox(height: 12),
              const _UserHabitCard(
                icon: Icons.fitness_center_outlined,
                title: 'باشگاه',
                subtitle: 'در حال ساخت یک روتین ورزشی',
                streak: '۲۸ روز',
              ),
              const SizedBox(height: 10),
              const _UserHabitCard(
                icon: Icons.menu_book_outlined,
                title: 'مطالعه روزانه',
                subtitle: 'هر روز حداقل ۳۰ دقیقه',
                streak: '۴۵ روز',
              ),
              const SizedBox(height: 10),
              const _UserHabitCard(
                icon: Icons.bedtime_outlined,
                title: 'خواب منظم',
                subtitle: 'خواب قبل از ساعت ۱۲ شب',
                streak: '۱۶ روز',
              ),
              const SizedBox(height: 28),
              _SectionTitle(
                title: 'دستاوردها',
                action: 'مشاهده همه',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              const _AchievementsRow(),
              const SizedBox(height: 28),
              _SectionTitle(
                title: 'آخرین رکوردها',
                action: 'مشاهده همه',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              const _UserRecordCard(
                habit: 'باشگاه',
                text: 'امروز یک جلسه کامل تمرین کردم. انرژی خیلی بهتری داشتم.',
                time: '۱ ساعت پیش',
                likes: '42',
                comments: '6',
              ),
              const SizedBox(height: 10),
              const _UserRecordCard(
                habit: 'مطالعه روزانه',
                text: 'امروز کتاب را به جای شبکه‌های اجتماعی انتخاب کردم.',
                time: 'دیروز',
                likes: '31',
                comments: '4',
              ),
              const SizedBox(height: 10),
              const _UserRecordCard(
                habit: 'خواب منظم',
                text: 'دیشب ساعت ۱۱ خوابیدم و صبح راحت‌تر بیدار شدم.',
                time: '۲ روز پیش',
                likes: '27',
                comments: '3',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  final String username;
  final bool isFollowing;
  final VoidCallback onFollowPressed;

  const _UserHeader({
    required this.username,
    required this.isFollowing,
    required this.onFollowPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Container(
          width: 112,
          height: 112,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.18),
                offset: const Offset(10, 10),
                blurRadius: 20,
              ),
              BoxShadow(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.8),
                offset: const Offset(-9, -9),
                blurRadius: 18,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/man.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'علی رضایی',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '@$username',
          textDirection: TextDirection.ltr,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'دارم روی عادت‌های کوچک و تغییرات بزرگ کار می‌کنم.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: isFollowing
              ? OutlinedButton.icon(
                  onPressed: onFollowPressed,
                  icon: const Icon(Icons.person_remove_outlined),
                  label: const Text('دنبال می‌کنی'),
                )
              : ElevatedButton.icon(
                  onPressed: onFollowPressed,
                  icon: const Icon(Icons.person_add_outlined),
                  label: const Text('دنبال کردن'),
                ),
        ),
      ],
    );
  }
}

class _UserStats extends StatelessWidget {
  const _UserStats();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.09),
            offset: const Offset(6, 6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withOpacity(0.7),
            offset: const Offset(-5, -5),
            blurRadius: 10,
          ),
        ],
      ),
      child: const Row(
        children: [
          Expanded(
            child: _StatItem(
              value: '386',
              label: 'رکورد',
            ),
          ),
          Expanded(
            child: _StatItem(
              value: '1.2K',
              label: 'دنبال‌کننده',
            ),
          ),
          Expanded(
            child: _StatItem(
              value: '142',
              label: 'دنبال‌شونده',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
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
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onTap;

  const _SectionTitle({
    required this.title,
    this.action,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        if (action != null)
          TextButton(
            onPressed: onTap,
            child: Text(action!),
          ),
      ],
    );
  }
}

class _UserHabitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String streak;

  const _UserHabitCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
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
          Column(
            children: [
              Icon(
                Icons.local_fire_department_outlined,
                size: 19,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 2),
              Text(
                streak,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AchievementsRow extends StatelessWidget {
  const _AchievementsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AchievementCard(
            icon: Icons.local_fire_department_outlined,
            title: '۳۰ روز',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _AchievementCard(
            icon: Icons.menu_book_outlined,
            title: 'صد رکورد',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _AchievementCard(
            icon: Icons.emoji_events_outlined,
            title: 'چالش‌گر',
          ),
        ),
      ],
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _AchievementCard({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserRecordCard extends StatelessWidget {
  final String habit;
  final String text;
  final String time;
  final String likes;
  final String comments;

  const _UserRecordCard({
    required this.habit,
    required this.text,
    required this.time,
    required this.likes,
    required this.comments,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.track_changes_outlined,
                size: 18,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 7),
              Text(
                habit,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                time,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.favorite_border,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 5),
              Text(
                likes,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 18),
              Icon(
                Icons.chat_bubble_outline,
                size: 17,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 5),
              Text(
                comments,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.share_outlined,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
