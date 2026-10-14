import 'package:flutter/material.dart';
import 'package:habita/core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.onNavigate,
  });

  /// Indexes: Home = 0, Explore = 1, Add Record = 2,
  /// Habit Tracker = 3, Profile = 4.
  final ValueChanged<int>? onNavigate;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<int> _likedPosts = {};

  static const List<_HabitPost> _posts = [
    _HabitPost(
      id: 1,
      username: 'علی رضایی',
      handle: '@ali.r',
      habit: 'ورزش روزانه',
      time: '۲۰ دقیقه پیش',
      caption:
          'امروز هم با اینکه خیلی خسته بودم، تمرینم رو انجام دادم. '
          'قرار نیست هر روز عالی باشیم؛ فقط باید ادامه بدیم. 💪',
      image: 'assets/images/post.jpg',
      likes: 24,
      comments: 6,
    ),
    _HabitPost(
      id: 2,
      username: 'مریم احمدی',
      handle: '@maryam.a',
      habit: 'مطالعه روزانه',
      time: '۱ ساعت پیش',
      caption:
          'فقط ده صفحه خوندم، ولی به قول خودم عمل کردم. '
          'قدم‌های کوچیک هم حساب می‌شن. 📚',
      image: 'assets/images/post.jpg',
      likes: 18,
      comments: 3,
    ),
    _HabitPost(
      id: 3,
      username: 'امیر محمدی',
      handle: '@amir.m',
      habit: 'خواب منظم',
      time: '۳ ساعت پیش',
      caption:
          'دیشب زودتر گوشی رو کنار گذاشتم و امروز صبح '
          'با انرژی بیشتری بیدار شدم.',
      image: 'assets/images/post.jpg',
      likes: 12,
      comments: 2,
    ),
  ];

  void _handleNavigation(int index) {
    if (index == 0) return;

    if (widget.onNavigate != null) {
      widget.onNavigate!(index);
      return;
    }

    const messages = {
      1: 'بخش کشف هنوز به صفحه اصلی متصل نشده است.',
      2: 'بخش ثبت تلاش هنوز به صفحه اصلی متصل نشده است.',
      3: 'بخش پیگیری عادت‌ها هنوز به صفحه اصلی متصل نشده است.',
      4: 'بخش پروفایل هنوز به صفحه اصلی متصل نشده است.',
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(messages[index] ?? 'این بخش هنوز آماده نیست.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final neo = theme.extension<NeomorphismStyleExtension>();

    final shadows = neo?.shadows ??
        [
          BoxShadow(
            color: colors.shadow.withOpacity(0.10),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
        ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(theme, shadows),
            ),
            SliverToBoxAdapter(
              child: _buildWelcomeSection(theme),
            ),
            SliverToBoxAdapter(
              child: _buildHabitPrompt(theme, shadows),
            ),
            SliverToBoxAdapter(
              child: _buildFeedHeader(theme),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = _posts[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: _PostCard(
                        post: post,
                        isLiked: _likedPosts.contains(post.id),
                        shadows: shadows,
                        onLike: () {
                          setState(() {
                            if (!_likedPosts.add(post.id)) {
                              _likedPosts.remove(post.id);
                            }
                          });
                        },
                        onComment: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'بخش دیدگاه‌ها در مرحله بعد اضافه می‌شود.',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        onMore: () {
                          showModalBottomSheet<void>(
                            context: context,
                            showDragHandle: true,
                            builder: (context) {
                              return SafeArea(
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.flag_outlined,
                                  ),
                                  title: const Text('گزارش این محتوا'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(this.context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'گزارش محتوا بعداً فعال می‌شود.',
                                          ),
                                        ),
                                      );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                  childCount: _posts.length,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(
        theme,
        shadows,
      ),
    );
  }

  Widget _buildHeader(
    ThemeData theme,
    List<BoxShadow> shadows,
  ) {
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.surface,
              boxShadow: shadows,
            ),
            padding: const EdgeInsets.all(3),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/man.jpg'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Habita',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  'هر روز، یک قدم بهتر',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          _HeaderIconButton(
            icon: Icons.search_rounded,
            tooltip: 'جست‌وجو',
            onTap: () => _handleNavigation(1),
            shadows: shadows,
          ),
          const SizedBox(width: 10),
          _HeaderIconButton(
            icon: Icons.notifications_none_rounded,
            tooltip: 'اعلان‌ها',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('اعلان‌ها در مرحله بعد اضافه می‌شوند.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            shadows: shadows,
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(ThemeData theme) {
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'سلام، خوش اومدی 👋',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'امروز برای بهتر شدن چه قدمی برمی‌داری؟',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitPrompt(
    ThemeData theme,
    List<BoxShadow> shadows,
  ) {
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: shadows,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.spa_rounded,
                    color: colors.onPrimaryContainer,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'شروع با یک قدم کوچک',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'تلاشت می‌تونه به بقیه هم انگیزه بده.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _handleNavigation(2),
                icon: const Icon(Icons.add_rounded),
                label: const Text('ثبت تلاش امروز'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedHeader(ThemeData theme) {
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        children: [
          Text(
            'تلاش‌های جامعه',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: colors.onSurface,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.groups_2_outlined,
            color: colors.primary,
            size: 20,
          ),
          const SizedBox(width: 6),
          Text(
            'برای الهام گرفتن',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(
    ThemeData theme,
    List<BoxShadow> shadows,
  ) {
    final colors = theme.colorScheme;

    const items = [
      _NavItemData(
        icon: Icons.home_rounded,
        label: 'خانه',
      ),
      _NavItemData(
        icon: Icons.explore_outlined,
        label: 'کشف',
      ),
      _NavItemData(
        icon: Icons.add_rounded,
        label: 'ثبت تلاش',
      ),
      _NavItemData(
        icon: Icons.track_changes_rounded,
        label: 'پیگیری',
      ),
      _NavItemData(
        icon: Icons.person_outline_rounded,
        label: 'پروفایل',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withOpacity(0.08),
            offset: const Offset(0, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];

              if (index == 2) {
                return Expanded(
                  child: _AddNavigationButton(
                    item: item,
                    color: colors.primary,
                    onTap: () => _handleNavigation(index),
                  ),
                );
              }

              return Expanded(
                child: _BottomNavigationItem(
                  item: item,
                  selected: index == 0,
                  theme: theme,
                  onTap: () => _handleNavigation(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.post,
    required this.isLiked,
    required this.shadows,
    required this.onLike,
    required this.onComment,
    required this.onMore,
  });

  final _HabitPost post;
  final bool isLiked;
  final List<BoxShadow> shadows;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: shadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 8, 12),
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
                        post.username,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${post.handle} · ${post.time}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'گزینه‌های بیشتر',
                  onPressed: onMore,
                  icon: const Icon(Icons.more_horiz_rounded),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.self_improvement_rounded,
                    size: 16,
                    color: colors.onPrimaryContainer,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    post.habit,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Text(
              post.caption,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.8,
                color: colors.onSurface,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: AspectRatio(
                aspectRatio: 1.15,
                child: Image.asset(
                  post.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return ColoredBox(
                      color: colors.surfaceContainerHighest,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 36,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Row(
              children: [
                _PostAction(
                  icon: isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  label: '${post.likes + (isLiked ? 1 : 0)}',
                  color: isLiked ? colors.error : colors.onSurfaceVariant,
                  onTap: onLike,
                ),
                const SizedBox(width: 20),
                _PostAction(
                  icon: Icons.mode_comment_outlined,
                  label: '${post.comments}',
                  color: colors.onSurfaceVariant,
                  onTap: onComment,
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'اشتراک‌گذاری',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'اشتراک‌گذاری در مرحله بعد اضافه می‌شود.',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.share_outlined,
                    color: colors.onSurfaceVariant,
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

class _PostAction extends StatelessWidget {
  const _PostAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 6,
        ),
        child: Row(
          children: [
            Icon(icon, size: 21, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.shadows,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: shadows,
      ),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onTap,
        icon: Icon(icon, color: colors.primary),
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  const _BottomNavigationItem({
    required this.item,
    required this.selected,
    required this.theme,
    required this.onTap,
  });

  final _NavItemData item;
  final bool selected;
  final ThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = theme.colorScheme;

    final color = selected
        ? colors.primary
        : colors.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, size: 23, color: color),
            const SizedBox(height: 4),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: selected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddNavigationButton extends StatelessWidget {
  const _AddNavigationButton({
    required this.item,
    required this.color,
    required this.onTap,
  });

  final _NavItemData item;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(item.icon, color: Colors.white, size: 25),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HabitPost {
  const _HabitPost({
    required this.id,
    required this.username,
    required this.handle,
    required this.habit,
    required this.time,
    required this.caption,
    required this.image,
    required this.likes,
    required this.comments,
  });

  final int id;
  final String username;
  final String handle;
  final String habit;
  final String time;
  final String caption;
  final String image;
  final int likes;
  final int comments;
}

class _NavItemData {
  const _NavItemData({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

