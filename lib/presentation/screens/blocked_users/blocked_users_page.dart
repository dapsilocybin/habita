import 'package:flutter/material.dart';

class BlockedUsersPage extends StatefulWidget {
  const BlockedUsersPage({super.key});

  @override
  State<BlockedUsersPage> createState() => _BlockedUsersPageState();
}

class _BlockedUsersPageState extends State<BlockedUsersPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<_BlockedUser> _blockedUsers = [
    _BlockedUser(
      name: 'علی رضایی',
      username: '@ali.rezaei',
    ),
    _BlockedUser(
      name: 'سارا محمدی',
      username: '@sara.m',
    ),
    _BlockedUser(
      name: 'محمد احمدی',
      username: '@mohammad.a',
    ),
    _BlockedUser(
      name: 'نگار کریمی',
      username: '@negar.k',
    ),
  ];

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_BlockedUser> get _filteredUsers {
    if (_searchQuery.isEmpty) {
      return _blockedUsers;
    }

    return _blockedUsers.where((user) {
      return user.name.toLowerCase().contains(_searchQuery) ||
          user.username.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  void _unblockUser(_BlockedUser user) {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return AlertDialog(
          title: const Text('رفع مسدودیت'),
          content: Text(
            'آیا می‌خواهید ${user.name} را از لیست کاربران مسدودشده خارج کنید؟',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('انصراف'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();

                setState(() {
                  _blockedUsers.remove(user);
                });

                ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${user.name} از لیست مسدودشده‌ها خارج شد.',
                    ),
                    backgroundColor: colorScheme.inverseSurface,
                  ),
                );
              },
              child: const Text('رفع مسدودیت'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final users = _filteredUsers;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('کاربران مسدودشده'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: _buildSearchField(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildInfoCard(context),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: users.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                        itemCount: users.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final user = users[index];

                          return _buildUserCard(
                            context,
                            user,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.12),
            blurRadius: 14,
            offset: const Offset(4, 6),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 14,
            offset: const Offset(-4, -6),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintText: 'جستجوی کاربر...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: _searchController.clear,
                  icon: const Icon(Icons.clear),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.65),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.block_outlined,
            color: colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'کاربرانی که مسدود کرده‌اید نمی‌توانند پروفایل و فعالیت‌های شما را مشاهده کنند یا با شما تعامل داشته باشند.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(
    BuildContext context,
    _BlockedUser user,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.13),
            blurRadius: 16,
            offset: const Offset(4, 6),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 16,
            offset: const Offset(-4, -6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.14),
                  blurRadius: 10,
                  offset: const Offset(3, 4),
                ),
                BoxShadow(
                  color: colorScheme.surface.withOpacity(0.9),
                  blurRadius: 10,
                  offset: const Offset(-3, -4),
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
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.username,
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
          OutlinedButton(
            onPressed: () => _unblockUser(user),
            child: const Text('رفع مسدودیت'),
          ),
        ],
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
            Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.surfaceContainerHighest,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.14),
                    blurRadius: 18,
                    offset: const Offset(5, 7),
                  ),
                  BoxShadow(
                    color: colorScheme.surface.withOpacity(0.85),
                    blurRadius: 18,
                    offset: const Offset(-5, -7),
                  ),
                ],
              ),
              child: Icon(
                _searchQuery.isEmpty
                    ? Icons.check_circle_outline
                    : Icons.search_off,
                size: 40,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _searchQuery.isEmpty
                  ? 'کاربری مسدود نشده است'
                  : 'کاربری پیدا نشد',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isEmpty
                  ? 'لیست کاربران مسدودشده شما در اینجا نمایش داده می‌شود.'
                  : 'نام کاربری یا نام موردنظر خود را بررسی کنید.',
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

class _BlockedUser {
  final String name;
  final String username;

  const _BlockedUser({
    required this.name,
    required this.username,
  });
}