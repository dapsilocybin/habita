import 'package:flutter/material.dart';

class AccountManagementPage extends StatelessWidget {
  const AccountManagementPage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);
        final colorScheme = theme.colorScheme;

        return AlertDialog(
          title: const Text('خروج از حساب'),
          content: const Text(
            'آیا مطمئن هستید که می‌خواهید از حساب هابیتا خارج شوید؟',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('انصراف'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();

                // TODO: Clear authentication/session data.
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/phone-login',
                  (route) => false,
                );
              },
              child: const Text('خروج'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);
        final colorScheme = theme.colorScheme;

        return AlertDialog(
          icon: Icon(
            Icons.delete_forever_outlined,
            size: 42,
            color: colorScheme.error,
          ),
          title: const Text('حذف حساب کاربری'),
          content: const Text(
            'حذف حساب یک اقدام دائمی است. اطلاعات حساب، فعالیت‌ها و داده‌های مرتبط ممکن است پس از تکمیل فرایند حذف قابل بازیابی نباشند.\n\nآیا مطمئن هستید که می‌خواهید ادامه دهید؟',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('انصراف'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _showFinalDeleteConfirmation(context);
              },
              child: const Text('ادامه حذف'),
            ),
          ],
        );
      },
    );
  }

  void _showFinalDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);
        final colorScheme = theme.colorScheme;

        return AlertDialog(
          title: const Text('تأیید نهایی'),
          content: const Text(
            'برای ادامه حذف حساب، باید مالکیت حساب شما با روش امنیتی مناسب تأیید شود.\n\nدر نسخه واقعی، در این مرحله احراز هویت مجدد یا کد تأیید ارسال خواهد شد.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('انصراف'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();

                // TODO: Start account deletion verification flow.

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'فرایند تأیید حذف حساب در نسخه نهایی فعال خواهد شد.',
                    ),
                  ),
                );
              },
              child: const Text('تأیید مالکیت'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حساب کاربری'),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            children: [
              _buildAccountHeader(context),
              const SizedBox(height: 24),
              _buildSectionTitle(
                context,
                'امنیت حساب',
              ),
              const SizedBox(height: 10),
              _buildActionCard(
                context,
                icon: Icons.phone_android_outlined,
                title: 'شماره موبایل',
                subtitle: 'تغییر شماره موبایل متصل به حساب',
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/change-phone-number',
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                context,
                icon: Icons.devices_outlined,
                title: 'نشست‌های فعال',
                subtitle: 'مدیریت دستگاه‌ها و نشست‌های حساب',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'مدیریت نشست‌های فعال در نسخه بعدی اضافه می‌شود.',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              _buildSectionTitle(
                context,
                'حریم خصوصی و داده‌ها',
              ),
              const SizedBox(height: 10),
              _buildActionCard(
                context,
                icon: Icons.privacy_tip_outlined,
                title: 'حریم خصوصی',
                subtitle: 'مشاهده سیاست حریم خصوصی هابیتا',
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/privacy-policy',
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                context,
                icon: Icons.download_outlined,
                title: 'دریافت اطلاعات حساب',
                subtitle: 'درخواست نسخه‌ای از اطلاعات حساب شما',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'درخواست دریافت اطلاعات در نسخه نهایی فعال می‌شود.',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              _buildSectionTitle(
                context,
                'اقدامات حساب',
              ),
              const SizedBox(height: 10),
              _buildActionCard(
                context,
                icon: Icons.logout_outlined,
                title: 'خروج از حساب',
                subtitle: 'خروج از حساب در این دستگاه',
                onTap: () => _showLogoutDialog(context),
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                context,
                icon: Icons.delete_forever_outlined,
                title: 'حذف حساب',
                subtitle: 'حذف دائمی حساب و اطلاعات مرتبط',
                isDestructive: true,
                onTap: () => _showDeleteAccountDialog(context),
              ),
              const SizedBox(height: 24),
              _buildWarningCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.16),
            blurRadius: 22,
            offset: const Offset(6, 8),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.85),
            blurRadius: 22,
            offset: const Offset(-6, -8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.16),
                  blurRadius: 18,
                  offset: const Offset(5, 7),
                ),
                BoxShadow(
                  color: colorScheme.surface.withOpacity(0.9),
                  blurRadius: 18,
                  offset: const Offset(-5, -7),
                ),
              ],
            ),
            child: Icon(
              Icons.manage_accounts_outlined,
              size: 38,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'مدیریت حساب',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'امنیت، اطلاعات و وضعیت حساب هابیتا را مدیریت کنید.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final iconColor = isDestructive
        ? colorScheme.error
        : colorScheme.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(4, 6),
              ),
              BoxShadow(
                color: colorScheme.surface.withOpacity(0.8),
                blurRadius: 16,
                offset: const Offset(-4, -6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.surface,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
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
                        color: isDestructive
                            ? colorScheme.error
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_left,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer.withOpacity(0.65),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_outlined,
            color: colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'حذف حساب یک اقدام حساس و دائمی است. در نسخه نهایی، قبل از حذف حساب باید مالکیت حساب و شرایط حذف اطلاعات به‌صورت کامل بررسی شود.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onErrorContainer,
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}