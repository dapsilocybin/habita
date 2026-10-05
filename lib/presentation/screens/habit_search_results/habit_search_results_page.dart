import 'package:flutter/material.dart';

import '../habit_detail/habit_detail_page.dart';

class HabitSearchResultsPage extends StatefulWidget {
  final String? initialQuery;

  const HabitSearchResultsPage({
    super.key,
    this.initialQuery,
  });

  @override
  State<HabitSearchResultsPage> createState() =>
      _HabitSearchResultsPageState();
}

class _HabitSearchResultsPageState
    extends State<HabitSearchResultsPage> {
  late final TextEditingController _searchController;

  String _query = '';

  final List<_SearchHabit> _habits = const [
    _SearchHabit(
      name: 'باشگاه',
      category: 'سلامت جسم > ورزش',
      description: 'تمرین منظم در باشگاه برای تقویت بدن و سلامت.',
      members: 12400,
      icon: Icons.fitness_center_outlined,
    ),
    _SearchHabit(
      name: 'پیاده‌روی روزانه',
      category: 'سلامت جسم > ورزش',
      description: 'هر روز زمانی را برای پیاده‌روی و فعالیت بدنی اختصاص بده.',
      members: 8700,
      icon: Icons.directions_walk_outlined,
    ),
    _SearchHabit(
      name: 'مطالعه روزانه',
      category: 'رشد فردی > مطالعه',
      description: 'هر روز زمانی را برای مطالعه و یادگیری اختصاص بده.',
      members: 15400,
      icon: Icons.menu_book_outlined,
    ),
    _SearchHabit(
      name: 'خواب منظم',
      category: 'سلامت جسم > خواب',
      description: 'داشتن ساعت خواب و بیداری منظم.',
      members: 9200,
      icon: Icons.bedtime_outlined,
    ),
    _SearchHabit(
      name: 'مدیتیشن',
      category: 'رشد فردی > ذهن و تمرکز',
      description: 'تمرین روزانه برای آرامش و افزایش تمرکز.',
      members: 6800,
      icon: Icons.self_improvement_outlined,
    ),
    _SearchHabit(
      name: 'یادگیری زبان',
      category: 'رشد فردی > یادگیری',
      description: 'تمرین مستمر برای یادگیری یک زبان جدید.',
      members: 11300,
      icon: Icons.language_outlined,
    ),
    _SearchHabit(
      name: 'کشش قبل از خواب',
      category: 'سلامت جسم > ورزش > کشش بدن',
      description: 'چند حرکت کششی سبک قبل از خواب.',
      members: 3200,
      icon: Icons.accessibility_new_outlined,
    ),
    _SearchHabit(
      name: 'نوشیدن آب',
      category: 'سلامت جسم > تغذیه',
      description: 'مصرف آب کافی در طول روز.',
      members: 18900,
      icon: Icons.water_drop_outlined,
    ),
    _SearchHabit(
      name: 'برنامه‌ریزی روزانه',
      category: 'بهره‌وری > برنامه‌ریزی',
      description: 'قبل از شروع روز، کارهای مهم خودت را مشخص کن.',
      members: 7600,
      icon: Icons.event_note_outlined,
    ),
  ];

  late List<_SearchHabit> _filteredHabits;

  @override
  void initState() {
    super.initState();

    _query = widget.initialQuery?.trim() ?? '';

    _searchController = TextEditingController(
      text: _query,
    );

    _filteredHabits = _filterHabits(_query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_SearchHabit> _filterHabits(String query) {
    if (query.trim().isEmpty) {
      return _habits;
    }

    final normalizedQuery = query.trim().toLowerCase();

    return _habits.where((habit) {
      return habit.name.toLowerCase().contains(normalizedQuery) ||
          habit.category.toLowerCase().contains(normalizedQuery) ||
          habit.description.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
      _filteredHabits = _filterHabits(value);
    });
  }

  void _clearSearch() {
    _searchController.clear();

    setState(() {
      _query = '';
      _filteredHabits = _habits;
    });
  }

  void _openHabit(_SearchHabit habit) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HabitDetailPage(
          habitName: habit.name,
        ),
      ),
    );
  }

  void _openHabitTree(_SearchHabit habit) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'مسیر «${habit.category}» در درخت عادت‌ها باز می‌شود.',
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
          'جستجوی عادت‌ها',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchField(context),
          _buildTreeHint(context),
          _buildResultHeader(context),
          Expanded(
            child: _filteredHabits.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      8,
                      20,
                      24,
                    ),
                    itemCount: _filteredHabits.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      return _buildHabitCard(
                        context,
                        _filteredHabits[index],
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
          hintText: 'جستجوی عادت...',
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

  Widget _buildTreeHint(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_query.trim().isEmpty || _filteredHabits.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          _openHabitTree(_filteredHabits.first);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                Icons.account_tree_outlined,
                color: colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'این نتایج در درخت عادت‌ها قرار دارند',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_left,
                color: colorScheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_query.trim().isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'عادت‌های محبوب',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          '${_filteredHabits.length} عادت پیدا شد',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildHabitCard(
    BuildContext context,
    _SearchHabit habit,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () => _openHabit(habit),
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.10),
              offset: const Offset(7, 7),
              blurRadius: 16,
            ),
            BoxShadow(
              color: colorScheme.surfaceContainerHighest
                  .withOpacity(0.75),
              offset: const Offset(-6, -6),
              blurRadius: 14,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHabitIcon(context, habit),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.account_tree_outlined,
                        size: 15,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          habit.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    habit.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${_formatMembers(habit.members)} عضو',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_left,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitIcon(
    BuildContext context,
    _SearchHabit habit,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.12),
            offset: const Offset(5, 5),
            blurRadius: 10,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest
                .withOpacity(0.7),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Icon(
        habit.icon,
        color: colorScheme.onPrimaryContainer,
        size: 28,
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
              Icons.search_off_outlined,
              size: 68,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'عادت موردنظر پیدا نشد',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'عبارت دیگری را امتحان کن یا درخت عادت‌ها را بررسی کن.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'درخت عادت‌ها در حال آماده‌سازی است.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.account_tree_outlined),
              label: const Text('مشاهده درخت عادت‌ها'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatMembers(int members) {
    if (members >= 1000) {
      final value = members / 1000;

      if (value == value.roundToDouble()) {
        return '${value.toInt()}K';
      }

      return '${value.toStringAsFixed(1)}K';
    }

    return members.toString();
  }
}

class _SearchHabit {
  final String name;
  final String category;
  final String description;
  final int members;
  final IconData icon;

  const _SearchHabit({
    required this.name,
    required this.category,
    required this.description,
    required this.members,
    required this.icon,
  });
}