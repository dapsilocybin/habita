import 'package:flutter/material.dart';

class HabitaBottomNavigation extends StatelessWidget {
  const HabitaBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  /// Home = 0, Explore = 1, Add Record = 2,
  /// Habit Tracker = 3, Profile = 4.
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  static const List<_NavItemData> _items = [
    _NavItemData(icon: Icons.home_rounded, label: 'خانه'),
    _NavItemData(icon: Icons.explore_outlined, label: 'کشف'),
    _NavItemData(icon: Icons.add_rounded, label: 'ثبت تلاش'),
    _NavItemData(icon: Icons.track_changes_rounded, label: 'پیگیری'),
    _NavItemData(icon: Icons.person_outline_rounded, label: 'پروفایل'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withOpacity(0.08),
              offset: const Offset(0, -4),
              blurRadius: 16,
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
            child: Row(
              children: List.generate(_items.length, (index) {
                final item = _items[index];

                if (index == 2) {
                  return Expanded(
                    child: _AddNavigationButton(
                      item: item,
                      color: colors.primary,
                      onTap: () => onItemSelected(index),
                    ),
                  );
                }

                return Expanded(
                  child: _BottomNavigationItem(
                    item: item,
                    selected: selectedIndex == index,
                    theme: theme,
                    onTap: () => onItemSelected(index),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  const _BottomNavigationItem({
    required this.item,
    required this.selected,
    required this.theme,
    required this.onTap,
  });

  final _NavItemData item;
  final bool selected;
  final ThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = theme.colorScheme;
    final color = selected ? colors.primary : colors.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, size: 23, color: color),
            const SizedBox(height: 4),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddNavigationButton extends StatelessWidget {
  const _AddNavigationButton({
    required this.item,
    required this.color,
    required this.onTap,
  });

  final _NavItemData item;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                item.icon,
                color: theme.colorScheme.onPrimary,
                size: 25,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
