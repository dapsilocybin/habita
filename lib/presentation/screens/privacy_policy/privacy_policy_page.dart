import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حریم خصوصی'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            children: [
              _buildHeader(
                context,
                icon: Icons.privacy_tip_outlined,
                title: 'حریم خصوصی در هابیتا',
                subtitle:
                    'حریم خصوصی و کنترل اطلاعات شخصی شما برای ما اهمیت دارد.',
              ),
              const SizedBox(height: 24),

              _buildSection(
                context,
                number: '۱',
                title: 'مقدمه',
                children: [
                  _buildParagraph(
                    context,
                    'این سیاست حریم خصوصی توضیح می‌دهد که هابیتا چه اطلاعاتی را ممکن است جمع‌آوری کند، چگونه از آن‌ها استفاده می‌کند و چه کنترل‌هایی در اختیار شما قرار می‌دهد.',
                  ),
                  _buildParagraph(
                    context,
                    'هابیتا یک پلتفرم اجتماعی برای شکل‌دادن به عادت‌های بهتر است و بخشی از تجربه آن بر اساس فعالیت‌های عادت‌محور و تعاملات اجتماعی شکل می‌گیرد.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۲',
                title: 'اطلاعاتی که جمع‌آوری می‌کنیم',
                children: [
                  _buildBullet(
                    context,
                    'شماره تلفن برای ورود، احراز هویت و مدیریت حساب کاربری.',
                  ),
                  _buildBullet(
                    context,
                    'اطلاعات پروفایل مانند نام، نام کاربری، تصویر پروفایل و معرفی کوتاه.',
                  ),
                  _buildBullet(
                    context,
                    'اطلاعات مربوط به عادت‌هایی که به آن‌ها پیوسته‌اید و فعالیت‌هایی که در آن‌ها انجام می‌دهید.',
                  ),
                  _buildBullet(
                    context,
                    'رکوردها، متن‌ها، تصاویر و سایر محتوایی که خودتان در هابیتا ایجاد یا منتشر می‌کنید.',
                  ),
                  _buildBullet(
                    context,
                    'اطلاعات مربوط به تعاملات شما مانند دنبال‌کردن کاربران، پسندیدن، نظر دادن و شرکت در چالش‌ها.',
                  ),
                  _buildBullet(
                    context,
                    'اطلاعات فنی و تشخیصی موردنیاز برای عملکرد، امنیت و بهبود برنامه، در صورت فعال‌بودن این قابلیت‌ها.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۳',
                title: 'نحوه استفاده از اطلاعات',
                children: [
                  _buildParagraph(
                    context,
                    'اطلاعات شما ممکن است برای ارائه و شخصی‌سازی خدمات هابیتا، نمایش محتوای مرتبط، مدیریت حساب کاربری و ارائه آمار مربوط به عادت‌ها استفاده شود.',
                  ),
                  _buildBullet(
                    context,
                    'احراز هویت و حفظ امنیت حساب.',
                  ),
                  _buildBullet(
                    context,
                    'نمایش رکوردها و فعالیت‌های مرتبط با عادت‌ها.',
                  ),
                  _buildBullet(
                    context,
                    'پیشنهاد عادت‌ها، کاربران و محتواهای مرتبط.',
                  ),
                  _buildBullet(
                    context,
                    'مدیریت چالش‌ها، دستاوردها و پاداش‌ها.',
                  ),
                  _buildBullet(
                    context,
                    'تشخیص سوءاستفاده، تقلب، محتوای نامناسب و فعالیت‌های مخرب.',
                  ),
                  _buildBullet(
                    context,
                    'بهبود عملکرد، قابلیت اطمینان و تجربه کاربری محصول.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۴',
                title: 'اطلاعات عمومی و خصوصی',
                children: [
                  _buildParagraph(
                    context,
                    'بخشی از اطلاعات شما ممکن است بر اساس تنظیمات حساب و نوع فعالیت برای سایر کاربران قابل مشاهده باشد.',
                  ),
                  _buildParagraph(
                    context,
                    'رکوردها و محتوایی که به‌صورت عمومی منتشر می‌کنید می‌توانند توسط سایر کاربران مشاهده شوند. قبل از انتشار محتوا، سطح دسترسی آن را در نظر بگیرید.',
                  ),
                  _buildParagraph(
                    context,
                    'اطلاعات مربوط به عادت‌های خصوصی و فعالیت‌های خصوصی نباید برای سایر کاربران نمایش داده شود، مگر در مواردی که خود کاربر آن را عمومی کرده باشد یا قانون چنین امری را الزام کند.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۵',
                title: 'پروفایل و فعالیت اجتماعی',
                children: [
                  _buildParagraph(
                    context,
                    'نام کاربری، تصویر پروفایل، اطلاعات عمومی پروفایل، رکوردهای عمومی، دستاوردها و برخی آمار فعالیت ممکن است در پروفایل شما نمایش داده شوند.',
                  ),
                  _buildParagraph(
                    context,
                    'شما می‌توانید از تنظیمات حریم خصوصی، در صورت فراهم‌بودن قابلیت مربوطه، سطح نمایش پروفایل و فعالیت خود را کنترل کنید.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۶',
                title: 'اعلان‌ها',
                children: [
                  _buildParagraph(
                    context,
                    'هابیتا ممکن است برای رویدادهایی مانند رکورد جدید، دنبال‌شدن، تعامل اجتماعی، دستاوردها، چالش‌ها و فعالیت عادت‌ها اعلان ارسال کند.',
                  ),
                  _buildParagraph(
                    context,
                    'نوع و سطح اعلان‌ها را می‌توانید از بخش تنظیمات برنامه مدیریت کنید.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۷',
                title: 'بررسی و مدیریت محتوا',
                children: [
                  _buildParagraph(
                    context,
                    'برای حفظ کیفیت جامعه هابیتا، برخی رکوردها یا محتواها ممکن است برای بررسی، گزارش یا اعتبارسنجی به سیستم‌های داخلی مدیریت محتوا یا تیم پشتیبانی ارجاع شوند.',
                  ),
                  _buildParagraph(
                    context,
                    'این بررسی‌ها می‌توانند برای تشخیص محتوای نامرتبط، تقلب، سوءاستفاده یا نقض قوانین جامعه انجام شوند.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۸',
                title: 'هابیتا کوین و تراکنش‌ها',
                children: [
                  _buildParagraph(
                    context,
                    'فعالیت‌های مرتبط با HabitaCoin ممکن است شامل موجودی، دریافت پاداش، هزینه‌کرد، تراکنش‌ها و سایر اطلاعات مرتبط با حساب شما باشد.',
                  ),
                  _buildParagraph(
                    context,
                    'اطلاعات تراکنش‌ها برای ثبت سوابق مالی داخل پلتفرم، جلوگیری از تقلب و ارائه قابلیت‌های مرتبط با کیف پول استفاده خواهد شد.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۹',
                title: 'نگهداری اطلاعات',
                children: [
                  _buildParagraph(
                    context,
                    'اطلاعات تا زمانی که برای ارائه خدمات، حفظ امنیت، انجام تعهدات قانونی یا حل اختلافات لازم باشد نگهداری می‌شوند.',
                  ),
                  _buildParagraph(
                    context,
                    'در صورت حذف حساب، اطلاعات ممکن است طبق سیاست‌های نگهداری داده و الزامات قانونی حذف یا ناشناس‌سازی شوند.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۱۰',
                title: 'امنیت اطلاعات',
                children: [
                  _buildParagraph(
                    context,
                    'هابیتا تلاش می‌کند از اقدامات فنی و سازمانی مناسب برای محافظت از اطلاعات کاربران در برابر دسترسی غیرمجاز، تغییر، افشا یا تخریب استفاده کند.',
                  ),
                  _buildParagraph(
                    context,
                    'با این حال، هیچ روش انتقال یا ذخیره‌سازی اطلاعاتی نمی‌تواند امنیت مطلق را تضمین کند.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۱۱',
                title: 'خدمات شخص ثالث',
                children: [
                  _buildParagraph(
                    context,
                    'هابیتا ممکن است در آینده برای ارائه برخی قابلیت‌ها از سرویس‌دهندگان شخص ثالث مانند زیرساخت ابری، اعلان، تحلیل فنی یا احراز هویت استفاده کند.',
                  ),
                  _buildParagraph(
                    context,
                    'جزئیات سرویس‌دهندگان واقعی، نوع داده‌های منتقل‌شده و شرایط مربوط به هر سرویس باید پیش از انتشار نسخه نهایی این سیاست مشخص و مستند شود.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۱۲',
                title: 'حقوق کاربران',
                children: [
                  _buildBullet(
                    context,
                    'مشاهده و مدیریت برخی اطلاعات حساب و پروفایل.',
                  ),
                  _buildBullet(
                    context,
                    'ویرایش اطلاعات پروفایل.',
                  ),
                  _buildBullet(
                    context,
                    'مدیریت تنظیمات حریم خصوصی.',
                  ),
                  _buildBullet(
                    context,
                    'درخواست حذف حساب، مطابق شرایط و الزامات قانونی.',
                  ),
                  _buildBullet(
                    context,
                    'درخواست پشتیبانی درباره نحوه استفاده از اطلاعات.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۱۳',
                title: 'کودکان و افراد کم‌سن',
                children: [
                  _buildParagraph(
                    context,
                    'استفاده افراد کم‌سن از هابیتا باید مطابق حداقل سن مجاز، قوانین کشور محل اقامت کاربر و الزامات مربوط به خدمات آنلاین باشد.',
                  ),
                  _buildParagraph(
                    context,
                    'شرایط دقیق حداقل سن و نحوه مدیریت حساب افراد کم‌سن باید در نسخه نهایی محصول و اسناد حقوقی مشخص شود.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۱۴',
                title: 'انتقال بین‌المللی اطلاعات',
                children: [
                  _buildParagraph(
                    context,
                    'با توجه به ماهیت جهانی هابیتا، ممکن است اطلاعات کاربران در کشورهایی غیر از محل اقامت آن‌ها پردازش یا ذخیره شود.',
                  ),
                  _buildParagraph(
                    context,
                    'در نسخه نهایی محصول، سازوکارهای انتقال بین‌المللی داده باید مطابق قوانین و مقررات قابل‌اعمال مشخص شوند.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۱۵',
                title: 'تغییرات این سیاست',
                children: [
                  _buildParagraph(
                    context,
                    'ممکن است این سیاست در اثر تغییر قابلیت‌های هابیتا، الزامات قانونی یا روش‌های پردازش اطلاعات به‌روزرسانی شود.',
                  ),
                  _buildParagraph(
                    context,
                    'در صورت ایجاد تغییرات مهم، اطلاع‌رسانی مناسب در برنامه انجام خواهد شد.',
                  ),
                ],
              ),

              _buildSection(
                context,
                number: '۱۶',
                title: 'تماس با پشتیبانی',
                children: [
                  _buildParagraph(
                    context,
                    'اگر درباره حریم خصوصی، اطلاعات حساب یا نحوه پردازش داده‌های خود سؤالی دارید، می‌توانید از بخش «پشتیبانی» داخل برنامه با تیم هابیتا ارتباط برقرار کنید.',
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.16),
                      blurRadius: 18,
                      offset: const Offset(5, 7),
                    ),
                    BoxShadow(
                      color: colorScheme.surface.withOpacity(0.8),
                      blurRadius: 18,
                      offset: const Offset(-5, -7),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'این متن در حال حاضر پیش‌نویس محصول و رابط کاربری هابیتا است و قبل از انتشار عمومی باید توسط مشاور حقوقی بررسی و با قوانین مربوط به حریم خصوصی، از جمله GDPR و قوانین حوزه‌های هدف، تطبیق داده شود.',
                        style: textTheme.bodyMedium?.copyWith(
                          height: 1.7,
                        ),
                      ),
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

  Widget _buildHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.18),
            blurRadius: 24,
            offset: const Offset(7, 9),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.85),
            blurRadius: 24,
            offset: const Offset(-7, -9),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.18),
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
              icon,
              size: 34,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              height: 1.7,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String number,
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(4, 6),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.75),
            blurRadius: 16,
            offset: const Offset(-4, -6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primaryContainer,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildParagraph(
    BuildContext context,
    String text,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          height: 1.8,
        ),
      ),
    );
  }

  Widget _buildBullet(
    BuildContext context,
    String text,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Icon(
              Icons.circle,
              size: 7,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}