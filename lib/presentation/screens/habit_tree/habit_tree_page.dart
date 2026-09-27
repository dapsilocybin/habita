import 'package:flutter/material.dart';

class HabitTreePage extends StatefulWidget {
  const HabitTreePage({super.key});

  @override
  State<HabitTreePage> createState() => _HabitTreePageState();
}

class _HabitTreePageState extends State<HabitTreePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<_HabitCategory> _categories = [
    _HabitCategory(
      title: 'سلامت جسم',
      icon: Icons.fitness_center_outlined,
      children: [
        _HabitCategory(
          title: 'ورزش',
          icon: Icons.sports_gymnastics_outlined,
          children: [
            _HabitCategory(
              title: 'باشگاه',
              icon: Icons.fitness_center,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'پیاده‌روی',
              icon: Icons.directions_walk_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'دویدن',
              icon: Icons.directions_run_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'کشش بدن',
              icon: Icons.accessibility_new_outlined,
              children: [
                _HabitCategory(
                  title: 'کشش قبل از خواب',
                  icon: Icons.bedtime_outlined,
                  isHabit: true,
                ),
                _HabitCategory(
                  title: 'کشش بعد از بیدار شدن',
                  icon: Icons.wb_sunny_outlined,
                  isHabit: true,
                ),
              ],
            ),
          ],
        ),
        _HabitCategory(
          title: 'خواب',
          icon: Icons.bedtime_outlined,
          children: [
            _HabitCategory(
              title: 'خواب منظم',
              icon: Icons.schedule_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'زود خوابیدن',
              icon: Icons.nightlight_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'بیدار شدن منظم',
              icon: Icons.alarm_outlined,
              isHabit: true,
            ),
          ],
        ),
        _HabitCategory(
          title: 'تغذیه',
          icon: Icons.restaurant_outlined,
          children: [
            _HabitCategory(
              title: 'نوشیدن آب',
              icon: Icons.water_drop_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'صبحانه سالم',
              icon: Icons.breakfast_dining_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'میوه خوردن',
              icon: Icons.apple_outlined,
              isHabit: true,
            ),
          ],
        ),
      ],
    ),
    _HabitCategory(
      title: 'رشد فردی',
      icon: Icons.self_improvement_outlined,
      children: [
        _HabitCategory(
          title: 'مطالعه',
          icon: Icons.menu_book_outlined,
          children: [
            _HabitCategory(
              title: 'مطالعه روزانه',
              icon: Icons.book_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'کتاب خواندن',
              icon: Icons.auto_stories_outlined,
              isHabit: true,
            ),
          ],
        ),
        _HabitCategory(
          title: 'ذهن و تمرکز',
          icon: Icons.psychology_outlined,
          children: [
            _HabitCategory(
              title: 'مدیتیشن',
              icon: Icons.self_improvement_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'تمرین تمرکز',
              icon: Icons.center_focus_strong_outlined,
              isHabit: true,
            ),
          ],
        ),
        _HabitCategory(
          title: 'یادگیری',
          icon: Icons.school_outlined,
          children: [
            _HabitCategory(
              title: 'یادگیری زبان',
              icon: Icons.language_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'یادگیری مهارت جدید',
              icon: Icons.lightbulb_outline,
              isHabit: true,
            ),
          ],
        ),
      ],
    ),
    _HabitCategory(
      title: 'بهره‌وری',
      icon: Icons.task_alt_outlined,
      children: [
        _HabitCategory(
          title: 'برنامه‌ریزی',
          icon: Icons.calendar_month_outlined,
          children: [
            _HabitCategory(
              title: 'برنامه‌ریزی روزانه',
              icon: Icons.today_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'برنامه‌ریزی هفتگی',
              icon: Icons.date_range_outlined,
              isHabit: true,
            ),
          ],
        ),
        _HabitCategory(
          title: 'مدیریت زمان',
          icon: Icons.schedule_outlined,
          children: [
            _HabitCategory(
              title: 'شروع کار در زمان مشخص',
              icon: Icons.play_arrow_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'استراحت منظم',
              icon: Icons.free_breakfast_outlined,
              isHabit: true,
            ),
          ],
        ),
      ],
    ),
    _HabitCategory(
      title: 'روابط اجتماعی',
      icon: Icons.people_outline,
      children: [
        _HabitCategory(
          title: 'خانواده',
          icon: Icons.family_restroom_outlined,
          children: [
            _HabitCategory(
              title: 'تماس با خانواده',
              icon: Icons.call_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'وقت گذاشتن برای خانواده',
              icon: Icons.groups_outlined,
              isHabit: true,
            ),
          ],
        ),
        _HabitCategory(
          title: 'دوستی',
          icon: Icons.people_alt_outlined,
          children: [
            _HabitCategory(
              title: 'احوال‌پرسی از دوستان',
              icon: Icons.chat_bubble_outline,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'وقت گذاشتن برای دوستان',
              icon: Icons.group_outlined,
              isHabit: true,
            ),
          ],
        ),
      ],
    ),
    _HabitCategory(
      title: 'سبک زندگی',
      icon: Icons.home_outlined,
      children: [
        _HabitCategory(
          title: 'نظم شخصی',
          icon: Icons.cleaning_services_outlined,
          children: [
            _HabitCategory(
              title: 'مرتب کردن اتاق',
              icon: Icons.cleaning_services_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'مرتب کردن میز کار',
              icon: Icons.desk_outlined,
              isHabit: true,
            ),
          ],
        ),
        _HabitCategory(
          title: 'شروع و پایان روز',
          icon: Icons.wb_twilight_outlined,
          children: [
            _HabitCategory(
              title: 'روتین صبحگاهی',
              icon: Icons.wb_sunny_outlined,
              isHabit: true,
            ),
            _HabitCategory(
              title: 'روتین شبانه',
              icon: Icons.nights_stay_outlined,
              isHabit: true,
            ),
          ],
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_HabitCategory> get _filteredCategories {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      return _categories;
    }

    return _filterCategories(_categories, query);
  }

  List<_HabitCategory> _filterCategories(
    List<_HabitCategory> categories,
    String query,
  ) {
    final result = <_HabitCategory>[];

    for (final category in categories) {
      final titleMatches = category.title.contains(query);

      final filteredChildren = _filterCategories(
        category.children,
        query,
      );

      if (titleMatches || filteredChildren.isNotEmpty) {
        result.add(
          _HabitCategory(
            title: category.title,
            icon: category.icon,
            isHabit: category.isHabit,
            children: filteredChildren,
            isExpanded: true,
          ),
        );
      }
    }

    return result;
  }

  void _openHabit(_HabitCategory habit) {
    // TODO: Navigate to HabitDetailPage.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'عادت «${habit.title}» انتخاب شد.',
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
        title: const Text('درخت عادت‌ها'),
        backgroundColor: colorScheme.surface,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Column(
                children: [
                  Text(
                    'عادت مناسب خودت را پیدا کن',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'از دسته‌بندی‌ها عبور کن و عادتی را که می‌خواهی دنبال کنی انتخاب کن.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    textDirection: TextDirection.rtl,
                    decoration: const InputDecoration(
                      hintText: 'جستجوی عادت...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _filteredCategories.isEmpty
                  ? _EmptySearchResult()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                      itemCount: _filteredCategories.length,
                      itemBuilder: (context, index) {
                        return _CategoryNode(
                          category: _filteredCategories[index],
                          level: 0,
                          onHabitTap: _openHabit,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryNode extends StatefulWidget {
  final _HabitCategory category;
  final int level;
  final ValueChanged<_HabitCategory> onHabitTap;

  const _CategoryNode({
    required this.category,
    required this.level,
    required this.onHabitTap,
  });

  @override
  State<_CategoryNode> createState() => _CategoryNodeState();
}

class _CategoryNodeState extends State<_CategoryNode> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.category.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final hasChildren = widget.category.children.isNotEmpty;
    final isHabit = widget.category.isHabit;

    return Padding(
      padding: EdgeInsets.only(
        right: widget.level * 14.0,
        bottom: 10,
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                if (isHabit) {
                  widget.onHabitTap(widget.category);
                  return;
                }

                if (hasChildren) {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withOpacity(
                    widget.level == 0 ? 0.55 : 0.35,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.08),
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: colorScheme.surface.withOpacity(0.8),
                      offset: const Offset(-4, -4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.shadow.withOpacity(0.10),
                            offset: const Offset(3, 3),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.category.icon,
                        color: colorScheme.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        widget.category.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: isHabit
                              ? FontWeight.w600
                              : FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isHabit)
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      )
                    else if (hasChildren)
                      AnimatedRotation(
                        turns: _expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (_expanded && hasChildren)
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                children: widget.category.children
                    .map(
                      (child) => _CategoryNode(
                        category: child,
                        level: widget.level + 1,
                        onHabitTap: widget.onHabitTap,
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.12),
                    offset: const Offset(7, 7),
                    blurRadius: 16,
                  ),
                  BoxShadow(
                    color: colorScheme.surface.withOpacity(0.8),
                    offset: const Offset(-7, -7),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Icon(
                Icons.search_off_outlined,
                size: 38,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'عادتی پیدا نشد',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'عبارت دیگری را جستجو کن.',
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
}

class _HabitCategory {
  final String title;
  final IconData icon;
  final List<_HabitCategory> children;
  final bool isHabit;
  final bool isExpanded;

  const _HabitCategory({
    required this.title,
    required this.icon,
    this.children = const [],
    this.isHabit = false,
    this.isExpanded = false,
  });
}
