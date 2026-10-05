import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final transactions = [
      const _Transaction(
        title: 'پاداش ثبت رکورد',
        description: '۳۰ روز ورزش',
        amount: 120,
        date: 'امروز، ۱۰:۲۴',
        type: _TransactionType.earned,
        icon: Icons.article_rounded,
      ),
      const _Transaction(
        title: 'پاداش چالش',
        description: 'چالش هفته مطالعه',
        amount: 80,
        date: 'دیروز، ۱۸:۴۰',
        type: _TransactionType.earned,
        icon: Icons.emoji_events_rounded,
      ),
      const _Transaction(
        title: 'ایجاد عادت خصوصی',
        description: 'هزینه ایجاد عادت',
        amount: -300,
        date: '۲ مهر، ۱۴:۱۲',
        type: _TransactionType.spent,
        icon: Icons.lock_rounded,
      ),
      const _Transaction(
        title: 'پاداش فعالیت اجتماعی',
        description: 'تعامل با جامعه',
        amount: 50,
        date: '۱ مهر، ۲۰:۱۵',
        type: _TransactionType.earned,
        icon: Icons.people_alt_rounded,
      ),
      const _Transaction(
        title: 'پاداش ثبت رکورد',
        description: 'مطالعه روزانه',
        amount: 120,
        date: '۳۰ شهریور، ۱۹:۲۸',
        type: _TransactionType.earned,
        icon: Icons.auto_stories_rounded,
      ),
      const _Transaction(
        title: 'پیوستن به عادت ویژه',
        description: 'عادت محدود',
        amount: -200,
        date: '۲۹ شهریور، ۱۱:۰۵',
        type: _TransactionType.spent,
        icon: Icons.habit_rounded,
      ),
      const _Transaction(
        title: 'پاداش چالش',
        description: 'شروع صبح قدرتمند',
        amount: 200,
        date: '۲۸ شهریور، ۰۹:۳۱',
        type: _TransactionType.earned,
        icon: Icons.flag_rounded,
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تاریخچه تراکنش‌ها'),
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _BalanceCard(
                      balance: 2480,
                      theme: theme,
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 24),
                    _SummaryRow(
                      theme: theme,
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'تراکنش‌ها',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...transactions.map(
                      (transaction) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _TransactionTile(
                          transaction: transaction,
                          theme: theme,
                          colorScheme: colorScheme,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final int balance;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _BalanceCard({
    required this.balance,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.surfaceContainerHighest,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.16),
            blurRadius: 24,
            offset: const Offset(9, 9),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 24,
            offset: const Offset(-9, -9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'موجودی فعلی',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$balance',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Text(
                  'HBC',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'موجودی قابل استفاده',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _SummaryRow({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'دریافتی',
            amount: '+570 HBC',
            icon: Icons.arrow_downward_rounded,
            theme: theme,
            colorScheme: colorScheme,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            title: 'هزینه‌شده',
            amount: '-500 HBC',
            icon: Icons.arrow_upward_rounded,
            theme: theme,
            colorScheme: colorScheme,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
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

class _TransactionTile extends StatelessWidget {
  final _Transaction transaction;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _TransactionTile({
    required this.transaction,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final isEarned = transaction.type == _TransactionType.earned;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        _showTransactionDetails(context);
      },
      child: Container(
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
                transaction.icon,
                color: colorScheme.onPrimaryContainer,
                size: 23,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaction.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    transaction.date,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isEarned ? '+' : ''}${transaction.amount} HBC',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 5),
                Icon(
                  isEarned
                      ? Icons.south_west_rounded
                      : Icons.north_east_rounded,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDetails(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final sheetTheme = Theme.of(context);
        final sheetColors = sheetTheme.colorScheme;
        final isEarned = transaction.type == _TransactionType.earned;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  transaction.icon,
                  size: 42,
                  color: sheetColors.primary,
                ),
                const SizedBox(height: 14),
                Text(
                  transaction.title,
                  style: sheetTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  transaction.description,
                  style: sheetTheme.textTheme.bodyMedium?.copyWith(
                    color: sheetColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${isEarned ? '+' : ''}${transaction.amount} HBC',
                  style: sheetTheme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: sheetColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  transaction.date,
                  style: sheetTheme.textTheme.bodySmall?.copyWith(
                    color: sheetColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum _TransactionType {
  earned,
  spent,
}

class _Transaction {
  final String title;
  final String description;
  final int amount;
  final String date;
  final _TransactionType type;
  final IconData icon;

  const _Transaction({
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    required this.icon,
  });
}