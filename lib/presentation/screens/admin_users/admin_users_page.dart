import 'package:flutter/material.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'همه';

  final List<_AdminUser> _users = [
    const _AdminUser(
      name: 'مصطفی',
      username: 'mostafa',
      phone: '09123456789',
      records: 259,
      followers: 184,
      joinedAt: '۲ ماه پیش',
      status: 'فعال',
    ),
    const _AdminUser(
      name: 'علی رضایی',
      username: 'ali.rezaei',
      phone: '09121234567',
      records: 386,
      followers: 1240,
      joinedAt: '۵ ماه پیش',
      status: 'فعال',
    ),
    const _AdminUser(
      name: 'سارا محمدی',
      username: 'sara.m',
      phone: '09129876543',
      records: 174,
      followers: 680,
      joinedAt: '۴ ماه پیش',
      status: 'فعال',
    ),
    const _AdminUser(
      name: 'محمد احمدی',
      username: 'mohammad.a',
      phone: '09121112233',
      records: 87,
      followers: 215,
      joinedAt: '۳ هفته پیش',
      status: 'محدود',
    ),
    const _AdminUser(
      name: 'نگار کریمی',
      username: 'negar.k',
      phone: '09123334455',
      records: 42,
      followers: 96,
      joinedAt: '۱ هفته پیش',
      status: 'مسدود',
    ),
  ];

  final List<String> _filters = const [
    'همه',
    'فعال',
    'محدود',
    'مسدود',
  ];

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_AdminUser> get _filteredUsers {
    final query = _searchController.text.trim().toLowerCase();

    return _users.where((user) {
      final matchesFilter =
          _selectedFilter == 'همه' || user.status == _selectedFilter;

      final matchesSearch =
          query.isEmpty ||
          user.name.toLowerCase().contains(query) ||
          user.username.toLowerCase().contains(query) ||
          user.phone.contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت کاربران'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSummary(context),
          _buildSearchField(context),
          _buildFilters(context),
          Expanded(
            child: _filteredUsers.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: _filteredUsers.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildUserCard(
                        context,
                        _filteredUsers[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final activeCount =
        _users.where((user) => user.status == 'فعال').length;
    final limitedCount =
        _users.where((user) => user.status == 'محدود').length;
    final blockedCount =
        _users.where((user) => user.status == 'مسدود').length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryItem(
              context,
              'کل',
              '${_users.length}',
              Icons.people_alt_outlined,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryItem(
              context,
              'فعال',
              '$activeCount',
              Icons.check_circle_outline,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryItem(
              context,
              'محدود',
              '$limitedCount',
              Icons.warning_amber_rounded,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryItem(
              context,
              'مسدود',
              '$blockedCount',
              Icons.block_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(-3, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: TextField(
        controller: _searchController,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintText: 'جستجوی نام، نام کاربری یا شماره...',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: _searchController.clear,
                  icon: const Icon(Icons.clear_rounded),
                ),
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return SizedBox(
      height: 58,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];

          return ChoiceChip(
            label: Text(filter),
            selected: _selectedFilter == filter,
            onSelected: (_) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildUserCard(
    BuildContext context,
    _AdminUser user,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.10),
            blurRadius: 14,
            offset: const Offset(5, 5),
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
            blurRadius: 10,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(
                    'assets/images/man.jpg',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              user.name,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildStatusBadge(
                            context,
                            user.status,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '@${user.username}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _showUserDetails(context, user),
                  icon: const Icon(Icons.more_vert_rounded),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _buildUserStat(
                    context,
                    'رکورد',
                    '${user.records}',
                  ),
                ),
                Expanded(
                  child: _buildUserStat(
                    context,
                    'دنبال‌کننده',
                    _formatNumber(user.followers),
                  ),
                ),
                Expanded(
                  child: _buildUserStat(
                    context,
                    'عضویت',
                    user.joinedAt,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStat(
    BuildContext context,
    String title,
    String value,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(
    BuildContext context,
    String status,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color background;
    Color foreground;

    switch (status) {
      case 'فعال':
        background = colorScheme.primaryContainer;
        foreground = colorScheme.onPrimaryContainer;
        break;
      case 'محدود':
        background = colorScheme.secondaryContainer;
        foreground = colorScheme.onSecondaryContainer;
        break;
      default:
        background = colorScheme.errorContainer;
        foreground = colorScheme.onErrorContainer;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        status,
        style: theme.textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.bold,
        ),
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
              size: 70,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'کاربری پیدا نشد',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'فیلتر یا عبارت جستجو را تغییر بده.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUserDetails(
    BuildContext context,
    _AdminUser user,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final theme = Theme.of(context);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        'assets/images/man.jpg',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('@${user.username}'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.visibility_outlined),
                  title: const Text('مشاهده پروفایل'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _showComingSoon();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.warning_amber_rounded),
                  title: const Text('محدود کردن کاربر'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _changeStatus(user, 'محدود');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.block_outlined,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: Text(
                    'مسدود کردن کاربر',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _changeStatus(user, 'مسدود');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _changeStatus(
    _AdminUser user,
    String status,
  ) {
    setState(() {
      final index = _users.indexOf(user);

      if (index != -1) {
        _users[index] = _AdminUser(
          name: user.name,
          username: user.username,
          phone: user.phone,
          records: user.records,
          followers: user.followers,
          joinedAt: user.joinedAt,
          status: status,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${user.name} به وضعیت «$status» تغییر کرد.',
        ),
      ),
    );
  }

  void _showComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('این بخش در نسخه بعدی متصل می‌شود.'),
      ),
    );
  }

  String _formatNumber(int value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }

    return value.toString();
  }
}

class _AdminUser {
  final String name;
  final String username;
  final String phone;
  final int records;
  final int followers;
  final String joinedAt;
  final String status;

  const _AdminUser({
    required this.name,
    required this.username,
    required this.phone,
    required this.records,
    required this.followers,
    required this.joinedAt,
    required this.status,
  });
}