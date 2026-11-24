import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/core/config/post_share_config.dart';
import 'package:habita/data/models/followed_user_model.dart';
import 'package:habita/data/models/habit_post_model.dart';
import 'package:habita/data/providers/post_share_provider.dart';
import 'package:habita/data/repositories/post_share_repository.dart';
import 'package:habita/logic/blocs/post_share/post_share_bloc.dart';
import 'package:habita/logic/blocs/post_share/post_share_event.dart';
import 'package:habita/logic/blocs/post_share/post_share_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.isLiked,
    required this.onLike,
    required this.onComment,
    required this.onMore,
    this.onCardTap,
    this.onShare,
    this.onBookmark,
    this.isBookmarked = false,
  });

  final HabitPost post;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onMore;
  final VoidCallback? onCardTap;
  final VoidCallback? onShare;
  final VoidCallback? onBookmark;
  final bool isBookmarked;

  static const double _radius = 4;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final content = Padding(
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
          if (post.image != null)
            Hero(
              tag: 'post_image_${post.id}',
              child: PostImage(
                imageReference: post.image!,
                borderRadius: _radius,
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
                if (onBookmark != null)
                  IconButton(
                    tooltip: isBookmarked ? 'لغو ذخیره' : 'ذخیره',
                    onPressed: onBookmark,
                    icon: Icon(
                      isBookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: colors.onSurface,
                    ),
                  ),
                IconButton(
                  tooltip: 'اشتراک‌گذاری',
                  onPressed: onShare ?? () => showPostShareSheet(context, post),
                  icon: Icon(Icons.share_outlined, color: colors.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final card = onCardTap == null
        ? content
        : Material(
            color: Colors.transparent,
            child: InkWell(onTap: onCardTap, child: content),
          );

    return Directionality(textDirection: TextDirection.rtl, child: card);
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
                  value: post.recordNumber.toString(),
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

  static Future<void> showPostShareSheet(
    BuildContext context,
    HabitPost post,
  ) async {
    final shareUrl = PostShareConfig.postUrl(post.id);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BlocProvider(
            create: (_) => PostShareBloc(
              repository: PostShareRepository(provider: PostShareProvider()),
            )..add(const PostShareRecipientsRequested()),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'اشتراک‌گذاری',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: const Icon(Icons.link_rounded),
                      title: const Text('کپی لینک'),
                      subtitle: Text(
                        shareUrl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: shareUrl));
                        if (!sheetContext.mounted) return;
                        ScaffoldMessenger.of(sheetContext)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text('لینک کپی شد'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.share_outlined),
                      title: const Text('اشتراک‌گذاری با اندروید'),
                      onTap: () async {
                        await SharePlus.instance.share(
                          ShareParams(text: '${post.caption}\n$shareUrl'),
                        );
                      },
                    ),
                    const Divider(),
                    const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'ارسال برای یک کاربر',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    BlocConsumer<PostShareBloc, PostShareState>(
                      listener: (context, state) {
                        if (state is PostShareSuccess) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('پست با موفقیت ارسال شد'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                        } else if (state is PostShareError &&
                            state.recipients.isNotEmpty) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  'ارسال ناموفق بود: ${state.message}',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                        }
                      },
                      builder: (context, state) {
                        if (state is PostShareRecipientsLoading ||
                            state is PostShareInitial) {
                          return const Padding(
                            padding: EdgeInsets.all(24),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (state is PostShareError &&
                            state.recipients.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'بارگذاری کاربران ناموفق بود',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          );
                        }

                        final recipients = state is PostShareRecipientsLoaded
                            ? state.recipients
                            : state is PostShareSubmitting
                            ? state.recipients
                            : state is PostShareError
                            ? state.recipients
                            : const <FollowedUser>[];

                        if (recipients.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'کاربری برای اشتراک‌گذاری پیدا نشد',
                              textAlign: TextAlign.center,
                            ),
                          );
                        }

                        final submitting = state is PostShareSubmitting;
                        final recipientId = submitting
                            ? state.recipientId
                            : null;

                        return ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 260),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: recipients.length,
                            separatorBuilder: (_, _) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final recipient = recipients[index];
                              final isSubmitting =
                                  submitting && recipientId == recipient.id;

                              return ListTile(
                                enabled: !submitting,
                                leading: CircleAvatar(
                                  child: Text(
                                    recipient.fullName.isNotEmpty
                                        ? recipient.fullName[0]
                                        : recipient.username.isNotEmpty
                                        ? recipient.username[0]
                                        : '?',
                                  ),
                                ),
                                title: Text(
                                  recipient.fullName.isNotEmpty
                                      ? recipient.fullName
                                      : recipient.username,
                                ),
                                subtitle: recipient.username.isNotEmpty
                                    ? Text('@${recipient.username}')
                                    : null,
                                trailing: isSubmitting
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.send_rounded),
                                onTap: submitting
                                    ? null
                                    : () {
                                        context.read<PostShareBloc>().add(
                                          PostSharedWithUserRequested(
                                            recordId: post.id,
                                            recipientId: recipient.id,
                                          ),
                                        );
                                      },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PostImage extends StatefulWidget {
  const PostImage({required this.imageReference, this.borderRadius = 4});

  final String imageReference;
  final double borderRadius;

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  late Future<String> _imageUrlFuture;

  @override
  void initState() {
    super.initState();
    _imageUrlFuture = _createSignedUrl(widget.imageReference);
  }

  @override
  void didUpdateWidget(covariant PostImage oldWidget) {
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
      storagePath = imageReference;
    }

    if (storagePath.isEmpty) {
      throw const FormatException('Storage path is empty.');
    }

    return Supabase.instance.client.storage
        .from(bucketName)
        .createSignedUrl(storagePath, 3600);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: FutureBuilder<String>(
        future: _imageUrlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AspectRatio(
              aspectRatio: 4 / 3,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return ColoredBox(
              color: colors.surfaceContainerHighest,
              child: const SizedBox(
                height: 180,
                child: Center(child: Icon(Icons.image_not_supported_outlined)),
              ),
            );
          }
          return Image.network(
            snapshot.data!,
            width: double.infinity,
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) => ColoredBox(
              color: colors.surfaceContainerHighest,
              child: const SizedBox(
                height: 180,
                child: Center(child: Icon(Icons.image_not_supported_outlined)),
              ),
            ),
          );
        },
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
