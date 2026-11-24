import 'package:flutter/material.dart';
import 'package:habita/data/models/habit_post_model.dart';
import 'package:habita/data/providers/home_provider.dart';
import 'package:habita/data/repositories/home_repository.dart';
import 'package:habita/presentation/screens/record_detail/record_detail_page.dart';
import 'package:habita/presentation/widgets/post_card.dart';

class SharedPostMessage extends StatefulWidget {
  const SharedPostMessage({super.key, required this.recordId});

  final String recordId;

  @override
  State<SharedPostMessage> createState() => _SharedPostMessageState();
}

class _SharedPostMessageState extends State<SharedPostMessage> {
  late Future<HabitPost?> _postFuture;

  @override
  void initState() {
    super.initState();
    _postFuture = _loadPost();
  }

  Future<HabitPost?> _loadPost() {
    return HomeRepository(
      homeProvider: HomeProvider(),
    ).fetchPost(widget.recordId);
  }

  @override
  void didUpdateWidget(covariant SharedPostMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.recordId != widget.recordId) {
      _postFuture = _loadPost();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FutureBuilder<HabitPost?>(
      future: _postFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 220,
            height: 96,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final post = snapshot.data;
        if (snapshot.hasError || post == null) {
          return _unavailable(colors);
        }

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) =>
                    RecordDetailPage(recordId: post.id, initialPost: post),
              ),
            );
          },
          child: Container(
            width: 260,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 13,
                      backgroundImage: AssetImage('assets/images/man.jpg'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        post.userFullName.isNotEmpty
                            ? post.userFullName
                            : post.username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const Icon(Icons.open_in_new_rounded, size: 16),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  post.caption,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (post.image != null) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: PostImage(
                      imageReference: post.image!,
                      borderRadius: 10,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _unavailable(ColorScheme colors) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.visibility_off_outlined),
          SizedBox(width: 8),
          Flexible(child: Text('این پست در دسترس نیست.')),
        ],
      ),
    );
  }
}
