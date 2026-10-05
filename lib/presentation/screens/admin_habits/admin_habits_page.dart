import 'package:flutter/material.dart';

class AdminHabitsPage extends StatefulWidget {
  const AdminHabitsPage({super.key});

  @override
  State<AdminHabitsPage> createState() => _AdminHabitsPageState();
}

class _AdminHabitsPageState extends State<AdminHabitsPage> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'همه';

  final List<_AdminHabit> _habits = [
    const _AdminHabit(
      name: 'باشگاه',
      category: 'سلامت جسم → ورزش',
      members: 12400,
      records: 48700,
      status: 'فعال',
      isFeatured: true,
    ),
    const _AdminHabit(
      name: 'پیاده‌روی روزانه',
      category: 'سلامت جسم → ورزش',
      members: 8400,
      records: 31600,
      status: 'فعال',
      isFeatured: true,
    ),
    const _AdminHabit(
      name: 'مطالعه روزانه',
      category: 'رشد فردی → مطالعه',
      members: 9600,
      records: 42100,
      status: 'فعال',
      isFeatured: true,
    ),
    const _AdminHabit(
      name: 'کشش قبل از خواب',
      category: 'سلامت جسم → ورزش → کشش بدن',
      members: 3200,
      records: 11800,
      status: 'فعال',
      isFeatured: false,
    ),
    const _AdminHabit(
      name: 'مدیتیشن',
      category: 'رشد فردی → ذهن و تمرکز',
      members: 7100,
      records: 28900,
      status: 'فعال',
      isFeatured: false,
    ),
    const _AdminHabit(
      name: 'خواب منظم',
      category: 'سلامت جسم → خواب',
      members: 6800,
      records: 25400,
      status: 'غیرفعال',
      isFeatured: false,
    ),
  ];

  final List<String> _filters = const [
    'همه',
    'فعال',
    'غیرفعال',
    'ویژه',
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

  List<_AdminHabit> get _filteredHabits {
    final query = _searchController.text.trim();

    return _habits.where((habit) {
      final matchesSearch =
          query.isEmpty ||
          habit.name.contains(query) ||
          habit.category.contains(query);

      final matchesFilter = switch (_selectedFilter) {
        'فعال' => habit.status == 'فعال',
        'غیرفعال' => habit.status == 'غیرفعال',
        'ویژه' => habit.isFeatured,
        _ => true,
      };

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت عادت‌ها'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showAddHabitSheet,
            icon: const Icon(Icons.add_rounded),
            tooltip: 'افزودن عادت',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSummary(context),
          _buildSearchField(context),
          _buildFilters(context),
          Expanded(
            child: _filteredHabits.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: _filteredHabits.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
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

  Widget _buildSummary(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final active =
        _habits.where((habit) => habit.status == 'فعال').length;
    final inactive =
        _habits.where((habit) => habit.status == 'غیرفعال').length;
    final featured =
        _habits.where((habit) => habit.isFeatured).length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryItem(
              context,
              'کل عادت‌ها',
              '${_habits.length}',
              Icons.account_tree_outlined,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryItem(
              context,
              'فعال',
              '$active',
              Icons.check_circle_outline,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryItem(
              context,
              'غیرفعال',
              '$inactive',
              Icons.pause_circle_outline,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryItem(
              context,
              'ویژه',
              '$featured',
              Icons.star_outline_rounded,
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
        horizontal: 6,
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
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'جستجوی عادت یا مسیر درخت...',
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
            selected: filter == _selectedFilter,
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

  Widget _buildHabitCard(
    BuildContext context,
    _AdminHabit habit,
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
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.track_changes_rounded,
                    color: colorScheme.onPrimaryContainer,
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
                              habit.name,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (habit.isFeatured) ...[
                            const SizedBox(width: 6),
                            Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: colorScheme.primary,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        habit.category,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    _handleHabitAction(
                      context,
                      habit,
                      value,
                    );
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('ویرایش'),
                    ),
                    PopupMenuItem(
                      value: 'featured',
                      child: Text('تغییر وضعیت ویژه'),
                    ),
                    PopupMenuItem(
                      value: 'toggle',
                      child: Text('تغییر وضعیت'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('حذف'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStat(
                    context,
                    Icons.people_outline,
                    '${_formatNumber(habit.members)}',
                    'عضو',
                  ),
                ),
                Expanded(
                  child: _buildStat(
                    context,
                    Icons.article_outlined,
                    '${_formatNumber(habit.records)}',
                    'رکورد',
                  ),
                ),
                Expanded(
                  child: _buildStat(
                    context,
                    habit.status == 'فعال'
                        ? Icons.check_circle_outline
                        : Icons.pause_circle_outline,
                    habit.status,
                    'وضعیت',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          size: 19,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
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
              Icons.search_off_rounded,
              size: 70,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'عادتی پیدا نشد',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'عبارت جستجو یا فیلتر انتخاب‌شده را تغییر بده.',
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

  void _handleHabitAction(
    BuildContext context,
    _AdminHabit habit,
    String action,
  ) {
    switch (action) {
      case 'edit':
        _showEditHabitSheet(habit);
        break;

      case 'featured':
        _toggleFeatured(habit);
        break;

      case 'toggle':
        _toggleStatus(habit);
        break;

      case 'delete':
        _confirmDelete(habit);
        break;
    }
  }

  void _showAddHabitSheet() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'افزودن عادت جدید',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'نام عادت',
                    hintText: 'مثلاً نوشیدن آب',
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'توضیحات',
                  ),
                ),
                const SizedBox(height: 14),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.account_tree_outlined),
                  title: Text('مسیر درخت عادت'),
                  subtitle: Text('سلامت جسم → تغذیه'),
                  trailing: Icon(Icons.chevron_left_rounded),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'عادت جدید ایجاد شد (نسخه نمایشی).',
                          ),
                        ),
                      );
                    },
                    child: const Text('ایجاد عادت'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditHabitSheet(_AdminHabit habit) {
    final controller = TextEditingController(text: habit.name);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ویرایش عادت',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'نام عادت',
                ),
              ),
              const SizedBox(height: 14),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.account_tree_outlined),
                title: const Text('مسیر فعلی'),
                subtitle: Text(habit.category),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'اطلاعات عادت ذخیره شد (نسخه نمایشی).',
                        ),
                      ),
                    );
                  },
                  child: const Text('ذخیره تغییرات'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleFeatured(_AdminHabit habit) {
    final index = _habits.indexOf(habit);

    if (index == -1) {
      return;
    }

    setState(() {
      _habits[index] = _AdminHabit(
        name: habit.name,
        category: habit.category,
        members: habit.members,
        records: habit.records,
        status: habit.status,
        isFeatured: !habit.isFeatured,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          habit.isFeatured
              ? 'عادت از حالت ویژه خارج شد.'
              : 'عادت به عنوان ویژه انتخاب شد.',
        ),
      ),
    );
  }

  void _toggleStatus(_AdminHabit habit) {
    final index = _habits.indexOf(habit);

    if (index == -1) {
      return;
    }

    final newStatus = habit.status == 'فعال' ? 'غیرفعال' : 'فعال';

    setState(() {
      _habits[index] = _AdminHabit(
        name: habit.name,
        category: habit.category,
        members: habit.members,
        records: habit.records,
        status: newStatus,
        isFeatured: habit.isFeatured,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'وضعیت عادت به «$newStatus» تغییر کرد.',
        ),
      ),
    );
  }

  void _confirmDelete(_AdminHabit habit) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('حذف عادت'),
          content: Text(
            'آیا از حذف «${habit.name}» مطمئنی؟\n\n'
            'در نسخه واقعی، قبل از حذف باید وضعیت اعضا و رکوردهای '
            'مرتبط بررسی شود.',
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
                  _habits.remove(habit);
                });

                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text('عادت حذف شد.'),
                  ),
                );
              },
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  String _formatNumber(int value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }

    return value.toString();
  }
}

class _AdminHabit {
  final String name;
  final String category;
  final int members;
  final int records;
  final String status;
  final bool isFeatured;

  const _AdminHabit({
    required this.name,
    required this.category,
    required this.members,
    required this.records,
    required this.status,
    required this.isFeatured,
  });
}