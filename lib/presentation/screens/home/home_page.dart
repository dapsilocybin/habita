import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/core/theme/app_theme.dart';
import 'package:habita/data/models/habit_post_model.dart';
import 'package:habita/data/providers/home_provider.dart';
import 'package:habita/data/repositories/home_repository.dart';
import 'package:habita/logic/blocs/home/home_bloc.dart';
import 'package:habita/logic/blocs/home/home_event.dart';
import 'package:habita/logic/blocs/home/home_state.dart';
import 'package:habita/presentation/widgets/habita_bottom_navigation.dart';
import 'package:habita/presentation/screens/add_record/add_record_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.onNavigate});

  /// Indexes: Home = 0, Explore = 1, Add Record = 2,
  /// Habit Tracker = 3, Profile = 4.
  final ValueChanged<int>? onNavigate;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showWelcomeSection = true;

  void _handleNavigation(int index, HomeBloc homeBloc) {
    if (index == 0) return;

    if (widget.onNavigate != null) {
      widget.onNavigate!(index);
      return;
    }

    if (index == 2) {
      Navigator.of(context)
          .push<void>(MaterialPageRoute(builder: (_) => const AddRecordPage()))
          .then((_) {
            if (mounted) {
              homeBloc.add(const HomeFeedRefreshed());
            }
          });
      return;
    }

    const messages = {
      1: 'بخش کشف هنوز به صفحه اصلی متصل نشده است.',
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
    return BlocProvider(
      create: (_) =>
          HomeBloc(homeRepository: HomeRepository(homeProvider: HomeProvider()))
            ..add(const HomeFeedRequested()),
      child: _buildHomeContent(),
    );
  }

  Widget _buildHomeContent() {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final neo = theme.extension<NeomorphismStyleExtension>();

    final shadows =
        neo?.shadows ??
        [
          BoxShadow(
            color: colors.shadow.withOpacity(0.10),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
        ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  final bloc = context.read<HomeBloc>();

                  bloc.add(const HomeFeedRefreshed());

                  await bloc.stream.firstWhere(
                    (state) => state is HomeLoaded || state is HomeError,
                  );
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildHeader(
                        theme,
                        shadows,
                        context.read<HomeBloc>(),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: Alignment.topCenter,
                        child: _showWelcomeSection
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      tooltip: 'بستن',
                                      icon: const Icon(Icons.close_rounded),
                                      onPressed: () {
                                        setState(() {
                                          _showWelcomeSection = false;
                                        });
                                      },
                                    ),
                                  ),
                                  _buildWelcomeSection(theme),
                                  _buildHabitPrompt(
                                    theme,
                                    shadows,
                                    context.read<HomeBloc>(),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),

                    SliverToBoxAdapter(child: _buildFeedHeader(theme)),

                    if (state is HomeLoaded) ...[
                      if (state.posts.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: _buildEmptyFeed(theme),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.only(bottom: 24),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final post = state.posts[index];

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _PostCard(
                                    post: post,
                                    isLiked: state.likedPostIds.contains(
                                      post.id,
                                    ),
                                    onLike: () {
                                      context.read<HomeBloc>().add(
                                        HomePostLikeToggled(post.id),
                                      );
                                    },
                                    onComment: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
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
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: SafeArea(
                                              child: ListTile(
                                                leading: const Icon(
                                                  Icons.flag_outlined,
                                                ),
                                                title: const Text(
                                                  'گزارش این محتوا',
                                                ),
                                                onTap: () {
                                                  Navigator.pop(context);

                                                  ScaffoldMessenger.of(
                                                      this.context,
                                                    )
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
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  if (index < state.posts.length - 1)
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      indent: 16,
                                      endIndent: 16,
                                      color: colors.outlineVariant.withOpacity(
                                        0.65,
                                      ),
                                    ),
                                ],
                              );
                            }, childCount: state.posts.length),
                          ),
                        ),
                    ] else if (state is HomeError) ...[
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: _buildFeedError(theme, state.message),
                      ),
                    ] else ...[
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Builder(
          builder: (homeContext) => HabitaBottomNavigation(
            selectedIndex: 0,
            onItemSelected: (index) {
              _handleNavigation(index, homeContext.read<HomeBloc>());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyFeed(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.dynamic_feed_outlined,
              size: 52,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'هنوز تلاشی ثبت نشده است.',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'اولین نفری باش که تلاشت رو با جامعه به اشتراک می‌ذاره.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedError(ThemeData theme, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(
              'دریافت تلاش‌ها با مشکل مواجه شد.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                context.read<HomeBloc>().add(const HomeFeedRequested());
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('تلاش مجدد'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    ThemeData theme,
    List<BoxShadow> shadows,
    HomeBloc homeBloc,
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
            onTap: () => _handleNavigation(1, homeBloc),
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
    HomeBloc homeBloc,
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
                onPressed: () => _handleNavigation(2, homeBloc),
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
          Icon(Icons.groups_2_outlined, color: colors.primary, size: 20),
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
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.post,
    required this.isLiked,
    required this.onLike,
    required this.onComment,
    required this.onMore,
  });

  final HabitPost post;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 23,
                  backgroundImage: AssetImage('assets/images/man.jpg'),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userFullName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${post.username} · ${post.time}',
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
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _PostTag(
                  label: post.habitName,
                  icon: Icons.self_improvement_rounded,
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                ),
                _PostTag(
                  label: post.frequency,
                  icon: Icons.repeat_rounded,
                  backgroundColor: const Color(0xFF6A1B9A),
                  foregroundColor: Colors.white,
                ),
                _HabitRecordTag(recordCount: post.habitRecordCount),
              ],
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
          if (post.image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: AspectRatio(
                aspectRatio: 1.15,
                child: Image.asset(
                  post.image!,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
            child: Row(
              children: [
                _PostAction(
                  icon: isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  label: '${post.likes}',
                  color: isLiked ? colors.error : colors.onSurface,
                  onTap: onLike,
                ),
                const SizedBox(width: 18),
                _PostAction(
                  icon: Icons.mode_comment_outlined,
                  label: '${post.comments}',
                  color: colors.onSurface,
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
                  icon: Icon(Icons.share_outlined, color: colors.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostTag extends StatelessWidget {
  const _PostTag({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: foregroundColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitRecordTag extends StatelessWidget {
  const _HabitRecordTag({required this.recordCount});

  final int recordCount;

  @override
  Widget build(BuildContext context) {
    final milestone = _milestoneFor(recordCount);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: milestone.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: milestone.foregroundColor.withOpacity(0.75),
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(milestone.icon, size: 17, color: milestone.foregroundColor),
          const SizedBox(width: 5),
          Text(
            '$recordCount',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: milestone.foregroundColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  _RecordMilestone _milestoneFor(int count) {
    if (count >= 100) {
      return const _RecordMilestone(
        icon: Icons.workspace_premium_rounded,
        backgroundColor: Color(0xFFFFD54F),
        foregroundColor: Color(0xFF4E342E),
      );
    }

    if (count >= 50) {
      return const _RecordMilestone(
        icon: Icons.military_tech_rounded,
        backgroundColor: Color(0xFFB0BEC5),
        foregroundColor: Color(0xFF263238),
      );
    }

    if (count >= 25) {
      return const _RecordMilestone(
        icon: Icons.emoji_events_rounded,
        backgroundColor: Color(0xFFFFAB91),
        foregroundColor: Color(0xFF7F2704),
      );
    }

    if (count >= 10) {
      return const _RecordMilestone(
        icon: Icons.stars_rounded,
        backgroundColor: Color(0xFF80DEEA),
        foregroundColor: Color(0xFF004D40),
      );
    }

    return const _RecordMilestone(
      icon: Icons.bolt_rounded,
      backgroundColor: Color(0xFFC5E1A5),
      foregroundColor: Color(0xFF33691E),
    );
  }
}

class _RecordMilestone {
  const _RecordMilestone({
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
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
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
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
