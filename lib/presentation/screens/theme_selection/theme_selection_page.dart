import 'package:flutter/material.dart';

class ThemeSelectionPage extends StatefulWidget {
  const ThemeSelectionPage({super.key});

  @override
  State<ThemeSelectionPage> createState() => _ThemeSelectionPageState();
}

class _ThemeSelectionPageState extends State<ThemeSelectionPage> {
  String _selectedTheme = 'soft_blue_mist';

  final List<_ThemeOption> _themes = const [
    _ThemeOption(
      id: 'soft_blue_mist',
      title: 'Soft Blue Mist',
      subtitle: 'تم اصلی هابیتا',
      icon: Icons.water_drop_outlined,
    ),
    _ThemeOption(
      id: 'light',
      title: 'روشن',
      subtitle: 'ظاهر روشن و ساده',
      icon: Icons.light_mode_outlined,
    ),
    _ThemeOption(
      id: 'dark',
      title: 'تیره',
      subtitle: 'مناسب استفاده در محیط کم‌نور',
      icon: Icons.dark_mode_outlined,
    ),
    _ThemeOption(
      id: 'system',
      title: 'سیستم',
      subtitle: 'هماهنگ با تنظیمات دستگاه',
      icon: Icons.settings_brightness_outlined,
    ),
  ];

  void _selectTheme(String themeId) {
    setState(() {
      _selectedTheme = themeId;
    });
  }

  void _saveTheme() {
    final theme = _themes.firstWhere(
      (theme) => theme.id == _selectedTheme,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم «${theme.title}» انتخاب شد.',
        ),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ظاهر برنامه'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    ..._themes.map(
                      (theme) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _buildThemeCard(
                          context,
                          theme,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton(
                    onPressed: _saveTheme,
                    child: const Text('ذخیره تغییرات'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.16),
            blurRadius: 22,
            offset: const Offset(6, 8),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.85),
            blurRadius: 22,
            offset: const Offset(-6, -8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.16),
                  blurRadius: 18,
                  offset: const Offset(5, 7),
                ),
                BoxShadow(
                  color: colorScheme.surface.withOpacity(0.9),
                  blurRadius: 18,
                  offset: const Offset(-5, -7),
                ),
              ],
            ),
            child: Icon(
              Icons.palette_outlined,
              size: 36,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'ظاهر هابیتا را انتخاب کنید',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'تم برنامه روی تمام صفحات و اجزای رابط کاربری اعمال خواهد شد.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard(
    BuildContext context,
    _ThemeOption option,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = option.id == _selectedTheme;

    return InkWell(
      onTap: () => _selectTheme(option.id),
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant.withOpacity(0.5),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(
                isSelected ? 0.17 : 0.11,
              ),
              blurRadius: isSelected ? 18 : 14,
              offset: const Offset(4, 6),
            ),
            BoxShadow(
              color: colorScheme.surface.withOpacity(0.8),
              blurRadius: 14,
              offset: const Offset(-4, -6),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildThemePreview(
              context,
              option,
              isSelected,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? colorScheme.onPrimaryContainer
                          : null,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    option.subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected
                          ? colorScheme.onPrimaryContainer.withOpacity(0.75)
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _buildSelectionIndicator(
              context,
              isSelected,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePreview(
    BuildContext context,
    _ThemeOption option,
    bool isSelected,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.14),
            blurRadius: 12,
            offset: const Offset(3, 5),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.9),
            blurRadius: 12,
            offset: const Offset(-3, -5),
          ),
        ],
      ),
      child: Icon(
        option.icon,
        color: isSelected
            ? colorScheme.primary
            : colorScheme.onSurfaceVariant,
        size: 28,
      ),
    );
  }

  Widget _buildSelectionIndicator(
    BuildContext context,
    bool isSelected,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? colorScheme.primary
            : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outline,
          width: 2,
        ),
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              size: 18,
              color: colorScheme.onPrimary,
            )
          : null,
    );
  }
}

class _ThemeOption {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;

  const _ThemeOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}