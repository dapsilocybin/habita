import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _privateProfile = false;
  bool _pushNotifications = true;
  bool _challengeNotifications = true;
  bool _habitNotifications = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('تنظیمات'),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            _SettingsSection(
              title: 'حساب کاربری',
              children: [
                _SettingsTile(
                  icon: Icons.person_outline,
                  title: 'ویرایش پروفایل',
                  subtitle: 'نام، نام کاربری، عکس و بیو',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.phone_outlined,
                  title: 'شماره موبایل',
                  subtitle: 'شماره متصل به حساب',
                  trailing: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      '0912•••••••',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsSection(
              title: 'حریم خصوصی',
              children: [
                _SettingsTile(
                  icon: Icons.lock_outline,
                  title: 'پروفایل خصوصی',
                  subtitle: 'فقط دنبال‌کنندگان تأییدشده پروفایل تو را ببینند',
                  trailing: Switch(
                    value: _privateProfile,
                    onChanged: (value) {
                      setState(() {
                        _privateProfile = value;
                      });
                    },
                  ),
                ),
                _SettingsTile(
                  icon: Icons.visibility_outlined,
                  title: 'نمایش فعالیت‌ها',
                  subtitle: 'کنترل نمایش عادت‌ها و رکوردهای عمومی',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.block_outlined,
                  title: 'کاربران مسدودشده',
                  subtitle: 'مدیریت کاربران مسدودشده',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsSection(
              title: 'اعلان‌ها',
              children: [
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: 'اعلان‌ها',
                  subtitle: 'فعال‌سازی اعلان‌های هابیتا',
                  trailing: Switch(
                    value: _pushNotifications,
                    onChanged: (value) {
                      setState(() {
                        _pushNotifications = value;
                      });
                    },
                  ),
                ),
                _SettingsTile(
                  icon: Icons.emoji_events_outlined,
                  title: 'چالش‌ها',
                  subtitle: 'یادآوری و تغییرات چالش‌ها',
                  trailing: Switch(
                    value: _challengeNotifications,
                    onChanged: _pushNotifications
                        ? (value) {
                            setState(() {
                              _challengeNotifications = value;
                            });
                          }
                        : null,
                  ),
                ),
                _SettingsTile(
                  icon: Icons.track_changes_outlined,
                  title: 'عادت‌ها',
                  subtitle: 'یادآوری عادت‌ها و فعالیت‌ها',
                  trailing: Switch(
                    value: _habitNotifications,
                    onChanged: _pushNotifications
                        ? (value) {
                            setState(() {
                              _habitNotifications = value;
                            });
                          }
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsSection(
              title: 'ظاهر برنامه',
              children: [
                _SettingsTile(
                  icon: Icons.palette_outlined,
                  title: 'تم برنامه',
                  subtitle: 'انتخاب ظاهر و رنگ‌بندی هابیتا',
                  onTap: () {
                    _showThemeDialog(context);
                  },
                ),
                _SettingsTile(
                  icon: Icons.language_outlined,
                  title: 'زبان',
                  subtitle: 'فارسی',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsSection(
              title: 'اطلاعات و پشتیبانی',
              children: [
                _SettingsTile(
                  icon: Icons.help_outline,
                  title: 'راهنما و پشتیبانی',
                  subtitle: 'سؤالات متداول و ارتباط با پشتیبانی',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.info_outline,
                  title: 'درباره هابیتا',
                  subtitle: 'نسخه 1.0.0',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.description_outlined,
                  title: 'قوانین و شرایط',
                  subtitle: 'شرایط استفاده از هابیتا',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'حریم خصوصی',
                  subtitle: 'سیاست حفظ حریم خصوصی',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsSection(
              title: 'حساب',
              children: [
                _SettingsTile(
                  icon: Icons.logout_outlined,
                  title: 'خروج از حساب',
                  titleColor: colorScheme.error,
                  iconColor: colorScheme.error,
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
                _SettingsTile(
                  icon: Icons.delete_outline,
                  title: 'حذف حساب',
                  subtitle: 'حذف دائمی حساب و اطلاعات',
                  titleColor: colorScheme.error,
                  iconColor: colorScheme.error,
                  onTap: () {
                    _showDeleteAccountDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('تم برنامه'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ThemeOption(
                title: 'Soft Blue Mist',
                icon: Icons.auto_awesome_outlined,
                selected: true,
                onTap: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              _ThemeOption(
                title: 'روشن',
                icon: Icons.light_mode_outlined,
                onTap: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              _ThemeOption(
                title: 'تیره',
                icon: Icons.dark_mode_outlined,
                onTap: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              _ThemeOption(
                title: 'سیستم',
                icon: Icons.settings_suggest_outlined,
                onTap: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('خروج از حساب'),
          content: const Text(
            'آیا مطمئنی می‌خواهی از حساب خود خارج شوی؟',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('انصراف'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // TODO: AuthBloc logout.
              },
              child: const Text('خروج'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('حذف حساب'),
          content: const Text(
            'این کار حساب و اطلاعات مربوط به آن را به صورت دائمی حذف می‌کند. '
            'در نسخه واقعی، قبل از ادامه نیاز به تأیید هویت خواهیم داشت.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('انصراف'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // TODO: Account deletion API.
              },
              child: const Text('حذف حساب'),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.09),
                offset: const Offset(6, 6),
                blurRadius: 12,
              ),
              BoxShadow(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
                offset: const Offset(-5, -5),
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Column(
              children: _withDividers(children),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _withDividers(List<Widget> children) {
    final result = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);

      if (i < children.length - 1) {
        result.add(
          const Divider(
            height: 1,
            indent: 64,
          ),
        );
      }
    }

    return result;
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;
  final Color? iconColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.titleColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 21,
                color: iconColor ?? colorScheme.primary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: titleColor ?? colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (onTap != null)
              Icon(
                Icons.chevron_left,
                color: colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
    required this.icon,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: colorScheme.primary,
      ),
      title: Text(title),
      trailing: selected
          ? Icon(
              Icons.check_circle,
              color: colorScheme.primary,
            )
          : null,
    );
  }
}
