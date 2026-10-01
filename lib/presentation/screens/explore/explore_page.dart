import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _searchController = TextEditingController();

  final List<_ExplorePost> _posts = const [
    _ExplorePost(
      username: 'ali_dev',
      habit: 'مطالعه روزانه',
      caption:
          'امروز هم ۳۰ دقیقه مطالعه کردم. کم‌کم داره تبدیل به بخشی از روزم میشه.',
      image: 'assets/images/post.jpg',
      likes: 124,
    ),
    _ExplorePost(
      username: 'sara_growth',
      habit: 'ورزش',
      caption:
          'حتی وقتی حوصله نداشتم، فقط شروع کردم. همین شروع کردن مهم بود.',
      image: 'assets/images/post.jpg',
      likes: 287,
    ),
    _ExplorePost(
      username: 'mohammad',
      habit: 'خواب منظم',
      caption: 'این هفته سعی کردم هر شب ساعت مشخصی بخوابم.',
      image: 'assets/images/post.jpg',
      likes: 91,
    ),
    _ExplorePost(
      username: 'niloofar',
      habit: 'یادگیری زبان',
      caption: 'یک قدم کوچک دیگر برای یادگیری زبان.',
      image: 'assets/images/post.jpg',
      likes: 176,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    // TODO:
    // Connect to search logic later.
    //
    // Search should eventually return:
    // - Habits / habit tree suggestions
    // - Users
    // - Posts
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(
                context,
                theme,
                colorScheme,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSearchField(
                context,
                theme,
                colorScheme,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                context,
                'عادت‌های محبوب',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildPopularHabits(
                context,
                theme,
                colorScheme,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                context,
                'پیشنهاد برای تو',
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                100,
              ),
              sliver: SliverList.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return _ExplorePostCard(
                    post: _posts[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(
        context,
        theme,
        colorScheme,
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'کشف کن',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          _NeomorphicIconButton(
            icon: Icons.notifications_none_rounded,
            onPressed: () {
              // TODO: Open notifications.
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
          hintText: 'جستجوی عادت، کاربر یا رکورد...',
          prefixIcon: Icon(
            Icons.search_rounded,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        28,
        20,
        14,
      ),
      child: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildPopularHabits(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    final habits = [
      _PopularHabit(
        title: 'ورزش',
        icon: Icons.fitness_center_rounded,
        members: '۱۲.۴K',
      ),
      _PopularHabit(
        title: 'مطالعه',
        icon: Icons.menu_book_rounded,
        members: '۹.۸K',
      ),
      _PopularHabit(
        title: 'خواب منظم',
        icon: Icons.bedtime_rounded,
        members: '۷.۲K',
      ),
      _PopularHabit(
        title: 'یادگیری',
        icon: Icons.school_rounded,
        members: '۶.۵K',
      ),
      _PopularHabit(
        title: 'مدیتیشن',
        icon: Icons.self_improvement_rounded,
        members: '۵.۹K',
      ),
    ];

    return SizedBox(
      height: 128,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: habits.length,
        separatorBuilder: (_, __) => const SizedBox(
          width: 14,
        ),
        itemBuilder: (context, index) {
          final habit = habits[index];

          return _PopularHabitCard(
            habit: habit,
            onTap: () {
              // TODO:
              // Open HabitDetailPage.
            },
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigation(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          12,
        ),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.16),
                offset: const Offset(8, 8),
                blurRadius: 18,
              ),
              BoxShadow(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
                offset: const Offset(-6, -6),
                blurRadius: 16,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _BottomNavItem(
                  icon: Icons.home_outlined,
                  label: 'خانه',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: _BottomNavItem(
                  icon: Icons.explore_rounded,
                  label: 'کشف',
                  isSelected: true,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: _BottomNavItem(
                  icon: Icons.add_rounded,
                  isAddButton: true,
                  onTap: () {
                    // TODO: Open AddRecordPage.
                  },
                ),
              ),
              Expanded(
                child: _BottomNavItem(
                  icon: Icons.track_changes_rounded,
                  label: 'پیگیری',
                  onTap: () {
                    // TODO: Open HabitTrackerPage.
                  },
                ),
              ),
              Expanded(
                child: _BottomNavItem(
                  icon: Icons.person_outline_rounded,
                  label: 'پروفایل',
                  onTap: () {
                    // TODO: Open ProfilePage.
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopularHabit {
  final String title;
  final IconData icon;
  final String members;

  const _PopularHabit({
    required this.title,
    required this.icon,
    required this.members,
  });
}

class _ExplorePost {
  final String username;
  final String habit;
  final String caption;
  final String image;
  final int likes;

  const _ExplorePost({
    required this.username,
    required this.habit,
    required this.caption,
    required this.image,
    required this.likes,
  });
}

class _PopularHabitCard extends StatelessWidget {
  final _PopularHabit habit;
  final VoidCallback onTap;

  const _PopularHabitCard({
    required this.habit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 112,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.14),
              offset: const Offset(6, 6),
              blurRadius: 14,
            ),
            BoxShadow(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
              offset: const Offset(-5, -5),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              habit.icon,
              size: 30,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              habit.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              '${habit.members} نفر',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplorePostCard extends StatelessWidget {
  final _ExplorePost post;

  const _ExplorePostCard({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.14),
            offset: const Offset(8, 8),
            blurRadius: 18,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
            offset: const Offset(-6, -6),
            blurRadius: 16,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              14,
              16,
              12,
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withOpacity(0.15),
                        offset: const Offset(4, 4),
                        blurRadius: 8,
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
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        post.habit,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              post.caption,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.7,
              ),
            ),
          ),
          const SizedBox(height: 14),
          AspectRatio(
            aspectRatio: 1.2,
            child: Image.asset(
              post.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              12,
              8,
              12,
              12,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_rounded,
                  ),
                ),
                Text(
                  '${post.likes}',
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mode_comment_outlined,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.ios_share_rounded,
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

class _NeomorphicIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _NeomorphicIconButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.14),
            offset: const Offset(5, 5),
            blurRadius: 12,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
            offset: const Offset(-4, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String? label;
  final bool isSelected;
  final bool isAddButton;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.onTap,
    this.label,
    this.isSelected = false,
    this.isAddButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (isAddButton) {
      return Center(
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.18),
                offset: const Offset(5, 5),
                blurRadius: 12,
              ),
              BoxShadow(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
                offset: const Offset(-4, -4),
                blurRadius: 10,
              ),
            ],
          ),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      );
    }

    final color = isSelected
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          if (label != null) ...[
            const SizedBox(height: 3),
            Text(
              label!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
