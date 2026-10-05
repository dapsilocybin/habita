import 'package:flutter/material.dart';

class UserSearchResultsPage extends StatefulWidget {
  final String? initialQuery;

  const UserSearchResultsPage({
    super.key,
    this.initialQuery,
  });

  @override
  State<UserSearchResultsPage> createState() =>
      _UserSearchResultsPageState();
}

class _UserSearchResultsPageState extends State<UserSearchResultsPage> {
  late final TextEditingController _searchController;

  String _query = '';

  final List<_SearchUser> _users = const [
    _SearchUser(
      name: 'علی رضایی',
      username: 'ali.dev',
      bio: 'در مسیر ساختن عادت‌های بهتر.',
      followers: 1240,
      isFollowing: false,
    ),
    _SearchUser(
      name: 'سارا محمدی',
      username: 'sara.fit',
      bio: 'ورزش، مطالعه و رشد روزانه.',
      followers: 980,
      isFollowing: true,
    ),
    _SearchUser(
      name: 'محمد احمدی',
      username: 'mohammad',
      bio: 'هر روز یک قدم جلوتر.',
      followers: 742,
      isFollowing: false,
    ),
    _SearchUser(
      name: 'نگار کریمی',
      username: 'negar',
      bio: 'یادگیری هیچ‌وقت متوقف نمی‌شود.',
      followers: 2180,
      isFollowing: false,
    ),
    _SearchUser(
      name: 'رضا موسوی',
      username: 'reza.life',
      bio: 'ساختن یک زندگی بهتر.',
      followers: 531,
      isFollowing: true,
    ),
    _SearchUser(
      name: 'امیرحسین',
      username: 'amir_h',
      bio: 'Consistency over motivation.',
      followers: 320,
      isFollowing: false,
    ),
    _SearchUser(
      name: 'مریم حسینی',
      username: 'maryam',
      bio: 'یک عادت خوب در هر روز.',
      followers: 1650,
      isFollowing: false,
    ),
  ];

  late List<_SearchUser> _filteredUsers;

  @override
  void initState() {
    super.initState();

    _query = widget.initialQuery?.trim() ?? '';

    _searchController = TextEditingController(
      text: _query,
    );

    _filteredUsers = _filterUsers(_query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_SearchUser> _filterUsers(String query) {
    if (query.trim().isEmpty) {
      return _users;
    }

    final normalizedQuery = query.trim().toLowerCase();

    return _users.where((user) {
      return user.name.toLowerCase().contains(normalizedQuery) ||
          user.username.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
      _filteredUsers = _filterUsers(value);
    });
  }

  void _clearSearch() {
    _searchController.clear();

    setState(() {
      _query = '';
      _filteredUsers = _users;
    });
  }

  void _toggleFollow(int index) {
    final user = _filteredUsers[index];

    final originalIndex = _users.indexOf(user);

    if (originalIndex == -1) {
      return;
    }

    final updatedUser = user.copyWith(
      isFollowing: !user.isFollowing,
    );

    setState(() {
      final updatedUsers = List<_SearchUser>.from(_users);
      updatedUsers[originalIndex] = updatedUser;

      _filteredUsers = _filterUsers(_query);

      // Rebuild the filtered result from the updated source.
      _filteredUsers = updatedUsers.where((item) {
        if (_query.trim().isEmpty) {
          return true;
        }

        final query = _query.trim().toLowerCase();

        return item.name.toLowerCase().contains(query) ||
            item.username.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _openUserProfile(_SearchUser user) {
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

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'جستجوی کاربران',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchField(context),
          _buildResultHeader(context),
          Expanded(
            child: _filteredUsers.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      8,
                      20,
                      24,
                    ),
                    itemCount: _filteredUsers.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildUserCard(
                        context,
                        _filteredUsers[index],
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
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: TextField(
        controller: _searchController,
        autofocus: widget.initialQuery == null,
        onChanged: _onSearchChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'نام یا نام کاربری...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  onPressed: _clearSearch,
                  icon: const Icon(Icons.close),
                ),
          filled: true,
          fillColor: colorScheme.surfaceContainerLow,
        ),
      ),
    );
  }

  Widget _buildResultHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_query.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          '${_filteredUsers.length} نتیجه برای «$_query»',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(
    BuildContext context,
    _SearchUser user,
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
              color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
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
                  const SizedBox(height: 4),
                  Text(
                    '${_formatFollowers(user.followers)} دنبال‌کننده',
                    style: theme.textTheme.labelSmall?.copyWith(
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
      width: 56,
      height: 56,
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
            color: colorScheme.surfaceContainerHighest.withOpacity(0.8),
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
    _SearchUser user,
    int index,
  ) {
    if (user.isFollowing) {
      return SizedBox(
        width: 92,
        height: 38,
        child: OutlinedButton(
          onPressed: () => _toggleFollow(index),
          child: const Text('دنبال می‌کنی'),
        ),
      );
    }

    return SizedBox(
      width: 92,
      height: 38,
      child: ElevatedButton(
        onPressed: () => _toggleFollow(index),
        child: const Text('دنبال کردن'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_search_outlined,
              size: 68,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'کاربری پیدا نشد',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'نام یا نام کاربری دیگری را امتحان کن.',
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

  String _formatFollowers(int followers) {
    if (followers >= 1000) {
      final value = followers / 1000;

      if (value == value.roundToDouble()) {
        return '${value.toInt()}K';
      }

      return '${value.toStringAsFixed(1)}K';
    }

    return followers.toString();
  }
}

class _SearchUser {
  final String name;
  final String username;
  final String bio;
  final int followers;
  final bool isFollowing;

  const _SearchUser({
    required this.name,
    required this.username,
    required this.bio,
    required this.followers,
    this.isFollowing = false,
  });

  _SearchUser copyWith({
    String? name,
    String? username,
    String? bio,
    int? followers,
    bool? isFollowing,
  }) {
    return _SearchUser(
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}