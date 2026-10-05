import 'package:flutter/material.dart';

enum StatusType {
  loading,
  empty,
  error,
  success,
}

class StatusPage extends StatelessWidget {
  final StatusType type;
  final String? title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool showBackButton;

  const StatusPage({
    super.key,
    required this.type,
    this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.showBackButton = false,
  });

  factory StatusPage.loading({
    Key? key,
    String title = 'در حال بارگذاری...',
    String message = 'لطفاً کمی صبر کن.',
    bool showBackButton = false,
  }) {
    return StatusPage(
      key: key,
      type: StatusType.loading,
      title: title,
      message: message,
      showBackButton: showBackButton,
    );
  }

  factory StatusPage.empty({
    Key? key,
    String title = 'چیزی پیدا نشد',
    String message = 'در حال حاضر اطلاعاتی برای نمایش وجود ندارد.',
    String? actionLabel,
    VoidCallback? onAction,
    bool showBackButton = false,
  }) {
    return StatusPage(
      key: key,
      type: StatusType.empty,
      title: title,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      showBackButton: showBackButton,
    );
  }

  factory StatusPage.error({
    Key? key,
    String title = 'خطایی رخ داد',
    String message = 'دریافت اطلاعات با مشکل مواجه شد.',
    String actionLabel = 'تلاش مجدد',
    VoidCallback? onAction,
    bool showBackButton = false,
  }) {
    return StatusPage(
      key: key,
      type: StatusType.error,
      title: title,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      showBackButton: showBackButton,
    );
  }

  factory StatusPage.success({
    Key? key,
    String title = 'با موفقیت انجام شد',
    String message = 'عملیات با موفقیت انجام شد.',
    String? actionLabel,
    VoidCallback? onAction,
    bool showBackButton = false,
  }) {
    return StatusPage(
      key: key,
      type: StatusType.success,
      title: title,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      showBackButton: showBackButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: showBackButton
            ? AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
              )
            : null,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIcon(theme),
                  const SizedBox(height: 24),
                  Text(
                    title ?? _defaultTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message ?? _defaultMessage,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (actionLabel != null && onAction != null) ...[
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 48,
                      child: FilledButton(
                        onPressed: onAction,
                        child: Text(actionLabel!),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    if (type == StatusType.loading) {
      return Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.12),
              blurRadius: 18,
              offset: const Offset(4, 5),
            ),
            BoxShadow(
              color: colorScheme.surface.withOpacity(0.9),
              blurRadius: 12,
              offset: const Offset(-4, -4),
            ),
          ],
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: colorScheme.primary,
            strokeWidth: 3,
          ),
        ),
      );
    }

    final icon = switch (type) {
      StatusType.empty => Icons.inbox_outlined,
      StatusType.error => Icons.cloud_off_rounded,
      StatusType.success => Icons.check_rounded,
      StatusType.loading => Icons.hourglass_empty_rounded,
    };

    final iconColor = switch (type) {
      StatusType.error => colorScheme.error,
      StatusType.success => colorScheme.primary,
      _ => colorScheme.onSurfaceVariant,
    };

    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(4, 5),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.9),
            blurRadius: 12,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 42,
        color: iconColor,
      ),
    );
  }

  String get _defaultTitle {
    switch (type) {
      case StatusType.loading:
        return 'در حال بارگذاری...';
      case StatusType.empty:
        return 'چیزی پیدا نشد';
      case StatusType.error:
        return 'خطایی رخ داد';
      case StatusType.success:
        return 'با موفقیت انجام شد';
    }
  }

  String get _defaultMessage {
    switch (type) {
      case StatusType.loading:
        return 'لطفاً کمی صبر کن.';
      case StatusType.empty:
        return 'در حال حاضر اطلاعاتی برای نمایش وجود ندارد.';
      case StatusType.error:
        return 'دریافت اطلاعات با مشکل مواجه شد.';
      case StatusType.success:
        return 'عملیات با موفقیت انجام شد.';
    }
  }
}