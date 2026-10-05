import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('شرایط و قوانین'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DocumentHeader(
                icon: Icons.gavel_rounded,
                title: 'شرایط استفاده از Habita',
                subtitle: 'آخرین به‌روزرسانی: ۱۴۰۵/۰۷/۱۴',
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 24),
              _Section(
                number: '۱',
                title: 'پذیرش شرایط',
                text:
                    'با ایجاد حساب کاربری یا استفاده از Habita، شما می‌پذیرید که این شرایط و قوانین را مطالعه کرده‌اید و با آن‌ها موافق هستید. '
                    'در صورتی که با بخشی از این شرایط موافق نیستید، نباید از خدمات Habita استفاده کنید.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۲',
                title: 'حساب کاربری',
                text:
                    'برای استفاده از برخی قابلیت‌های Habita لازم است حساب کاربری ایجاد کنید. '
                    'مسئولیت حفظ دسترسی به حساب و شماره تلفن مرتبط با آن بر عهده شماست. '
                    'اطلاعات ارائه‌شده هنگام ایجاد حساب باید صحیح و به‌روز باشند.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۳',
                title: 'محتوای کاربران',
                text:
                    'کاربران می‌توانند رکوردها، متن، تصاویر و سایر محتوای مجاز را در Habita منتشر کنند. '
                    'شما مسئول محتوایی هستید که منتشر می‌کنید و نباید محتوایی ارسال کنید که ناقض قوانین، حقوق دیگران یا قوانین قابل اجرا باشد.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۴',
                title: 'رفتار در جامعه',
                text:
                    'Habita یک محیط اجتماعی برای رشد و توسعه فردی است. آزار، تهدید، نفرت‌پراکنی، جعل هویت، فریب کاربران، '
                    'اسپم و هرگونه رفتار مخرب یا سوءاستفاده از پلتفرم مجاز نیست.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۵',
                title: 'ثبت رکورد و اعتبارسنجی',
                text:
                    'رکوردهای ثبت‌شده باید تا حد امکان بیانگر تلاش واقعی کاربر برای انجام عادت باشند. '
                    'Habita می‌تواند برای حفظ کیفیت جامعه، محتوای گزارش‌شده یا مشکوک را بررسی، محدود یا حذف کند.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۶',
                title: 'HabitaCoin',
                text:
                    'HabitaCoin یا HBC یک واحد پاداش در اکوسیستم Habita است. '
                    'قوانین دریافت، استفاده و ارزش این واحد می‌تواند بر اساس طراحی اقتصادی و سیاست‌های پلتفرم تغییر کند. '
                    'HBC در نسخه فعلی نباید به‌عنوان تضمین ارزش مالی یا سود سرمایه‌گذاری تلقی شود.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۷',
                title: 'چالش‌ها و دستاوردها',
                text:
                    'نتایج چالش‌ها، رتبه‌بندی‌ها، مدال‌ها و سایر دستاوردها بر اساس داده‌های ثبت‌شده در سیستم محاسبه می‌شوند. '
                    'Habita می‌تواند در صورت شناسایی تقلب یا سوءاستفاده، نتایج یا پاداش‌های مربوط را اصلاح یا لغو کند.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۸',
                title: 'محتوای ممنوع',
                text:
                    'استفاده از Habita برای انتشار محتوای غیرقانونی، محتوای آسیب‌رسان، نقض‌کننده حقوق مالکیت فکری، '
                    'اطلاعات خصوصی دیگران یا هر محتوایی که امنیت کاربران و پلتفرم را تهدید کند ممنوع است.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۹',
                title: 'گزارش و مدیریت محتوا',
                text:
                    'کاربران می‌توانند محتوای نامناسب یا رفتارهای مشکوک را گزارش کنند. '
                    'تیم Habita می‌تواند گزارش‌ها را بررسی کرده و در صورت نیاز اقداماتی مانند حذف محتوا، محدود کردن قابلیت‌ها یا تعلیق حساب انجام دهد.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۱۰',
                title: 'تغییرات سرویس',
                text:
                    'قابلیت‌ها، ساختار و قوانین Habita ممکن است در طول زمان تغییر کنند. '
                    'در صورت تغییر مهم در شرایط استفاده، نسخه به‌روزشده این صفحه منتشر خواهد شد.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۱۱',
                title: 'تعلیق یا حذف حساب',
                text:
                    'در صورت نقض قوانین یا سوءاستفاده از خدمات، Habita می‌تواند دسترسی به حساب را محدود یا متوقف کند. '
                    'کاربر نیز می‌تواند در هر زمان درخواست حذف حساب خود را ثبت کند.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              _Section(
                number: '۱۲',
                title: 'تماس با ما',
                text:
                    'اگر درباره این شرایط سؤال یا ابهامی دارید، می‌توانید از بخش «کمک و پشتیبانی» با تیم Habita ارتباط برقرار کنید.',
                theme: theme,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 12),
              _AcknowledgementCard(
                theme: theme,
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _DocumentHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.surfaceContainerHighest,
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.14),
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
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 28,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String number;
  final String title;
  final String text;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _Section({
    required this.number,
    required this.title,
    required this.text,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.85,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AcknowledgementCard extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _AcknowledgementCard({
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'این متن یک نسخه اولیه برای رابط کاربری Habita است و پیش از انتشار عمومی باید توسط متخصص حقوقی بررسی و متناسب با کشورها و حوزه‌های قضایی هدف نهایی شود.',
              style: theme.textTheme.bodySmall?.copyWith(
                height: 1.7,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}