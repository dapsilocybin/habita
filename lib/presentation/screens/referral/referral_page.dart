import 'package:flutter/material.dart';

class ReferralPage extends StatefulWidget {
  const ReferralPage({super.key});

  @override
  State<ReferralPage> createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  final String _referralCode = 'HABITA-MOSTAFA';
  final String _referralLink = 'habita.app/invite/HABITA-MOSTAFA';

  final List<_ReferralFriend> _friends = [
    _ReferralFriend(
      name: 'علی رضایی',
      username: 'ali.rezaei',
      status: 'عضو شده',
      reward: 100,
    ),
    _ReferralFriend(
      name: 'سارا محمدی',
      username: 'sara.m',
      status: 'عضو شده',
      reward: 100,
    ),
    _ReferralFriend(
      name: 'محمد احمدی',
      username: 'mohammad.a',
      status: 'دعوت شده',
      reward: 0,
    ),
  ];

  int get _joinedCount {
    return _friends.where((friend) => friend.reward > 0).length;
  }

  int get _earnedCoins {
    return _friends.fold(
      0,
      (total, friend) => total + friend.reward,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('دعوت از دوستان'),
          centerTitle: false,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              _buildHero(theme),
              const SizedBox(height: 20),
              _buildStats(theme),
              const SizedBox(height: 24),
              _buildReferralCode(theme),
              const SizedBox(height: 20),
              _buildShareButton(theme),
              const SizedBox(height: 28),
              _buildSectionTitle(
                theme,
                'چطور کار می‌کند؟',
              ),
              const SizedBox(height: 12),
              _buildSteps(theme),
              const SizedBox(height: 28),
              _buildSectionTitle(
                theme,
                'دعوت‌شده‌ها',
              ),
              const SizedBox(height: 12),
              _buildFriends(theme),
              const SizedBox(height: 24),
              _buildRewardInfo(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.12),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.12),
                  blurRadius: 18,
                  offset: const Offset(4, 5),
                ),
                BoxShadow(
                  color: colorScheme.surface.withOpacity(0.9),
                  blurRadius: 12,
                  offset: const Offset(-4, -4),
                ),
              ],
            ),
            child: Icon(
              Icons.group_add_rounded,
              size: 42,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'دوستات رو به هابیتا دعوت کن',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'با دعوت از دوستانت، هم با هم رشد کنید و هم HabitaCoin بگیرید.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            theme,
            icon: Icons.people_alt_rounded,
            value: '$_joinedCount',
            label: 'عضو شده',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            theme,
            icon: Icons.monetization_on_outlined,
            value: '$_earnedCoins',
            label: 'HBC دریافت‌شده',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    ThemeData theme, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(3, 4),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 8,
            offset: const Offset(-3, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
            size: 26,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildReferralCode(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(3, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'کد دعوت تو',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _referralCode,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'کپی',
                  onPressed: _copyCode,
                  icon: const Icon(
                    Icons.copy_rounded,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _referralLink,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        onPressed: _shareReferral,
        icon: const Icon(
          Icons.share_rounded,
        ),
        label: const Text(
          'دعوت از دوستان',
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    ThemeData theme,
    String title,
  ) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSteps(ThemeData theme) {
    final steps = [
      _ReferralStep(
        number: '۱',
        icon: Icons.share_rounded,
        title: 'کد دعوتت را به اشتراک بگذار',
        description: 'کد یا لینک دعوت را برای دوستانت ارسال کن.',
      ),
      _ReferralStep(
        number: '۲',
        icon: Icons.person_add_alt_1_rounded,
        title: 'دوستت عضو هابیتا می‌شود',
        description: 'دوستت با استفاده از لینک یا کد تو ثبت‌نام می‌کند.',
      ),
      _ReferralStep(
        number: '۳',
        icon: Icons.monetization_on_outlined,
        title: 'هر دو پاداش می‌گیرید',
        description: 'پس از تکمیل شرایط، پاداش HabitaCoin دریافت می‌کنید.',
      ),
    ];

    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;

        return Padding(
          padding: EdgeInsets.only(
            bottom: index == steps.length - 1 ? 0 : 12,
          ),
          child: _buildStepCard(theme, step),
        );
      }).toList(),
    );
  }

  Widget _buildStepCard(
    ThemeData theme,
    _ReferralStep step,
  ) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.number,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      step.icon,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        step.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  step.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriends(ThemeData theme) {
    if (_friends.isEmpty) {
      return _buildEmptyFriends(theme);
    }

    return Column(
      children: _friends.map((friend) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _buildFriendCard(
            theme,
            friend,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFriendCard(
    ThemeData theme,
    _ReferralFriend friend,
  ) {
    final colorScheme = theme.colorScheme;
    final isJoined = friend.reward > 0;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 23,
            backgroundImage: AssetImage(
              'assets/images/man.jpg',
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '@${friend.username}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isJoined
                      ? colorScheme.primary.withOpacity(0.10)
                      : colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  friend.status,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isJoined
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isJoined) ...[
                const SizedBox(height: 4),
                Text(
                  '+${friend.reward} HBC',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyFriends(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            Icons.people_outline_rounded,
            size: 42,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            'هنوز کسی را دعوت نکرده‌ای',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'اولین دوستت را به مسیر رشد در هابیتا دعوت کن.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildRewardInfo(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'مقدار پاداش دعوت ممکن است بر اساس قوانین و کمپین‌های فعال هابیتا تغییر کند. '
              'شرایط دریافت پاداش قبل از نهایی شدن تراکنش بررسی می‌شود.',
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  void _copyCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('کد دعوت کپی شد.'),
      ),
    );
  }

  void _shareReferral() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'لینک دعوت آماده اشتراک‌گذاری است: $_referralLink',
        ),
      ),
    );
  }
}

class _ReferralFriend {
  final String name;
  final String username;
  final String status;
  final int reward;

  const _ReferralFriend({
    required this.name,
    required this.username,
    required this.status,
    required this.reward,
  });
}

class _ReferralStep {
  final String number;
  final IconData icon;
  final String title;
  final String description;

  const _ReferralStep({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });
}