import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('درباره Habita'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            children: [
              _BrandHeader(
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 24),
              _AboutSection(
                title: 'Habita چیست؟',
                icon: Icons.auto_awesome_rounded,
                theme: theme,
                colorScheme: colorScheme,
                child: Text(
                  'Habita یک شبکه اجتماعی برای ساختن عادت‌های بهتر و تبدیل شدن به نسخه بهتر خودمان است. '
                  'در Habita می‌توانید عادت‌های مختلف را دنبال کنید، تلاش‌های روزانه خود را ثبت کنید، '
                  'از مسیر دیگران الهام بگیرید و همراه یک جامعه در مسیر رشد حرکت کنید.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.9,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _AboutSection(
                title: 'چشم‌انداز ما',
                icon: Icons.visibility_rounded,
                theme: theme,
                colorScheme: colorScheme,
                child: Text(
                  'هدف Habita ساختن جامعه‌ای جهانی است که در آن پیشرفت شخصی فقط یک مسیر فردی نباشد؛ '
                  'بلکه افراد بتوانند یکدیگر را تشویق کنند، تجربه‌های واقعی خود را به اشتراک بگذارند '
                  'و برای ادامه مسیر انگیزه بگیرند.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.9,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _FeaturesSection(
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 16),
              _AboutSection(
                title: 'ارزش‌های Habita',
                icon: Icons.favorite_outline_rounded,
                theme: theme,
                colorScheme: colorScheme,
                child: Column(
                  children: [
                    _ValueItem(
                      icon: Icons.trending_up_rounded,
                      title: 'رشد مستمر',
                      description: 'پیشرفت‌های کوچک اما مداوم ارزشمند هستند.',
                      theme: theme,
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 14),
                    _ValueItem(
                      icon: Icons.groups_rounded,
                      title: 'رشد جمعی',
                      description: 'جامعه می‌تواند انگیزه و حمایت بیشتری ایجاد کند.',
                      theme: theme,
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 14),
                    _ValueItem(
                      icon: Icons.verified_rounded,
                      title: 'واقعی بودن',
                      description: 'تمرکز ما روی تلاش واقعی و تجربه واقعی کاربران است.',
                      theme: theme,
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 14),
                    _ValueItem(
                      icon: Icons.balance_rounded,
                      title: 'تعادل',
                      description: 'رشد باید با زندگی واقعی و نیازهای انسان هماهنگ باشد.',
                      theme: theme,
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _VersionCard(
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 24),
              Text(
                'Build your better self',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _BrandHeader({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.surfaceContainerHighest,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.16),
            blurRadius: 24,
            offset: const Offset(9, 9),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 24,
            offset: const Offset(-9, -9),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.14),
                  blurRadius: 18,
                  offset: const Offset(7, 7),
                ),
                BoxShadow(
                  color: colorScheme.surface.withOpacity(0.9),
                  blurRadius: 18,
                  offset: const Offset(-7, -7),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'H',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Habita',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Build your better self',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final ThemeData theme;
  final ColorScheme colorScheme;
  final Widget child;

  const _AboutSection({
    required this.title,
    required this.icon,
    required this.theme,
    required this.colorScheme,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.10),
            blurRadius: 16,
            offset: const Offset(6, 6),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 16,
            offset: const Offset(-6, -6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: colorScheme.onPrimaryContainer,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _FeaturesSection({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    const features = [
      (
        Icons.account_tree_rounded,
        'درخت عادت‌ها',
        'هزاران عادت دسته‌بندی‌شده برای پیدا کردن مسیر مناسب.'
      ),
      (
        Icons.article_rounded,
        'ثبت رکورد',
        'تجربه و تلاش خود را با جامعه Habita به اشتراک بگذارید.'
      ),
      (
        Icons.people_alt_rounded,
        'جامعه',
        'از مسیر دیگران الهام بگیرید و به دیگران انگیزه بدهید.'
      ),
      (
        Icons.emoji_events_rounded,
        'چالش‌ها',
        'در چالش‌های جهانی شرکت کنید و پیشرفت خود را بسنجید.'
      ),
      (
        Icons.military_tech_rounded,
        'دستاوردها',
        'با ادامه مسیر، مدال‌ها و دستاوردهای جدید کسب کنید.'
      ),
      (
        Icons.monetization_on_rounded,
        'HabitaCoin',
        'برای مشارکت و فعالیت در اکوسیستم Habita پاداش دریافت کنید.'
      ),
    ];

    return _AboutSection(
      title: 'ویژگی‌های اصلی',
      icon: Icons.apps_rounded,
      theme: theme,
      colorScheme: colorScheme,
      child: Column(
        children: features.map((feature) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  feature.$1,
                  color: colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature.$2,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        feature.$3,
                        style: theme.textTheme.bodySmall?.copyWith(
                          height: 1.5,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ValueItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _ValueItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: colorScheme.primary,
          size: 23,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  height: 1.5,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VersionCard extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _VersionCard({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'نسخه برنامه',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Habita 1.0.0',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'نسخه اولیه',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}