import 'package:flutter/material.dart';

class ChallengeLeaderboardPage extends StatelessWidget {
  final String? challengeName;

  const ChallengeLeaderboardPage({
    super.key,
    this.challengeName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final name = challengeName ?? '۳۰ روز ورزش';

    final participants = [
      const _LeaderboardUser(
        rank: 1,
        name: 'علی رضایی',
        username: '@ali.rezaei',
        days: 28,
        hbc: 480,
      ),
      const _LeaderboardUser(
        rank: 2,
        name: 'سارا محمدی',
        username: '@sara.m',
        days: 26,
        hbc: 440,
      ),
      const _LeaderboardUser(
        rank: 3,
        name: 'محمد احمدی',
        username: '@mohammad.a',
        days: 25,
        hbc: 420,
      ),
      const _LeaderboardUser(
        rank: 4,
        name: 'مصطفی',
        username: '@mostafa',
        days: 24,
        hbc: 400,
        isCurrentUser: true,
      ),
      const _LeaderboardUser(
        rank: 5,
        name: 'نگار کریمی',
        username: '@negar.k',
        days: 23,
        hbc: 380,
      ),
      const _LeaderboardUser(
        rank: 6,
        name: 'امیر حسین',
        username: '@amir.h',
        days: 22,
        hbc: 360,
      ),
      const _LeaderboardUser(
        rank: 7,
        name: 'رضا موسوی',
        username: '@reza.m',
        days: 21,
        hbc: 340,
      ),
      const _LeaderboardUser(
        rank: 8,
        name: 'الهام احمدی',
        username: '@elham.a',
        days: 20,
        hbc: 320,
      ),
    ];

    final topThree = participants.take(3).toList();
    final remaining = participants.skip(3).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('رتبه‌بندی'),
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _ChallengeHeader(
                      challengeName: name,
                      colorScheme: colorScheme,
                      theme: theme,
                    ),
                    const SizedBox(height: 20),
                    _MyRankCard(
                      rank: 4,
                      days: 24,
                      hbc: 400,
                      colorScheme: colorScheme,
                      theme: theme,
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'برترین‌ها',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _TopThreeSection(
                      users: topThree,
                      colorScheme: colorScheme,
                      theme: theme,
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'جدول کامل',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...remaining.map(
                      (user) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _LeaderboardTile(
                          user: user,
                          colorScheme: colorScheme,
                          theme: theme,
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

class _ChallengeHeader extends StatelessWidget {
  final String challengeName;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _ChallengeHeader({
    required this.challengeName,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.14),
            blurRadius: 20,
            offset: const Offset(8, 8),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 20,
            offset: const Offset(-8, -8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events_rounded,
              color: colorScheme.onPrimaryContainer,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challengeName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'رتبه‌بندی شرکت‌کنندگان بر اساس میزان پیشرفت',
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
}

class _MyRankCard extends StatelessWidget {
  final int rank;
  final int days;
  final int hbc;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _MyRankCard({
    required this.rank,
    required this.days,
    required this.hbc,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.surfaceContainerHighest,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.16),
            blurRadius: 22,
            offset: const Offset(8, 8),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 20,
            offset: const Offset(-7, -7),
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
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'رتبه فعلی شما',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$days روز تکمیل شده',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$hbc',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'HBC',
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

class _TopThreeSection extends StatelessWidget {
  final List<_LeaderboardUser> users;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _TopThreeSection({
    required this.users,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: _PodiumUser(
            user: users[1],
            height: 150,
            colorScheme: colorScheme,
            theme: theme,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _PodiumUser(
            user: users[0],
            height: 180,
            colorScheme: colorScheme,
            theme: theme,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _PodiumUser(
            user: users[2],
            height: 135,
            colorScheme: colorScheme,
            theme: theme,
          ),
        ),
      ],
    );
  }
}

class _PodiumUser extends StatelessWidget {
  final _LeaderboardUser user;
  final double height;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _PodiumUser({
    required this.user,
    required this.height,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: const AssetImage('assets/images/man.jpg'),
            ),
            Positioned(
              bottom: -6,
              right: -2,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.surface,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${user.rank}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          user.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${user.days} روز',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.12),
                blurRadius: 12,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              user.rank == 1
                  ? Icons.workspace_premium_rounded
                  : Icons.emoji_events_rounded,
              size: 32,
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  final _LeaderboardUser user;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _LeaderboardTile({
    required this.user,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('پروفایل ${user.name}'),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: user.isCurrentUser
              ? colorScheme.primaryContainer
              : colorScheme.surface,
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
            SizedBox(
              width: 38,
              child: Text(
                '${user.rank}',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/man.jpg'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    user.username,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${user.days} روز',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${user.hbc} HBC',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LeaderboardUser {
  final int rank;
  final String name;
  final String username;
  final int days;
  final int hbc;
  final bool isCurrentUser;

  const _LeaderboardUser({
    required this.rank,
    required this.name,
    required this.username,
    required this.days,
    required this.hbc,
    this.isCurrentUser = false,
  });
}