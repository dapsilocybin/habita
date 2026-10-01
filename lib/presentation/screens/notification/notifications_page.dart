import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('اعلان‌ها'),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'علامت‌گذاری همه',
            icon: const Icon(Icons.done_all_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            _SectionTitle(
              title: 'جدید',
              count: 4,
            ),
            const SizedBox(height: 12),

            const _NotificationCard(
              type: _NotificationType.like,
              title: 'امیر رکوردت را پسندید',
              description: 'رکورد «باشگاه» تو را پسندیده است.',
              time: '۵ دقیقه پیش',
              isUnread: true,
            ),

            const SizedBox(height: 10),

            const _NotificationCard(
              type: _NotificationType.comment,
              title: 'سارا روی رکوردت نظر داد',
              description: '«من هم از همین روش استفاده می‌کنم 👌»',
              time: '۱۸ دقیقه پیش',
              isUnread: true,
            ),

            const SizedBox(height: 10),

            const _NotificationCard(
              type: _NotificationType.follow,
              title: 'محمد تو را دنبال کرد',
              description: 'حالا می‌توانی رکوردهای او را در خانه ببینی.',
              time: '۱ ساعت پیش',
              isUnread: true,
            ),

            const SizedBox(height: 10),

            const _NotificationCard(
              type: _NotificationType.achievement,
              title: 'مدال جدید گرفتی 🎉',
              description: 'مدال «صد قدم» برایت باز شد.',
              time: '۲ ساعت پیش',
              isUnread: true,
            ),

            const SizedBox(height: 28),

            _SectionTitle(
              title: 'امروز',
            ),
            const SizedBox(height: 12),

            const _NotificationCard(
              type: _NotificationType.challenge,
              title: 'چالش ۳۰ روز ورزش',
              description: 'یک قدم دیگر به تکمیل چالش نزدیک شدی.',
              time: 'امروز، ۱۰:۲۰',
            ),

            const SizedBox(height: 10),

            const _NotificationCard(
              type: _NotificationType.habit,
              title: 'فعالیت در عادت مورد علاقه‌ات',
              description: '۱۲ رکورد جدید در «مطالعه روزانه» ثبت شده است.',
              time: 'امروز، ۰۹:۱۵',
            ),

            const SizedBox(height: 10),

            const _NotificationCard(
              type: _NotificationType.coin,
              title: '۱۲۰ HBC دریافت کردی',
              description: 'برای ثبت یک رکورد جدید به تو پاداش داده شد.',
              time: 'امروز، ۰۸:۴۵',
            ),

            const SizedBox(height: 10),

            const _NotificationCard(
              type: _NotificationType.comment,
              title: 'علی روی رکوردت نظر داد',
              description: '«عالیه، ادامه بده 🔥»',
              time: 'امروز، ۰۸:۱۰',
            ),

            const SizedBox(height: 28),

            _SectionTitle(
              title: 'قدیمی‌تر',
            ),
            const SizedBox(height: 12),

            const _NotificationCard(
              type: _NotificationType.achievement,
              title: 'به یک رکورد جدید رسیدی',
              description: '۲۱ روز متوالی در «یادگیری زبان».',
              time: 'دیروز',
            ),

            const SizedBox(height: 10),

            const _NotificationCard(
              type: _NotificationType.follow,
              title: 'نگار تو را دنبال کرد',
              description: 'می‌توانی پروفایل او را مشاهده کنی.',
              time: '۲ روز پیش',
            ),

            const SizedBox(height: 10),

            const _NotificationCard(
              type: _NotificationType.challenge,
              title: 'چالش جدید برایت آماده است',
              description: 'چالش «هفته مطالعه» را از دست نده.',
              time: '۳ روز پیش',
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final int? count;

  const _SectionTitle({
    required this.title,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        if (count != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

enum _NotificationType {
  like,
  comment,
  follow,
  achievement,
  challenge,
  habit,
  coin,
}

class _NotificationCard extends StatelessWidget {
  final _NotificationType type;
  final String title;
  final String description;
  final String time;
  final bool isUnread;

  const _NotificationCard({
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    this.isUnread = false,
  });

  IconData get _icon {
    switch (type) {
      case _NotificationType.like:
        return Icons.favorite_outline;
      case _NotificationType.comment:
        return Icons.chat_bubble_outline;
      case _NotificationType.follow:
        return Icons.person_add_outlined;
      case _NotificationType.achievement:
        return Icons.workspace_premium_outlined;
      case _NotificationType.challenge:
        return Icons.emoji_events_outlined;
      case _NotificationType.habit:
        return Icons.track_changes_outlined;
      case _NotificationType.coin:
        return Icons.monetization_on_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread
            ? colorScheme.primaryContainer.withOpacity(0.45)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NotificationIcon(
            icon: _icon,
            isUnread: isUnread,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight:
                              isUnread ? FontWeight.bold : FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(top: 5, right: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  time,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withOpacity(0.7),
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

class _NotificationIcon extends StatelessWidget {
  final IconData icon;
  final bool isUnread;

  const _NotificationIcon({
    required this.icon,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isUnread
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: colorScheme.primary,
        size: 23,
      ),
    );
  }
}
