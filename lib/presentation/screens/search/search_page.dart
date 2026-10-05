import 'package:flutter/material.dart';

import '../habit_search_results/habit_search_results_page.dart';
import '../record_detail/record_detail_page.dart';
import '../user_profile/user_profile_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedTab = 0;

  final List<_SearchUser> _users = [
    _SearchUser(
      name: 'علی رضایی',
      username: 'ali.rezaei',
      followers: '1.2K',
    ),
    _SearchUser(
      name: 'سارا محمدی',
      username: 'sara.m',
      followers: '842',
    ),
    _SearchUser(
      name: 'محمد احمدی',
      username: 'mohammad.a',
      followers: '621',
    ),
  ];

  final List<_SearchHabit> _habits = [
    _SearchHabit(
      name: 'باشگاه',
      category: 'سلامت جسم → ورزش',
      members: '12.4K',
      icon: Icons.fitness_center_rounded,
    ),
    _SearchHabit(
      name: 'مطالعه روزانه',
      category: 'رشد فردی → مطالعه',
      members: '8.7K',
      icon: Icons.menu_book_rounded,
    ),
    _SearchHabit(
      name: 'کشش قبل از خواب',
      category: 'سلامت جسم → ورزش → کشش بدن',
      members: '3.2K',
      icon: Icons.self_improvement_rounded,
    ),
    _SearchHabit(
      name: 'یادگیری زبان',
      category: 'رشد فردی → یادگیری',
      members: '7.4K',
      icon: Icons.translate_rounded,
    ),
    _SearchHabit(
      name: 'خواب منظم',
      category: 'سلامت جسم → خواب',
      members: '9.1K',
      icon: Icons.bedtime_rounded,
    ),
  ];

  final List<_SearchRecord> _records = [
    _SearchRecord(
      username: 'ali.rezaei',
      habit: 'باشگاه',
      caption: 'امروز بالاخره بعد از مدت‌ها دوباره تمرینم رو شروع کردم.',
      likes: 128,
      comments: 14,
    ),
    _SearchRecord(
      username: 'sara.m',
      habit: 'مطالعه روزانه',
      caption: 'فقط ۲۰ دقیقه مطالعه، ولی حس خیلی خوبی بعدش داشتم.',
      likes: 94,
      comments: 8,
    ),
    _SearchRecord(
      username: 'mohammad.a',
      habit: 'خواب منظم',
      caption: 'این هفته دارم سعی می‌کنم هر شب قبل از ساعت ۱۲ بخوابم.',
      likes: 67,
      comments: 5,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _hasQuery => _searchController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('جستجو'),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: _buildSearchField(theme),
              ),
              if (!_hasQuery)
                Expanded(
                  child: _buildInitialState(theme),
                )
              else
                Expanded(
                  child: Column(
                    children: [
                      _buildTabs(theme),
                      Expanded(
                        child: _buildSearchResults(theme),
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

  Widget _buildSearchField(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(3, 4),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.9),
            blurRadius: 8,
            offset: const Offset(-3, -3),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        textDirection: TextDirection.rtl,
        textInputAction: TextInputAction.search,
        onChanged: (_) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: 'جستجوی عادت، کاربر یا رکورد...',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: _hasQuery
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _selectedTab = 0;
                    });
                  },
                  icon: const Icon(Icons.close_rounded),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        Text(
          'جستجو کن',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'عادت‌ها، افراد و رکوردهای مورد علاقه‌ات را پیدا کن.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        _buildSectionTitle(
          theme,
          title: 'جستجوهای پیشنهادی',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            'باشگاه',
            'مطالعه',
            'خواب منظم',
            'یادگیری زبان',
            'مدیتیشن',
            'نوشیدن آب',
          ].map((item) {
            return _buildSuggestionChip(
              theme,
              item,
            );
          }).toList(),
        ),
        const SizedBox(height: 28),
        _buildSectionTitle(
          theme,
          title: 'عادت‌های محبوب',
        ),
        const SizedBox(height: 12),
        ..._habits.take(3).map(
              (habit) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildHabitCard(theme, habit),
              ),
            ),
      ],
    );
  }

  Widget _buildSuggestionChip(
    ThemeData theme,
    String text,
  ) {
    final colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        _searchController.text = text;
        setState(() {
          _selectedTab = 0;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            _buildTab(
              theme,
              index: 0,
              title: 'همه',
              icon: Icons.apps_rounded,
            ),
            _buildTab(
              theme,
              index: 1,
              title: 'رکوردها',
              icon: Icons.article_rounded,
            ),
            _buildTab(
              theme,
              index: 2,
              title: 'افراد',
              icon: Icons.people_alt_rounded,
            ),
            _buildTab(
              theme,
              index: 3,
              title: 'عادت‌ها',
              icon: Icons.account_tree_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
    ThemeData theme, {
    required int index,
    required String title,
    required IconData icon,
  }) {
    final colorScheme = theme.colorScheme;
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withOpacity(0.14)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 17,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(ThemeData theme) {
    switch (_selectedTab) {
      case 1:
        return _buildRecordsResults(theme);
      case 2:
        return _buildUsersResults(theme);
      case 3:
        return _buildHabitsResults(theme);
      default:
        return _buildAllResults(theme);
    }
  }

  Widget _buildAllResults(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: [
        _buildResultSectionHeader(
          theme,
          title: 'عادت‌ها',
          count: _habits.length,
          onSeeAll: () {
            setState(() {
              _selectedTab = 3;
            });
          },
        ),
        const SizedBox(height: 10),
        ..._habits.take(2).map(
              (habit) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildHabitCard(theme, habit),
              ),
            ),
        const SizedBox(height: 12),
        _buildResultSectionHeader(
          theme,
          title: 'افراد',
          count: _users.length,
          onSeeAll: () {
            setState(() {
              _selectedTab = 2;
            });
          },
        ),
        const SizedBox(height: 10),
        ..._users.take(2).map(
              (user) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildUserCard(theme, user),
              ),
            ),
        const SizedBox(height: 12),
        _buildResultSectionHeader(
          theme,
          title: 'رکوردها',
          count: _records.length,
          onSeeAll: () {
            setState(() {
              _selectedTab = 1;
            });
          },
        ),
        const SizedBox(height: 10),
        ..._records.take(2).map(
              (record) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildRecordCard(theme, record),
              ),
            ),
      ],
    );
  }

  Widget _buildRecordsResults(ThemeData theme) {
    if (_records.isEmpty) {
      return _buildEmptyState(
        theme,
        icon: Icons.article_outlined,
        title: 'رکوردی پیدا نشد',
        subtitle: 'برای جستجوی دیگری تلاش کن.',
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: _records
          .map(
            (record) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildRecordCard(theme, record),
            ),
          )
          .toList(),
    );
  }

  Widget _buildUsersResults(ThemeData theme) {
    if (_users.isEmpty) {
      return _buildEmptyState(
        theme,
        icon: Icons.person_search_rounded,
        title: 'کاربری پیدا نشد',
        subtitle: 'نام یا نام کاربری دیگری را امتحان کن.',
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: _users
          .map(
            (user) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildUserCard(theme, user),
            ),
          )
          .toList(),
    );
  }

  Widget _buildHabitsResults(ThemeData theme) {
    if (_habits.isEmpty) {
      return _buildEmptyState(
        theme,
        icon: Icons.account_tree_outlined,
        title: 'عادتی پیدا نشد',
        subtitle: 'نام عادت یا عبارت دیگری را امتحان کن.',
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: [
        _buildHabitTreeHint(theme),
        const SizedBox(height: 12),
        ..._habits.map(
          (habit) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildHabitCard(theme, habit),
          ),
        ),
      ],
    );
  }

  Widget _buildHabitTreeHint(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.account_tree_rounded,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'عادت‌های پیدا شده بخشی از درخت عادت‌های هابیتا هستند.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitCard(
    ThemeData theme,
    _SearchHabit habit,
  ) {
    final colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HabitSearchResultsPage(
              initialQuery: habit.name,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.10),
              blurRadius: 12,
              offset: const Offset(3, 4),
            ),
            BoxShadow(
              color: colorScheme.surface.withOpacity(0.8),
              blurRadius: 8,
              offset: const Offset(-3, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                habit.icon,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    habit.category,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${habit.members} عضو',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_left_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(
    ThemeData theme,
    _SearchUser user,
  ) {
    final colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => UserProfilePage(
              username: user.username,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(3, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 27,
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
                  const SizedBox(height: 3),
                  Text(
                    '@${user.username}',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${user.followers} دنبال‌کننده',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('مشاهده'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(
    ThemeData theme,
    _SearchRecord record,
  ) {
    final colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RecordDetailPage(
              username: record.username,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(3, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    'assets/images/man.jpg',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '@${record.username}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    record.habit,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              record.caption,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.favorite_border_rounded,
                  size: 19,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                Text('${record.likes}'),
                const SizedBox(width: 18),
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                Text('${record.comments}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSectionHeader(
    ThemeData theme, {
    required String title,
    required int count,
    required VoidCallback onSeeAll,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '($count)',
          style: theme.textTheme.bodySmall,
        ),
        const Spacer(),
        TextButton(
          onPressed: onSeeAll,
          child: const Text('مشاهده همه'),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(
    ThemeData theme, {
    required String title,
  }) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmptyState(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.10),
                    blurRadius: 16,
                    offset: const Offset(4, 5),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 38,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchUser {
  final String name;
  final String username;
  final String followers;

  const _SearchUser({
    required this.name,
    required this.username,
    required this.followers,
  });
}

class _SearchHabit {
  final String name;
  final String category;
  final String members;
  final IconData icon;

  const _SearchHabit({
    required this.name,
    required this.category,
    required this.members,
    required this.icon,
  });
}

class _SearchRecord {
  final String username;
  final String habit;
  final String caption;
  final int likes;
  final int comments;

  const _SearchRecord({
    required this.username,
    required this.habit,
    required this.caption,
    required this.likes,
    required this.comments,
  });
}