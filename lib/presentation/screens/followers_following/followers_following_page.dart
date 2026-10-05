import 'package:flutter/material.dart';

enum FollowListType {
  followers,
  following,
}

class FollowersFollowingPage extends StatefulWidget {
  final FollowListType type;

  const FollowersFollowingPage({
    super.key,
    required this.type,
  });

  @override
  State<FollowersFollowingPage> createState() =>
      _FollowersFollowingPageState();
}

class _FollowersFollowingPageState
    extends State<FollowersFollowingPage> {
  final TextEditingController _searchController =
      TextEditingController();

  final List<_FollowUser> _users = [
    _FollowUser(
      name: 'علی رضایی',
      username: 'ali.dev',
      bio: 'در مسیر ساختن عادت‌های بهتر.',
      isFollowing: true,
    ),
    _FollowUser(
      name: 'سارا محمدی',
      username: 'sara.fit',
      bio: 'ورزش، مطالعه و رشد روزانه.',
      isFollowing: true,
    ),
    _FollowUser(
      name: 'محمد احمدی',
      username: 'mohammad',
      bio: 'هر روز یک قدم جلوتر.',
      isFollowing: false,
    ),
    _FollowUser(
      name: 'نگار کریمی',
      username: 'negar',
      bio: 'یادگیری هیچ‌وقت متوقف نمی‌شود.',
      isFollowing: true,
    ),
    _FollowUser(
      name: 'رضا موسوی',
      username: 'reza.life',
      bio: 'ساختن یک زندگی بهتر.',
      isFollowing: false,
    ),
    _FollowUser(
      name: 'امیرحسین',
      username: 'amir_h',
      bio: 'Consistency over motivation.',
      isFollowing: false,
    ),
    _FollowUser(
      name: 'مریم حسینی',
      username: 'maryam',
      bio: 'یک عادت خوب در هر روز.',
      isFollowing: true,
    ),
  ];

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_FollowUser> get _filteredUsers {
    if (_searchQuery.trim().isEmpty) {
      return _users;
    }

    final query = _searchQuery.trim().toLowerCase();

    return _users.where((user) {
      return user.name.toLowerCase().contains(query) ||
          user.username.toLowerCase().contains(query);
    }).toList();
  }

  String get _title {
    return widget.type == FollowListType.followers
        ? 'دنبال‌کنندگان'
        : 'دنبال‌شوندگان';
  }

  void _toggleFollow(int index) {
    final user = _filteredUsers[index];

    final originalIndex = _users.indexOf(user);

    if (originalIndex == -1) {
      return;
    }

    setState(() {
      _users[originalIndex] = user.copyWith(
        isFollowing: !user.isFollowing,
      );
    });
  }

  void _openUserProfile(_FollowUser user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'پروفایل ${user.name} در حال آماده‌سازی است.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final users = _filteredUsers;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchField(context),
          Expanded(
            child: users.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      8,
                      20,
                      24,
                    ),
                    itemCount: users.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildUserTile(
                        context,
                        users[index],
                        index,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'جستجوی کاربر...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    _searchController.clear();

                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
          filled: true,
          fillColor: colorScheme.surfaceContainerLow,
        ),
      ),
    );
  }

  Widget _buildUserTile(
    BuildContext context,
    _FollowUser user,
    int index,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () => _openUserProfile(user),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.10),
              offset: const Offset(6, 6),
              blurRadius: 14,
            ),
            BoxShadow(
              color: colorScheme.surfaceContainerHighest
                  .withOpacity(0.7),
              offset: const Offset(-5, -5),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          children: [
            _buildAvatar(colorScheme),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '@${user.username}',
                    textDirection: TextDirection.ltr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.bio,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _buildFollowButton(
              context,
              user,
              index,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(ColorScheme colorScheme) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.16),
            offset: const Offset(5, 5),
            blurRadius: 10,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest
                .withOpacity(0.8),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.all(2),
      child: ClipOval(
        child: Image.asset(
          'assets/images/man.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildFollowButton(
    BuildContext context,
    _FollowUser user,
    int index,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 96,
      height: 38,
      child: user.isFollowing
          ? OutlinedButton(
              onPressed: () => _toggleFollow(index),
              child: const Text('دنبال می‌کنی'),
            )
          : ElevatedButton(
              onPressed: () => _toggleFollow(index),
              child: const Text('دنبال کردن'),
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final hasSearch = _searchQuery.trim().isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasSearch
                  ? Icons.person_search_outlined
                  : Icons.people_outline,
              size: 64,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              hasSearch
                  ? 'کاربری پیدا نشد'
                  : widget.type == FollowListType.followers
                      ? 'هنوز دنبال‌کننده‌ای نداری'
                      : 'هنوز کسی را دنبال نمی‌کنی',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasSearch
                  ? 'عبارت دیگری را برای جستجو امتحان کن.'
                  : 'با دنبال کردن افراد، مسیر رشدشان را دنبال کن.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FollowUser {
  final String name;
  final String username;
  final String bio;
  final bool isFollowing;

  const _FollowUser({
    required this.name,
    required this.username,
    required this.bio,
    this.isFollowing = false,
  });

  _FollowUser copyWith({
    String? name,
    String? username,
    String? bio,
    bool? isFollowing,
  }) {
    return _FollowUser(
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}