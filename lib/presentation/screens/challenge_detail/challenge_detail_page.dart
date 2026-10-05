import 'package:flutter/material.dart';

class ChallengeDetailPage extends StatefulWidget {
  final String? challengeName;

  const ChallengeDetailPage({super.key, this.challengeName});

  @override
  State<ChallengeDetailPage> createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {
  bool _isJoined = true;

  final String _defaultChallengeName = '۳۰ روز ورزش';

  void _toggleJoin() {
    setState(() {
      _isJoined = !_isJoined;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isJoined ? 'با موفقیت به چالش پیوستی.' : 'از چالش خارج شدی.',
        ),
      ),
    );
  }

  void _openLeaderboard() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('جدول رتبه‌بندی در حال آماده‌سازی است.')),
    );
  }

  void _showChallengeRules() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'قوانین چالش',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildRule(
                  context,
                  icon: Icons.check_circle_outline,
                  text: 'هر روز حداقل یک فعالیت مرتبط با ورزش ثبت کن.',
                ),
                _buildRule(
                  context,
                  icon: Icons.edit_note_outlined,
                  text: 'برای هر فعالیت یک رکورد معتبر ثبت کن.',
                ),
                _buildRule(
                  context,
                  icon: Icons.people_outline,
                  text: 'رکوردها ممکن است توسط جامعه بررسی شوند.',
                ),
                _buildRule(
                  context,
                  icon: Icons.emoji_events_outlined,
                  text: 'رتبه‌بندی بر اساس پیشرفت و استمرار محاسبه می‌شود.',
                ),
                const SizedBox(height: 12),
                Text(
                  'هدف اصلی این چالش ایجاد استمرار است، نه رقابت صرف.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRule(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorScheme.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final name = widget.challengeName ?? _defaultChallengeName;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text('جزئیات چالش'),
        actions: [
          IconButton(
            onPressed: _showChallengeRules,
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeroCard(context, name),
            const SizedBox(height: 20),
            _buildProgressCard(context),
            const SizedBox(height: 20),
            _buildRewardCard(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'درباره چالش'),
            const SizedBox(height: 12),
            _buildDescription(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'رتبه‌بندی'),
            const SizedBox(height: 12),
            _buildLeaderboardPreview(context),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _openLeaderboard,
              child: const Text('مشاهده جدول کامل'),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'شرکت‌کنندگان'),
            const SizedBox(height: 12),
            _buildParticipants(context),
            const SizedBox(height: 32),
            _buildJoinButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, String name) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
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
            color: colorScheme.surfaceContainerHighest.withOpacity(0.8),
            offset: const Offset(-6, -6),
            blurRadius: 14,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.15),
                  offset: const Offset(6, 6),
                  blurRadius: 14,
                ),
                BoxShadow(
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.8),
                  offset: const Offset(-5, -5),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Icon(
              Icons.emoji_events_outlined,
              size: 42,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            name,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '۱۸ روز باقی مانده',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeroStat(context, value: '12.8K', label: 'شرکت‌کننده'),
              const SizedBox(width: 28),
              _buildHeroStat(context, value: '500', label: 'HBC جایزه'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(
    BuildContext context, {
    required String value,
    required String label,
  }) {
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
        const SizedBox(height: 3),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    const progress = 0.40;

    return _buildCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights_outlined, color: colorScheme.primary),
              const SizedBox(width: 10),
              Text(
                'پیشرفت من',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '۴۰٪',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(value: progress, minHeight: 10),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('۱۲ روز', style: theme.textTheme.bodyMedium),
              Text(
                '۳۰ روز',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.local_fire_department_outlined,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'رکورد فعلی: ۵ روز متوالی',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _buildCard(
      context,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primaryContainer,
            ),
            child: Icon(
              Icons.monetization_on_outlined,
              color: colorScheme.onPrimaryContainer,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'جایزه چالش',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'با تکمیل چالش، ۵۰۰ HabitaCoin دریافت می‌کنی.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      'در این چالش باید طی ۳۰ روز، به صورت مستمر فعالیت ورزشی داشته باشی. '
      'هدف این چالش ایجاد یک الگوی پایدار برای ورزش است. '
      'لازم نیست هر روز تمرین سنگین داشته باشی؛ استمرار مهم‌تر از شدت تمرین است.',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
        height: 1.8,
      ),
    );
  }

  Widget _buildLeaderboardPreview(BuildContext context) {
    final users = [
      ('علی رضایی', '۲۸ روز'),
      ('سارا محمدی', '۲۶ روز'),
      ('مصطفی', '۲۴ روز'),
    ];

    return _buildCard(
      context,
      child: Column(
        children: List.generate(users.length, (index) {
          final user = users[index];

          return Padding(
            padding: EdgeInsets.only(
              bottom: index == users.length - 1 ? 0 : 14,
            ),
            child: Row(
              children: [
                _buildRank(context, index + 1),
                const SizedBox(width: 12),
                ClipOval(
                  child: Image.asset(
                    'assets/images/man.jpg',
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    user.$1,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  user.$2,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRank(BuildContext context, int rank) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: rank == 1
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest,
      ),
      child: Text(
        '$rank',
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: rank == 1
              ? colorScheme.onPrimary
              : colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildParticipants(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 68,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Column(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/man.jpg',
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                index == 0 ? 'علی' : 'کاربر ${index + 1}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);

    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.10),
            offset: const Offset(7, 7),
            blurRadius: 16,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
            offset: const Offset(-6, -6),
            blurRadius: 14,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildJoinButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 56,
      child: _isJoined
          ? OutlinedButton.icon(
              onPressed: _toggleJoin,
              icon: const Icon(Icons.check),
              label: const Text('عضو چالش هستی'),
            )
          : ElevatedButton.icon(
              onPressed: _toggleJoin,
              icon: const Icon(Icons.add),
              label: const Text('پیوستن به چالش'),
            ),
    );
  }
}
