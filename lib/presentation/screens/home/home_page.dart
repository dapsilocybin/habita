import 'dart:async';

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
import 'package:habita/presentation/screens/comments/comments_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String _toPersianDigits(int number) {
  const persian = '۰۱۲۳۴۵۶۷۸۹';
  return number.toString().split('').map((digit) {
    final index = int.tryParse(digit);
    return index == null ? digit : persian[index];
  }).join();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.onNavigate});

  /// Indexes: Home = 0, Explore = 1, Add Record = 2,
  /// Habit Tracker = 3, Profile = 4.
  final ValueChanged<int>? onNavigate;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleNavigation(int index, HomeBloc homeBloc) {
    if (index == 0) return;

    if (widget.onNavigate != null) {
      widget.onNavigate!(index);
      return;
    }

    if (index == 2) {
      Navigator.of(context)
          .push<bool>(MaterialPageRoute(builder: (_) => const AddRecordPage()))
          .then((wasPublished) {
            if (!mounted) return;

            if (wasPublished == true) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('ثبت تلاش با موفقیت انجام شد'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
            }

            homeBloc.add(const HomeFeedRefreshed());
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
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
                                  debugPrint(
                                    'Rendering post: ${post.id} - ${post.image}',
                                  );
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
                                          showModalBottomSheet<void>(
                                            context: context,
                                            isScrollControlled: true,
                                            useSafeArea: true,
                                            sheetAnimationStyle:
                                                const AnimationStyle(
                                                  duration: Duration(
                                                    milliseconds: 350,
                                                  ),
                                                ),
                                            backgroundColor: Theme.of(
                                              context,
                                            ).colorScheme.surface,
                                            shape:
                                                const RoundedRectangleBorder(),
                                            builder: (context) {
                                              return Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: FractionallySizedBox(
                                                  heightFactor: 1,
                                                  child: CommentsPage(
                                                    recordId: post.id,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((_) {
                                            if (context.mounted) {
                                              context.read<HomeBloc>().add(
                                                const HomeFeedRefreshed(),
                                              );
                                            }
                                          });
                                        },
                                        onMore: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            showDragHandle: true,
                                            builder: (context) {
                                              return Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
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
                                          color: colors.outlineVariant
                                              .withOpacity(0.65),
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
              Positioned(
                bottom: 0,
                left: 16,
                right: 16,
                child: const IgnorePointer(child: _WelcomeNotification()),
              ),
            ],
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

class _WelcomeNotification extends StatefulWidget {
  const _WelcomeNotification();

  @override
  State<_WelcomeNotification> createState() => _WelcomeNotificationState();
}

class _WelcomeNotificationState extends State<_WelcomeNotification> {
  Timer? _dismissTimer;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _dismissTimer = Timer(const Duration(seconds: 6), () {
      if (!mounted) return;
      setState(() => _isVisible = false);
    });
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return AnimatedSlide(
      offset: _isVisible ? Offset.zero : const Offset(0, 0.15),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 250),
        child: Material(
          color: colors.surfaceContainerHigh,
          elevation: 8,
          shadowColor: colors.shadow.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.spa_rounded, color: colors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'سلام! با یک قدم کوچک شروع کن 👋',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colors.primary,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RemotePostImage extends StatefulWidget {
  const _RemotePostImage({required this.imageReference});

  final String imageReference;

  @override
  State<_RemotePostImage> createState() => _RemotePostImageState();
}

class _RemotePostImageState extends State<_RemotePostImage> {
  late Future<String> _imageUrlFuture;

  @override
  void initState() {
    super.initState();
    _imageUrlFuture = _createSignedUrl(widget.imageReference);
  }

  @override
  void didUpdateWidget(covariant _RemotePostImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.imageReference != widget.imageReference) {
      _imageUrlFuture = _createSignedUrl(widget.imageReference);
    }
  }

  Future<String> _createSignedUrl(String imageReference) async {
    const bucketName = 'habit-record-images';

    final uri = Uri.tryParse(imageReference);

    String storagePath;

    if (uri != null && uri.hasScheme) {
      const publicUrlPrefix = '/storage/v1/object/public/$bucketName/';

      final pathIndex = uri.path.indexOf(publicUrlPrefix);

      if (pathIndex == -1) {
        throw FormatException('Invalid Supabase Storage URL: $imageReference');
      }

      storagePath = uri.path.substring(pathIndex + publicUrlPrefix.length);
    } else {
      // Also supports receiving the Storage path directly.
      storagePath = imageReference;
    }

    if (storagePath.isEmpty) {
      throw const FormatException('Storage path is empty.');
    }

    return Supabase.instance.client.storage
        .from(bucketName)
        .createSignedUrl(storagePath, 3600);
  }

  Widget _imagePlaceholder(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: FutureBuilder<String>(
        future: _imageUrlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return _imagePlaceholder(context);
          }

          return Image.network(
            snapshot.data!,
            width: double.infinity,
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return _imagePlaceholder(context);
            },
          );
        },
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
                  tooltip: 'اطلاعات عادت',
                  onPressed: () => _showHabitDetails(context),
                  icon: const Icon(Icons.info_outline_rounded),
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
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: Text(
              post.caption,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.8,
                color: colors.onSurface,
              ),
            ),
          ),

          if (post.image != null) _RemotePostImage(imageReference: post.image!),
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

  void _showHabitDetails(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final theme = Theme.of(context);
        final colors = theme.colorScheme;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اطلاعات عادت',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _HabitDetailRow(
                  icon: Icons.self_improvement_rounded,
                  label: 'عادت',
                  value: post.habitName,
                  colors: colors,
                  theme: theme,
                ),
                const SizedBox(height: 14),
                _HabitDetailRow(
                  icon: Icons.repeat_rounded,
                  label: 'تکرار',
                  value: post.frequency,
                  colors: colors,
                  theme: theme,
                ),
                const SizedBox(height: 14),
                _HabitDetailRow(
                  icon: Icons.insights_rounded,
                  label: 'شماره ثبت',
                  value: _toPersianDigits(post.recordNumber),
                  colors: colors,
                  theme: theme,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HabitDetailRow extends StatelessWidget {
  const _HabitDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.colors,
    required this.theme,
  });

  final IconData icon;
  final String label;
  final String value;
  final ColorScheme colors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: colors.primary),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
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

class _PostCommentsSheet extends StatefulWidget {
  const _PostCommentsSheet();

  @override
  State<_PostCommentsSheet> createState() => _PostCommentsSheetState();
}

class _PostCommentsSheetState extends State<_PostCommentsSheet> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final availableHeight =
        mediaQuery.size.height - mediaQuery.viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: availableHeight * 0.72,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Text(
                  'دیدگاه‌ها',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.mode_comment_outlined,
                          size: 48,
                          color: colors.primary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'هنوز دیدگاهی ثبت نشده است',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'اولین نفری باشید که دیدگاه می‌گذارد.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 19,
                      backgroundImage: AssetImage('assets/images/man.jpg'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        autofocus: true,
                        minLines: 1,
                        maxLines: 4,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: 'دیدگاه خود را بنویسید...',
                          isDense: true,
                          filled: true,
                          fillColor: colors.surfaceContainerHighest.withValues(
                            alpha: 0.45,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
