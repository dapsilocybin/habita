import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('پروفایل'),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'تنظیمات',
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Column(
            children: [
              _ProfileHeader(),
              const SizedBox(height: 24),
              _ProfileStats(),
              const SizedBox(height: 28),
              _ProfileSectionTitle(
                title: 'عادت‌های فعال',
                action: 'مشاهده همه',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _HabitChip(
                icon: Icons.fitness_center_outlined,
                title: 'باشگاه',
                streak: '۱۲ روز',
              ),
              const SizedBox(height: 10),
              _HabitChip(
                icon: Icons.menu_book_outlined,
                title: 'مطالعه روزانه',
                streak: '۸ روز',
              ),
              const SizedBox(height: 10),
              _HabitChip(
                icon: Icons.language_outlined,
                title: 'یادگیری زبان',
                streak: '۲۱ روز',
              ),
              const SizedBox(height: 28),
              _ProfileSectionTitle(
                title: 'دستاوردها',
                action: 'مشاهده همه',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _AchievementsPreview(),
              const SizedBox(height: 28),
              _ProfileSectionTitle(
                title: 'آمار فعالیت',
              ),
              const SizedBox(height: 12),
              _ActivityStats(),
              const SizedBox(height: 28),
              _ProfileSectionTitle(
                title: 'آخرین رکوردها',
                action: 'مشاهده همه',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _RecordPreview(
                habit: 'باشگاه',
                text: 'امروز بالاخره رکورد پرس سینه‌ام را بهتر کردم.',
                time: '۲ ساعت پیش',
                likes: '24',
              ),
              const SizedBox(height: 10),
              _RecordPreview(
                habit: 'مطالعه روزانه',
                text: 'امروز ۳۰ دقیقه بدون حواس‌پرتی مطالعه کردم.',
                time: 'دیروز',
                likes: '18',
              ),
              const SizedBox(height: 10),
              _RecordPreview(
                habit: 'یادگیری زبان',
                text: '۲۰ لغت جدید یاد گرفتم و مرورشان کردم.',
                time: '۲ روز پیش',
                likes: '31',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
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
          'مصطفی',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '@mostafa',
          textDirection: TextDirection.ltr,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'در مسیر ساختن نسخه بهتر خودم 🚀',
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
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
            label: const Text('ویرایش پروفایل'),
          ),
        ),
      ],
    );
  }
}

class _ProfileStats extends StatelessWidget {
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
              value: '259',
              label: 'رکورد',
            ),
          ),
          Expanded(
            child: _StatItem(
              value: '184',
              label: 'دنبال‌کننده',
            ),
          ),
          Expanded(
            child: _StatItem(
              value: '96',
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

class _ProfileSectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onTap;

  const _ProfileSectionTitle({
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

class _HabitChip extends StatelessWidget {
  final IconData icon;
  final String title;
  final String streak;

  const _HabitChip({
    required this.icon,
    required this.title,
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
            width: 46,
            height: 46,
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
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(
            Icons.local_fire_department_outlined,
            size: 19,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 4),
          Text(
            streak,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: _AchievementItem(
            icon: Icons.flag_outlined,
            title: 'شروع مسیر',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _AchievementItem(
            icon: Icons.local_fire_department_outlined,
            title: 'هفته اول',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _AchievementItem(
            icon: Icons.workspace_premium_outlined,
            title: 'صد قدم',
          ),
        ),
      ],
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _AchievementItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class _ActivityStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.09),
            offset: const Offset(6, 6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
            offset: const Offset(-5, -5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          _ActivityRow(
            icon: Icons.edit_note_outlined,
            title: 'رکوردهای این ماه',
            value: '42',
          ),
          const Divider(height: 24),
          _ActivityRow(
            icon: Icons.local_fire_department_outlined,
            title: 'بهترین استریک',
            value: '21 روز',
          ),
          const Divider(height: 24),
          _ActivityRow(
            icon: Icons.emoji_events_outlined,
            title: 'چالش‌های تکمیل‌شده',
            value: '4',
          ),
          const Divider(height: 24),
          _ActivityRow(
            icon: Icons.monetization_on_outlined,
            title: 'HBC کسب‌شده',
            value: '2,480',
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ActivityRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          color: colorScheme.primary,
          size: 23,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _RecordPreview extends StatelessWidget {
  final String habit;
  final String text;
  final String time;
  final String likes;

  const _RecordPreview({
    required this.habit,
    required this.text,
    required this.time,
    required this.likes,
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
                '3',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
