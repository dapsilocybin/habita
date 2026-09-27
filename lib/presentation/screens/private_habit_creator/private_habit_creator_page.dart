import 'package:flutter/material.dart';

class PrivateHabitCreatorPage extends StatefulWidget {
  const PrivateHabitCreatorPage({super.key});

  @override
  State<PrivateHabitCreatorPage> createState() =>
      _PrivateHabitCreatorPageState();
}

class _PrivateHabitCreatorPageState
    extends State<PrivateHabitCreatorPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _frequency = 'روزانه';
  int _targetPerWeek = 7;
  bool _showReminder = true;

  final List<String> _frequencies = [
    'روزانه',
    'هفتگی',
    'ماهانه',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _createHabit() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('عادت خصوصی ایجاد شد.'),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: const Text('عادت خصوصی'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntro(
                context,
                theme,
                colorScheme,
              ),
              const SizedBox(height: 28),
              _buildForm(
                context,
                theme,
                colorScheme,
              ),
              const SizedBox(height: 28),
              _buildPrivacyInfo(
                context,
                theme,
                colorScheme,
              ),
              const SizedBox(height: 32),
              _buildCreateButton(
                context,
                colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntro(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.16),
                  offset: const Offset(10, 10),
                  blurRadius: 22,
                ),
                BoxShadow(
                  color: colorScheme.surfaceContainerHighest
                      .withOpacity(0.8),
                  offset: const Offset(-8, -8),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              size: 46,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'عادت خودت را بساز',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'این عادت فقط برای خودت قابل مشاهده است و در جامعه هابیتا نمایش داده نمی‌شود.',
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

  Widget _buildForm(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اطلاعات عادت',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _nameController,
          textDirection: TextDirection.rtl,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'نام عادت',
            hintText: 'مثلاً ۱۰ دقیقه مدیتیشن',
            prefixIcon: Icon(
              Icons.edit_outlined,
            ),
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: _descriptionController,
          textDirection: TextDirection.rtl,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'توضیحات',
            hintText: 'توضیح کوتاهی درباره این عادت...',
            prefixIcon: Icon(
              Icons.notes_outlined,
            ),
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 18),
        DropdownButtonFormField<String>(
          initialValue: _frequency,
          decoration: const InputDecoration(
            labelText: 'تکرار',
            prefixIcon: Icon(
              Icons.repeat_outlined,
            ),
          ),
          items: _frequencies.map((frequency) {
            return DropdownMenuItem(
              value: frequency,
              child: Text(frequency),
            );
          }).toList(),
          onChanged: (value) {
            if (value == null) {
              return;
            }

            setState(() {
              _frequency = value;

              if (_frequency == 'روزانه') {
                _targetPerWeek = 7;
              } else if (_frequency == 'هفتگی') {
                _targetPerWeek = 1;
              } else {
                _targetPerWeek = 1;
              }
            });
          },
        ),
        const SizedBox(height: 18),
        _buildWeeklyTarget(
          context,
          theme,
          colorScheme,
        ),
      ],
    );
  }

  Widget _buildWeeklyTarget(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.07),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.8),
            offset: const Offset(-4, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.flag_outlined,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'هدف هفتگی',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '$_targetPerWeek بار',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Slider(
            value: _targetPerWeek.toDouble(),
            min: 1,
            max: 7,
            divisions: 6,
            label: '$_targetPerWeek',
            onChanged: (value) {
              setState(() {
                _targetPerWeek = value.round();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyInfo(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.visibility_off_outlined,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'کاملاً خصوصی',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'این عادت فقط در ردیاب شخصی تو قرار می‌گیرد. '
                  'سایر کاربران آن را در درخت عادت‌ها یا پروفایل تو نخواهند دید.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: _createHabit,
        icon: const Icon(
          Icons.add_rounded,
        ),
        label: const Text(
          'ساخت عادت خصوصی',
        ),
      ),
    );
  }
}
