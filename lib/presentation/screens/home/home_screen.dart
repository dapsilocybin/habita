import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habita/core/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // Hide Android system navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    // Mock posts data
    final posts = List.generate(6, (index) {
      return {
        "username": "User$index",
        "profilePic": "assets/images/man.jpg",
        "text": "This is a sample post for habit tracking #${index + 1}",
        "image": "assets/images/post.jpg",
        "likes": 5 * (index + 1),
        "comments": 2 * index,
      };
    });

    return Scaffold(
      backgroundColor: theme.colorScheme.surface.withOpacity(
        0.85,
      ), // darker surface
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface.withOpacity(0.85),
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/man.jpg"),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _PostCard(post: post, theme: theme),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.85),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, -4),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavButton(icon: Icons.home, label: "Home", theme: theme),
            _NavButton(icon: Icons.search, label: "Explore", theme: theme),
            _NavButton(
              icon: Icons.add_circle_outline,
              label: "Add",
              theme: theme,
              isCenter: true,
            ),
            _NavButton(
              icon: Icons.track_changes,
              label: "Tracker",
              theme: theme,
            ),
            _NavButton(icon: Icons.person, label: "Profile", theme: theme),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Map post;
  final ThemeData theme;

  const _PostCard({required this.post, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(8, 8),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.95),
            offset: const Offset(-8, -8),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(post['profilePic']),
            ),
            title: Text(
              post['username'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
          // Post text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(post['text']),
          ),
          // Post image
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(post['image']),
            ),
          ),
          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                _ActionButton(
                  icon: Icons.favorite_border,
                  count: post['likes'],
                  theme: theme,
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: Icons.mode_comment_outlined,
                  count: post['comments'],
                  theme: theme,
                ),
                const Spacer(),
                Icon(Icons.share_outlined, color: theme.colorScheme.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final ThemeData theme;

  const _ActionButton({
    required this.icon,
    required this.count,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        const SizedBox(width: 4),
        Text(count.toString()),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final ThemeData theme;
  final bool isCenter;

  const _NavButton({
    required this.icon,
    required this.label,
    required this.theme,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isCenter
          ? BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(6, 6),
                  blurRadius: 12,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  offset: const Offset(-6, -6),
                  blurRadius: 12,
                ),
              ],
            )
          : null,
      padding: isCenter ? const EdgeInsets.all(8.0) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 28),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
