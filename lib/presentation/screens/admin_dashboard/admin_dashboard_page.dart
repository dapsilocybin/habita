import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت هابیتا'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'اعلان‌ها',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('اعلان‌های مدیریتی به‌زودی اضافه می‌شود.'),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _buildWelcomeCard(context),
          const SizedBox(height: 20),
          Text(
            'نمای کلی',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildOverviewGrid(context),
          const SizedBox(height: 24),
          Text(
            'مدیریت',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildManagementSection(context),
          const SizedBox(height: 24),
          Text(
            'نیازمند بررسی',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildPendingSection(context),
          const SizedBox(height: 24),
          Text(
            'عملکرد سیستم',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildSystemStatus(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(6, 6),
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.6),
            blurRadius: 12,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.admin_panel_settings_rounded,
              size: 30,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'پنل مدیریت هابیتا',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'مدیریت کاربران، محتوا و فعالیت‌های پلتفرم',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
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
      childAspectRatio: 1.35,
      children: [
        _buildMetricCard(
          context,
          icon: Icons.people_alt_outlined,
          value: '24.8K',
          label: 'کاربران',
        ),
        _buildMetricCard(
          context,
          icon: Icons.edit_note_rounded,
          value: '186K',
          label: 'رکوردها',
        ),
        _buildMetricCard(
          context,
          icon: Icons.track_changes_rounded,
          value: '428',
          label: 'عادت‌ها',
        ),
        _buildMetricCard(
          context,
          icon: Icons.flag_outlined,
          value: '36',
          label: 'گزارش باز',
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
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
            color: colorScheme.surfaceContainerHighest.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
            size: 25,
          ),
          const SizedBox(height: 9),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
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
      ),
    );
  }

  Widget _buildManagementSection(BuildContext context) {
    return Column(
      children: [
        _buildManagementTile(
          context,
          icon: Icons.flag_outlined,
          title: 'گزارش‌ها',
          subtitle: 'بررسی گزارش‌های کاربران و محتوا',
          badge: '36',
          onTap: () => _showComingSoon(context, 'مدیریت گزارش‌ها'),
        ),
        _buildManagementTile(
          context,
          icon: Icons.verified_user_outlined,
          title: 'تأیید رکوردها',
          subtitle: 'بررسی و تأیید رکوردهای ارسال‌شده',
          badge: '18',
          onTap: () => _showComingSoon(context, 'تأیید رکوردها'),
        ),
        _buildManagementTile(
          context,
          icon: Icons.people_outline_rounded,
          title: 'کاربران',
          subtitle: 'جستجو و مدیریت کاربران',
          onTap: () => _showComingSoon(context, 'مدیریت کاربران'),
        ),
        _buildManagementTile(
          context,
          icon: Icons.account_tree_outlined,
          title: 'درخت عادت‌ها',
          subtitle: 'مدیریت دسته‌بندی‌ها و عادت‌ها',
          onTap: () => _showComingSoon(context, 'مدیریت عادت‌ها'),
        ),
        _buildManagementTile(
          context,
          icon: Icons.emoji_events_outlined,
          title: 'چالش‌ها',
          subtitle: 'ایجاد و مدیریت چالش‌های جهانی',
          onTap: () => _showComingSoon(context, 'مدیریت چالش‌ها'),
        ),
        _buildManagementTile(
          context,
          icon: Icons.monetization_on_outlined,
          title: 'HabitaCoin',
          subtitle: 'مدیریت اقتصاد و تراکنش‌های پلتفرم',
          onTap: () => _showComingSoon(context, 'مدیریت HabitaCoin'),
        ),
      ],
    );
  }

  Widget _buildManagementTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    String? badge,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(4, 4),
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
            blurRadius: 9,
            offset: const Offset(-3, -3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onErrorContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Icon(
              Icons.chevron_left_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildPendingSection(BuildContext context) {
    return Column(
      children: [
        _buildPendingCard(
          context,
          icon: Icons.flag_rounded,
          title: 'گزارش محتوای نامناسب',
          subtitle: 'رکورد توسط ۴ کاربر گزارش شده',
          time: '۱۲ دقیقه پیش',
        ),
        _buildPendingCard(
          context,
          icon: Icons.verified_outlined,
          title: 'رکورد نیازمند تأیید',
          subtitle: 'رکورد مربوط به عادت «باشگاه»',
          time: '۲۵ دقیقه پیش',
        ),
        _buildPendingCard(
          context,
          icon: Icons.person_outline_rounded,
          title: 'درخواست بررسی کاربر',
          subtitle: 'یک گزارش درباره رفتار کاربر ثبت شده',
          time: '۱ ساعت پیش',
        ),
      ],
    );
  }

  Widget _buildPendingCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
            size: 25,
          ),
          const SizedBox(width: 12),
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
            time,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatus(BuildContext context) {
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
            blurRadius: 14,
            offset: const Offset(5, 5),
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildStatusRow(
            context,
            'API',
            'فعال',
            Icons.cloud_done_outlined,
          ),
          _buildStatusRow(
            context,
            'پایگاه داده',
            'فعال',
            Icons.storage_outlined,
          ),
          _buildStatusRow(
            context,
            'احراز هویت',
            'فعال',
            Icons.lock_outline_rounded,
          ),
          _buildStatusRow(
            context,
            'اعلان‌ها',
            'فعال',
            Icons.notifications_none_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(
    BuildContext context,
    String title,
    String status,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title),
          ),
          Icon(
            Icons.circle,
            size: 9,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 7),
          Text(
            status,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$section در نسخه مدیریتی کامل پیاده‌سازی می‌شود.'),
      ),
    );
  }
}