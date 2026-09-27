import 'package:flutter/material.dart';

class HabitDetailPage extends StatefulWidget {
  final String habitName;

  const HabitDetailPage({
    super.key,
    required this.habitName,
  });

  @override
  State<HabitDetailPage> createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  bool _isJoined = false;

  final List<_HabitPost> _posts = [
    _HabitPost(
      username: 'ali_growth',
      time: '۲ ساعت پیش',
      text: 'امروز برای اولین بار تونستم یک ساعت کامل تمرین کنم. حس خیلی خوبی داشت.',
      likes: 42,
      comments: 6,
    ),
    _HabitPost(
      username: 'sara.fit',
      time: '۵ ساعت پیش',
      text: 'روز هفتم این عادت. چیزی که بیشتر از همه کمکم کرد، ثابت نگه داشتن ساعت تمرین بود.',
      likes: 87,
      comments: 12,
    ),
    _HabitPost(
      username: 'mohammad_dev',
      time: 'دیروز',
      text: 'حتی وقتی حوصله نداشتم، فقط به خودم گفتم پنج دقیقه شروع کن.',
      likes: 31,
      comments: 4,
    ),
  ];

  final List<String> _similarHabits = [
    'پیاده‌روی روزانه',
    'دویدن',
    'کشش بدن',
    'خواب منظم',
  ];

  final List<_InfluentialPerson> _influentialPeople = [
    _InfluentialPerson(
      name: 'علی رضایی',
      username: '@ali_growth',
    ),
    _InfluentialPerson(
      name: 'سارا احمدی',
      username: '@sara.fit',
    ),
    _InfluentialPerson(
      name: 'محمد کریمی',
      username: '@mohammad_dev',
    ),
  ];

  void _toggleJoin() {
    setState(() {
      _isJoined = !_isJoined;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isJoined
              ? 'به این عادت پیوستی.'
              : 'از این عادت خارج شدی.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: const Text('جزئیات عادت'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHabitHeader(
                context,
                theme,
                colorScheme,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildStats(
                context,
                theme,
                colorScheme,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                context,
                'درباره این عادت',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildDescription(
                context,
                theme,
                colorScheme,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                context,
                'افراد فعال در این عادت',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildInfluentialPeople(
                context,
                theme,
                colorScheme,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                context,
                'رکوردهای اخیر',
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _HabitPostCard(
                    post: _posts[index],
                  );
                },
                childCount: _posts.length,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                context,
                'عادت‌های مشابه',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSimilarHabits(
                context,
                theme,
                colorScheme,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitHeader(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.16),
                  offset: const Offset(10, 10),
                  blurRadius: 22,
                ),
                BoxShadow(
                  color: colorScheme.surface.withOpacity(0.8),
                  offset: const Offset(-8, -8),
                  blurRadius: 20,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/post.jpg',
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          colorScheme.scrim.withOpacity(0.65),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    left: 20,
                    child: Text(
                      widget.habitName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  'هر روز یک قدم کوچک برای ساختن این عادت بردار.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _toggleJoin,
                  icon: Icon(
                    _isJoined
                        ? Icons.check_rounded
                        : Icons.add_rounded,
                  ),
                  label: Text(
                    _isJoined ? 'عضو شدی' : 'پیوستن',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStats(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.08),
              offset: const Offset(5, 5),
              blurRadius: 12,
            ),
            BoxShadow(
              color: colorScheme.surface.withOpacity(0.8),
              offset: const Offset(-5, -5),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          children: [
            _StatItem(
              value: '12.4K',
              label: 'عضو',
            ),
            _StatDivider(),
            _StatItem(
              value: '48.7K',
              label: 'رکورد',
            ),
            _StatDivider(),
            _StatItem(
              value: '86%',
              label: 'تداوم',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 12),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'این عادت به تو کمک می‌کند با ایجاد یک رفتار کوچک و تکرارشونده، '
        'به مرور سبک زندگی خودت را تغییر بدهی. لازم نیست هر روز کامل باشی؛ '
        'مهم این است که مسیر را ادامه بدهی و تلاش‌هایت را ثبت کنی.',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
          height: 1.9,
        ),
      ),
    );
  }

  Widget _buildInfluentialPeople(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _influentialPeople.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final person = _influentialPeople[index];

          return Container(
            width: 180,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.08),
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/man.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        person.username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
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
        },
      ),
    );
  }

  Widget _buildSimilarHabits(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _similarHabits.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.07),
                  offset: const Offset(3, 3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Text(
              _similarHabits[index],
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
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

    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
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
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 1,
      height: 38,
      color: colorScheme.outlineVariant,
    );
  }
}

class _HabitPostCard extends StatelessWidget {
  final _HabitPost post;

  const _HabitPostCard({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.45),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.07),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/man.jpg',
                  width: 46,
                  height: 46,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      textDirection: TextDirection.ltr,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      post.time,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_horiz,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            post.text,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.7,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(
                Icons.favorite_border,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text('${post.likes}'),
              const SizedBox(width: 20),
              Icon(
                Icons.chat_bubble_outline,
                size: 19,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text('${post.comments}'),
              const Spacer(),
              Icon(
                Icons.share_outlined,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HabitPost {
  final String username;
  final String time;
  final String text;
  final int likes;
  final int comments;

  const _HabitPost({
    required this.username,
    required this.time,
    required this.text,
    required this.likes,
    required this.comments,
  });
}

class _InfluentialPerson {
  final String name;
  final String username;

  const _InfluentialPerson({
    required this.name,
    required this.username,
  });
}
