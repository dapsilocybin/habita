import 'package:flutter/material.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<_FaqItem> _faqs = const [
    _FaqItem(
      question: 'چطور یک عادت را دنبال کنم؟',
      answer:
          'وارد درخت عادت‌ها شوید، عادت موردنظر را پیدا کنید و گزینه «پیوستن» را انتخاب کنید. بعد از آن عادت در بخش پیگیری عادت‌های شما نمایش داده می‌شود.',
    ),
    _FaqItem(
      question: 'چطور یک رکورد ثبت کنم؟',
      answer:
          'از دکمه افزودن در نوار پایین استفاده کنید، عادت موردنظر را انتخاب کنید و تجربه یا تلاش خود را در بخش توضیحات بنویسید. افزودن تصویر اختیاری است.',
    ),
    _FaqItem(
      question: 'HabitaCoin را چطور به دست می‌آورم؟',
      answer:
          'در نسخه فعلی، نمونه‌هایی مانند ثبت رکورد، شرکت در چالش‌ها و مشارکت اجتماعی می‌توانند باعث دریافت HBC شوند. قوانین دقیق پاداش در نسخه نهایی توسط سیستم اقتصادی Habita تعیین خواهد شد.',
    ),
    _FaqItem(
      question: 'آیا می‌توانم عادت خصوصی بسازم؟',
      answer:
          'بله. هر کاربر می‌تواند عادت‌های خصوصی خود را ایجاد کند. این عادت‌ها در درخت عمومی Habita قرار نمی‌گیرند و برای دیگر کاربران قابل مشاهده نیستند.',
    ),
    _FaqItem(
      question: 'چطور یک کاربر یا رکورد را گزارش کنم؟',
      answer:
          'از منوی بیشتر در صفحه کاربر یا رکورد استفاده کنید و گزینه «گزارش» را انتخاب کنید. گزارش شما برای بررسی تیم پشتیبانی ارسال خواهد شد.',
    ),
    _FaqItem(
      question: 'اگر به حسابم دسترسی نداشته باشم چه کار کنم؟',
      answer:
          'ورود Habita با شماره تلفن و کد تأیید انجام می‌شود. شماره تلفن خود را وارد کنید و کد ارسال‌شده را تأیید کنید تا دوباره وارد حساب شوید.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_FaqItem> get _filteredFaqs {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return _faqs;
    }

    return _faqs.where((faq) {
      return faq.question.toLowerCase().contains(query) ||
          faq.answer.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('کمک و پشتیبانی'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SupportHeader(
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 20),
              _SearchField(
                controller: _searchController,
                theme: theme,
                colorScheme: colorScheme,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 28),
              Text(
                'دسته‌بندی‌ها',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              _CategoryGrid(
                theme: theme,
                colorScheme: colorScheme,
                onTap: _showCategoryMessage,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    'سؤالات متداول',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_filteredFaqs.length} مورد',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              if (_filteredFaqs.isEmpty)
                _EmptySearchResult(
                  theme: theme,
                  colorScheme: colorScheme,
                )
              else
                ..._filteredFaqs.map(
                  (faq) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _FaqTile(
                      faq: faq,
                      theme: theme,
                      colorScheme: colorScheme,
                    ),
                  ),
                ),
              const SizedBox(height: 18),
              _ContactSupportCard(
                theme: theme,
                colorScheme: colorScheme,
                onTap: _openContactSupport,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCategoryMessage(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('بخش «$title» به‌زودی در دسترس خواهد بود.'),
      ),
    );
  }

  void _openContactSupport() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.support_agent_rounded,
                  size: 44,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 14),
                Text(
                  'ارتباط با پشتیبانی',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'در نسخه نهایی می‌توانید درخواست خود را برای تیم پشتیبانی ارسال کنید.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text('فرم تماس با پشتیبانی به‌زودی اضافه می‌شود.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_outline_rounded),
                    label: const Text('شروع گفتگو'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SupportHeader extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _SupportHeader({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.surfaceContainerHighest,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.15),
            blurRadius: 22,
            offset: const Offset(8, 8),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 22,
            offset: const Offset(-8, -8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.10),
                  blurRadius: 12,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.support_agent_rounded,
              size: 38,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'چطور می‌توانیم کمکتان کنیم؟',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'پاسخ سؤالات رایج را پیدا کنید یا با تیم پشتیبانی Habita در ارتباط باشید.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ThemeData theme;
  final ColorScheme colorScheme;
  final ValueChanged<String> onChanged;

  const _SearchField({
    required this.controller,
    required this.theme,
    required this.colorScheme,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'جستجو در سؤالات متداول...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
                icon: const Icon(Icons.clear_rounded),
              )
            : null,
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;
  final ValueChanged<String> onTap;

  const _CategoryGrid({
    required this.theme,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const categories = [
      ('حساب کاربری', Icons.person_outline_rounded),
      ('عادت‌ها', Icons.track_changes_rounded),
      ('رکوردها', Icons.article_outlined),
      ('سکه‌ها', Icons.monetization_on_outlined),
      ('چالش‌ها', Icons.emoji_events_outlined),
      ('امنیت و حریم خصوصی', Icons.security_rounded),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.65,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => onTap(category.$1),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.10),
                  blurRadius: 14,
                  offset: const Offset(5, 5),
                ),
                BoxShadow(
                  color: colorScheme.surface.withOpacity(0.8),
                  blurRadius: 14,
                  offset: const Offset(-5, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  category.$2,
                  color: colorScheme.primary,
                  size: 25,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    category.$1,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FaqTile extends StatelessWidget {
  final _FaqItem faq;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _FaqTile({
    required this.faq,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme.copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(4, 4),
            ),
            BoxShadow(
              color: colorScheme.surface.withOpacity(0.8),
              blurRadius: 12,
              offset: const Offset(-4, -4),
            ),
          ],
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 4,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          iconColor: colorScheme.primary,
          collapsedIconColor: colorScheme.onSurfaceVariant,
          title: Text(
            faq.question,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                faq.answer,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.8,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySearchResult extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _EmptySearchResult({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 36,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 44,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            'نتیجه‌ای پیدا نشد',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'عبارت دیگری را امتحان کنید یا با پشتیبانی تماس بگیرید.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactSupportCard extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _ContactSupportCard({
    required this.theme,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              color: colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'پاسخ خود را پیدا نکردید؟',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'با تیم پشتیبانی Habita در ارتباط باشید.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 17,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqItem {
  final String question;
  final String answer;

  const _FaqItem({
    required this.question,
    required this.answer,
  });
}