import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('کیف پول'),
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
              _BalanceCard(),
              const SizedBox(height: 24),
              Text(
                'فعالیت‌های تو',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _WalletActionCard(
                      icon: Icons.add_circle_outline,
                      title: 'کسب سکه',
                      subtitle: 'با فعالیت بیشتر',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _WalletActionCard(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'خرج کردن',
                      subtitle: 'استفاده از سکه‌ها',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'چطور سکه به دست بیاورم؟',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              _EarnCoinCard(
                icon: Icons.edit_note_outlined,
                title: 'ثبت رکورد',
                description: 'با ثبت تلاش‌های واقعی، سکه دریافت کن.',
                amount: '+120',
              ),
              const SizedBox(height: 10),
              _EarnCoinCard(
                icon: Icons.emoji_events_outlined,
                title: 'تکمیل چالش',
                description: 'با شرکت و تکمیل چالش‌های هابیتا پاداش بگیر.',
                amount: '+80',
              ),
              const SizedBox(height: 10),
              _EarnCoinCard(
                icon: Icons.people_outline,
                title: 'مشارکت اجتماعی',
                description: 'با فعالیت مفید در جامعه هابیتا سکه بگیر.',
                amount: '+50',
              ),
              const SizedBox(height: 28),
              Text(
                'تراکنش‌های اخیر',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              const _TransactionCard(
                icon: Icons.edit_note_outlined,
                title: 'ثبت رکورد',
                subtitle: 'امروز، ۱۰:۲۴',
                amount: '+120 HBC',
                isIncome: true,
              ),
              const SizedBox(height: 10),
              const _TransactionCard(
                icon: Icons.emoji_events_outlined,
                title: 'تکمیل چالش',
                subtitle: 'دیروز، ۱۸:۴۰',
                amount: '+80 HBC',
                isIncome: true,
              ),
              const SizedBox(height: 10),
              const _TransactionCard(
                icon: Icons.lock_outline,
                title: 'پیوستن به عادت خصوصی',
                subtitle: '۲ روز پیش',
                amount: '-300 HBC',
                isIncome: false,
              ),
              const SizedBox(height: 10),
              const _TransactionCard(
                icon: Icons.people_outline,
                title: 'مشارکت اجتماعی',
                subtitle: '۳ روز پیش',
                amount: '+50 HBC',
                isIncome: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
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
            width: 76,
            height: 76,
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
              Icons.monetization_on_outlined,
              size: 40,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'موجودی هابیتاکوین',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '2,480 HBC',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'موجودی قابل استفاده',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onPrimaryContainer.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _WalletActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.12),
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
            Icon(
              icon,
              color: colorScheme.primary,
              size: 28,
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
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
    );
  }
}

class _EarnCoinCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String amount;

  const _EarnCoinCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.amount,
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
            color: colorScheme.shadow.withOpacity(0.1),
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
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            amount,
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

class _TransactionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final bool isIncome;

  const _TransactionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
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
            color: colorScheme.shadow.withOpacity(0.1),
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
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
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
          Text(
            amount,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isIncome
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
