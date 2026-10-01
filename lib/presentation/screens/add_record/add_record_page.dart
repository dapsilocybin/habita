import 'package:flutter/material.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key});

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  final _captionController = TextEditingController();

  String? _selectedHabit;
  String? _selectedImage;

  final List<String> _habits = const [
    'ورزش',
    'مطالعه روزانه',
    'خواب منظم',
    'یادگیری زبان',
    'مدیتیشن',
    'نوشیدن آب',
    'پیاده‌روی',
    'برنامه‌ریزی روزانه',
  ];

  @override 
  void initState() {
    super.initState(); 
    _captionController.addListener(() { setState(() {}); }); 
  }
  
  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void _publishRecord() {
    final caption = _captionController.text.trim();

    if (_selectedHabit == null || caption.isEmpty) {
      return;
    }

    // TODO:
    // Create the record through Bloc/API.
    //
    // Example later:
    //
    // context.read<RecordBloc>().add(
    //   CreateRecordRequested(
    //     habitId: _selectedHabitId,
    //     caption: caption,
    //     image: _selectedImage,
    //   ),
    // );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('رکورد شما آماده انتشار است.'),
      ),
    );
  }

  void _selectImage() {
    // TODO:
    // Open image picker later.
    //
    // For now we use the existing mock image.
    setState(() {
      _selectedImage = 'assets/images/post.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: const Text('ثبت رکورد'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHabitSelector(context, theme, colorScheme),
              const SizedBox(height: 28),
              _buildCaptionSection(context, theme, colorScheme),
              const SizedBox(height: 24),
              _buildImageSection(context, theme, colorScheme),
              const SizedBox(height: 32),
              _buildPublishButton(context, theme, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHabitSelector(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'عادت',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _selectedHabit,
          decoration: const InputDecoration(
            hintText: 'عادت مورد نظر را انتخاب کن',
            prefixIcon: Icon(Icons.track_changes_rounded),
          ),
          items: _habits.map((habit) {
            return DropdownMenuItem<String>(
              value: habit,
              child: Text(habit),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedHabit = value;
            });
          },
        ),
        const SizedBox(height: 8),
        Text(
          'رکورد باید به یکی از عادت‌های انتخاب‌شده مرتبط باشد.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildCaptionSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'امروز چه کاری انجام دادی؟',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _captionController,
          minLines: 5,
          maxLines: 8,
          textInputAction: TextInputAction.newline,
          decoration: const InputDecoration(
            hintText:
                'از تجربه‌ات بنویس... چه حسی داشتی؟ چه چیزی یاد گرفتی؟',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'نوشتن درباره تلاش امروزت بخش اصلی یک رکورد است.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'تصویر',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'اختیاری',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (_selectedImage == null)
          _ImagePickerPlaceholder(onTap: _selectImage)
        else
          _SelectedImage(
            image: _selectedImage!,
            onRemove: () {
              setState(() {
                _selectedImage = null;
              });
            },
          ),
      ],
    );
  }

  Widget _buildPublishButton(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    final canPublish = _selectedHabit != null &&
        _captionController.text.trim().isNotEmpty;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: canPublish ? _publishRecord : null,
        icon: const Icon(Icons.publish_rounded),
        label: const Text('ثبت رکورد'),
      ),
    );
  }
}

class _ImagePickerPlaceholder extends StatelessWidget {
  final VoidCallback onTap;

  const _ImagePickerPlaceholder({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: colorScheme.outlineVariant,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.12),
              offset: const Offset(6, 6),
              blurRadius: 14,
            ),
            BoxShadow(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
              offset: const Offset(-5, -5),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 42,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              'افزودن تصویر',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'اختیاری',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedImage extends StatelessWidget {
  final String image;
  final VoidCallback onRemove;

  const _SelectedImage({
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            image,
            width: double.infinity,
            height: 240,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.18),
                  offset: const Offset(3, 3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.close_rounded),
            ),
          ),
        ),
      ],
    );
  }
}
