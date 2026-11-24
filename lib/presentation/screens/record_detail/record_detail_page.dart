import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/models/habit_post_model.dart';
import 'package:habita/data/providers/home_provider.dart';
import 'package:habita/data/repositories/home_repository.dart';
import 'package:habita/logic/blocs/home/home_bloc.dart';
import 'package:habita/logic/blocs/home/home_event.dart';
import 'package:habita/logic/blocs/home/home_state.dart';
import 'package:habita/presentation/screens/comments/comments_page.dart';
import 'package:habita/presentation/widgets/post_card.dart';

class RecordDetailPage extends StatelessWidget {
  const RecordDetailPage({super.key, required this.recordId, this.initialPost});

  final String recordId;
  final HabitPost? initialPost;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeBloc(homeRepository: HomeRepository(homeProvider: HomeProvider()))
            ..add(
              initialPost == null
                  ? HomePostRequested(recordId)
                  : HomePostRequested(recordId),
            ),
      child: _RecordDetailContent(recordId: recordId, initialPost: initialPost),
    );
  }
}

class _RecordDetailContent extends StatefulWidget {
  const _RecordDetailContent({required this.recordId, this.initialPost});

  final String recordId;
  final HabitPost? initialPost;

  @override
  State<_RecordDetailContent> createState() => _RecordDetailContentState();
}

class _RecordDetailContentState extends State<_RecordDetailContent> {
  bool _isBookmarked = false;

  void _openComments(BuildContext context, String recordId) {
    final bloc = context.read<HomeBloc>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: FractionallySizedBox(
          heightFactor: 1,
          child: CommentsPage(recordId: recordId),
        ),
      ),
    ).then((_) {
      if (!mounted) return;
      bloc.add(HomePostRequested(recordId));
    });
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    _isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                  ),
                  title: Text(_isBookmarked ? 'لغو ذخیره' : 'ذخیره رکورد'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    setState(() => _isBookmarked = !_isBookmarked);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.flag_outlined),
                  title: const Text('گزارش رکورد'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(sheetContext).showSnackBar(
                      const SnackBar(
                        content: Text('گزارش رکورد در مرحله بعد فعال می‌شود.'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('رکورد')),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (widget.initialPost != null && state is HomeInitial) {
            return _buildPost(context, widget.initialPost!);
          }

          if (state is HomeLoading) {
            if (widget.initialPost != null) {
              return _buildPost(context, widget.initialPost!);
            }
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeLoaded) {
            HabitPost? post;
            for (final item in state.posts) {
              if (item.id == widget.recordId) {
                post = item;
                break;
              }
            }
            if (post == null) {
              return _buildUnavailable(context);
            }
            return _buildPost(context, post);
          }

          if (state is HomeError) {
            if (widget.initialPost != null) {
              return _buildPost(context, widget.initialPost!);
            }
            return _buildUnavailable(context);
          }

          if (widget.initialPost != null) {
            return _buildPost(context, widget.initialPost!);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildPost(BuildContext context, HabitPost post) {
    final state = context.watch<HomeBloc>().state;
    final isLiked = state is HomeLoaded && state.likedPostIds.contains(post.id);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: PostCard(
          post: post,
          isLiked: isLiked,
          isBookmarked: _isBookmarked,
          onLike: () {
            context.read<HomeBloc>().add(HomePostLikeToggled(post.id));
          },
          onComment: () => _openComments(context, post.id),
          onMore: () => _showMoreOptions(context),
          onBookmark: () {
            setState(() => _isBookmarked = !_isBookmarked);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _isBookmarked ? 'رکورد ذخیره شد' : 'ذخیره لغو شد',
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUnavailable(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.visibility_off_outlined,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'این رکورد حذف شده یا در دسترس نیست.',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('بازگشت'),
            ),
          ],
        ),
      ),
    );
  }
}
