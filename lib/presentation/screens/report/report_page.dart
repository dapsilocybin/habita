import 'package:flutter/material.dart';

enum ReportType {
  content,
  user,
}

class ReportPage extends StatefulWidget {
  final ReportType type;
  final String? username;
  final String? recordId;

  const ReportPage({
    super.key,
    required this.type,
    this.username,
    this.recordId,
  });

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _descriptionController =
      TextEditingController();

  String? _selectedReason;
  bool _isSubmitting = false;

  final List<_ReportReason> _contentReasons = const [
    _ReportReason(
      title: 'محتوای نامناسب',
      subtitle: 'محتوایی که برای جامعه هابیتا مناسب نیست.',
      icon: Icons.warning_amber_rounded,
    ),
    _ReportReason(
      title: 'اسپم',
      subtitle: 'محتوای تکراری، تبلیغاتی یا مزاحم.',
      icon: Icons.campaign_outlined,
    ),
    _ReportReason(
      title: 'اطلاعات نادرست',
      subtitle: 'محتوایی که اطلاعات گمراه‌کننده ارائه می‌کند.',
      icon: Icons.info_outline_rounded,
    ),
    _ReportReason(
      title: 'آزار و اذیت',
      subtitle: 'محتوایی که فرد یا گروهی را مورد آزار قرار می‌دهد.',
      icon: Icons.sentiment_dissatisfied_outlined,
    ),
    _ReportReason(
      title: 'خشونت یا تهدید',
      subtitle: 'محتوای مربوط به خشونت، تهدید یا آسیب‌رسانی.',
      icon: Icons.gpp_maybe_outlined,
    ),
    _ReportReason(
      title: 'نقض حقوق دیگران',
      subtitle: 'استفاده غیرمجاز از محتوا یا اطلاعات دیگران.',
      icon: Icons.copyright_outlined,
    ),
    _ReportReason(
      title: 'سایر',
      subtitle: 'دلیل دیگری که در گزینه‌های بالا وجود ندارد.',
      icon: Icons.more_horiz_rounded,
    ),
  ];

  final List<_ReportReason> _userReasons = const [
    _ReportReason(
      title: 'آزار و اذیت',
      subtitle: 'این کاربر رفتار آزاردهنده یا توهین‌آمیز دارد.',
      icon: Icons.sentiment_dissatisfied_outlined,
    ),
    _ReportReason(
      title: 'اسپم یا تبلیغات',
      subtitle: 'این کاربر محتوای تبلیغاتی یا مزاحم منتشر می‌کند.',
      icon: Icons.campaign_outlined,
    ),
    _ReportReason(
      title: 'حساب جعلی',
      subtitle: 'این حساب احتمالاً هویت شخص دیگری را جعل کرده است.',
      icon: Icons.person_off_outlined,
    ),
    _ReportReason(
      title: 'رفتار خطرناک',
      subtitle: 'این حساب رفتار یا محتوای بالقوه خطرناک دارد.',
      icon: Icons.gpp_maybe_outlined,
    ),
    _ReportReason(
      title: 'نقض قوانین هابیتا',
      subtitle: 'این حساب قوانین جامعه هابیتا را نقض می‌کند.',
      icon: Icons.rule_outlined,
    ),
    _ReportReason(
      title: 'سایر',
      subtitle: 'دلیل دیگری که در گزینه‌های بالا وجود ندارد.',
      icon: Icons.more_horiz_rounded,
    ),
  ];

  List<_ReportReason> get _reasons {
    return widget.type == ReportType.content
        ? _contentReasons
        : _userReasons;
  }

  bool get _canSubmit {
    return _selectedReason != null && !_isSubmitting;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('گزارش'),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    _buildHeader(theme),
                    const SizedBox(height: 20),
                    _buildTargetCard(theme),
                    const SizedBox(height: 24),
                    _buildSectionTitle(
                      theme,
                      'دلیل گزارش را انتخاب کنید',
                    ),
                    const SizedBox(height: 10),
                    ..._reasons.map(
                      (reason) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _buildReasonCard(
                          theme,
                          reason,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildSectionTitle(
                      theme,
                      'توضیحات بیشتر',
                    ),
                    const SizedBox(height: 8),
                    _buildDescriptionField(theme),
                    const SizedBox(height: 18),
                    _buildPrivacyNotice(theme),
                    const SizedBox(height: 20),
                    _buildWarning(theme, colorScheme),
                  ],
                ),
              ),
              _buildSubmitButton(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.type == ReportType.content
              ? 'گزارش این محتوا'
              : 'گزارش این کاربر',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'گزارش شما بررسی می‌شود و در صورت نیاز اقدامات لازم انجام خواهد شد.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildTargetCard(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    final isContent = widget.type == ReportType.content;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.10),
            blurRadius: 14,
            offset: const Offset(3, 4),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            blurRadius: 8,
            offset: const Offset(-3, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isContent
                  ? Icons.article_outlined
                  : Icons.person_outline_rounded,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isContent ? 'رکورد' : 'کاربر',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  isContent
                      ? 'رکورد ${widget.recordId ?? 'انتخاب‌شده'}'
                      : '@${widget.username ?? 'کاربر'}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    ThemeData theme,
    String title,
  ) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildReasonCard(
    ThemeData theme,
    _ReportReason reason,
  ) {
    final colorScheme = theme.colorScheme;
    final isSelected = _selectedReason == reason.title;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        setState(() {
          _selectedReason = reason.title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withOpacity(0.10)
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withOpacity(0.10),
            width: isSelected ? 1.4 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(
                isSelected ? 0.04 : 0.08,
              ),
              blurRadius: 10,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary.withOpacity(0.14)
                    : colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                reason.icon,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reason.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reason.subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Radio<String>(
              value: reason.title,
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionField(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _descriptionController,
        maxLines: 5,
        maxLength: 500,
        textDirection: TextDirection.rtl,
        decoration: const InputDecoration(
          hintText: 'اگر توضیح بیشتری داری، اینجا بنویس...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildPrivacyNotice(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'گزارش شما محرمانه است و نام شما به شخص گزارش‌شده نمایش داده نمی‌شود.',
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarning(
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.error.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 20,
            color: colorScheme.error,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'لطفاً فقط در صورتی گزارش ارسال کن که واقعاً نقض قوانین یا رفتار نامناسبی مشاهده کرده‌ای.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.10),
            blurRadius: 14,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: FilledButton(
          onPressed: _canSubmit ? _submitReport : null,
          child: _isSubmitting
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                  ),
                )
              : const Text('ارسال گزارش'),
        ),
      ),
    );
  }

  Future<void> _submitReport() async {
    if (!_canSubmit) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // TODO: Connect to report API/repository.
    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    await _showSuccessDialog();
  }

  Future<void> _showSuccessDialog() async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('گزارش ارسال شد'),
          content: const Text(
            'ممنون که به بهتر و امن‌تر شدن جامعه هابیتا کمک می‌کنی. '
            'گزارش شما توسط تیم بررسی محتوا بررسی خواهد شد.',
          ),
          icon: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: 32,
              color: colorScheme.primary,
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('متوجه شدم'),
            ),
          ],
        );
      },
    );

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }
}

class _ReportReason {
  final String title;
  final String subtitle;
  final IconData icon;

  const _ReportReason({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}