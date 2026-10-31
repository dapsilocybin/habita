import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:habita/presentation/widgets/habita_bottom_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/models/joined_habit_model.dart';
import 'package:habita/data/providers/add_record_provider.dart';
import 'package:habita/data/repositories/add_record_repository.dart';
import 'package:habita/logic/blocs/add_record/add_record_bloc.dart';
import 'package:habita/logic/blocs/add_record/add_record_event.dart';
import 'package:habita/logic/blocs/add_record/add_record_state.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key, this.onNavigate});

  final ValueChanged<int>? onNavigate;

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  late final AddRecordBloc _addRecordBloc;
  final _captionController = TextEditingController();
  final _imagePicker = ImagePicker();
  bool _isPickingImage = false;

  @override
  void initState() {
    super.initState();

    final provider = AddRecordProvider();
    final repository = AddRecordRepository(addRecordProvider: provider);

    _addRecordBloc = AddRecordBloc(addRecordRepository: repository);
    _addRecordBloc.add(const AddRecordHabitsRequested());
  }

  @override
  void dispose() {
    _captionController.dispose();
    _addRecordBloc.close();
    super.dispose();
  }

  void _handleNavigation(int index) {
    if (index == 2) return;

    if (widget.onNavigate != null) {
      widget.onNavigate!(index);
      return;
    }

    const messages = {
      0: 'بخش خانه هنوز به صفحه اصلی متصل نشده است.',
      1: 'بخش کشف هنوز به صفحه اصلی متصل نشده است.',
      3: 'بخش پیگیری عادت‌ها هنوز به صفحه اصلی متصل نشده است.',
      4: 'بخش پروفایل هنوز به صفحه اصلی متصل نشده است.',
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(messages[index] ?? 'این بخش هنوز آماده نیست.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Future<void> _selectHabit() async {
    final habits = _addRecordBloc.state.joinedHabits;
    if (habits.isEmpty) return;

    final selectedHabit = await showModalBottomSheet<JoinedHabit>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final theme = Theme.of(context);
        final colors = theme.colorScheme;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'انتخاب عادت',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'یکی از عادت‌هایی که به آن پیوسته‌ای انتخاب کن.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: habits.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: colors.outlineVariant.withOpacity(0.5),
                      ),
                      itemBuilder: (context, index) {
                        final habit = habits[index];
                        final isSelected =
                            habit.id == _addRecordBloc.state.selectedHabitId;

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.track_changes_rounded,
                            color: isSelected
                                ? colors.primary
                                : colors.onSurfaceVariant,
                          ),
                          title: Text(habit.name),
                          trailing: isSelected
                              ? Icon(
                                  Icons.check_circle_rounded,
                                  color: colors.primary,
                                )
                              : null,
                          onTap: () {
                            Navigator.pop(context, habit);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (selectedHabit != null && mounted) {
      _addRecordBloc.add(
        AddRecordHabitSelected(
          habitId: selectedHabit.id,
          habitName: selectedHabit.name,
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    try {
      setState(() {
        _isPickingImage = true;
      });

      final file = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (file == null || !mounted) return;

      final bytes = await file.readAsBytes();

      if (!mounted) return;

      _addRecordBloc.add(
        AddRecordImageSelected(imageBytes: bytes, imageName: file.name),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('انتخاب تصویر با مشکل مواجه شد.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPickingImage = false;
        });
      }
    }
  }

  void _removeImage() {
    _addRecordBloc.add(const AddRecordImageRemoved());
  }

  void _publishRecord() {
    _addRecordBloc.add(const AddRecordSubmitted());
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocProvider.value(
      value: _addRecordBloc,
      child: BlocListener<AddRecordBloc, AddRecordState>(
        listenWhen: (previous, current) =>
            previous.validationMessage != current.validationMessage ||
            previous.submissionSuccess != current.submissionSuccess ||
            previous.submissionError != current.submissionError,
        listener: (context, state) {
          if (state.validationMessage != null) {
            _showMessage(state.validationMessage!);
          } else if (state.submissionError != null) {
            _showMessage(state.submissionError!);
          } else if (state.submissionSuccess) {
            _captionController.clear();
            _showMessage('تلاش تو با موفقیت ثبت شد.');
          }
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: theme.scaffoldBackgroundColor,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              centerTitle: false,
              title: Text(
                'ثبت تلاش',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: BlocBuilder<AddRecordBloc, AddRecordState>(
              builder: (context, state) {
                return SafeArea(
                  bottom: false,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIntroduction(theme),
                        const SizedBox(height: 32),

                        _buildSectionTitle(
                          theme,
                          title: 'این تلاش مربوط به کدام عادته؟',
                          subtitle: 'یکی از عادت‌های فعال خودت رو انتخاب کن.',
                        ),
                        const SizedBox(height: 14),

                        _buildHabitSelectionArea(theme, state),
                        const SizedBox(height: 32),

                        _buildSectionTitle(
                          theme,
                          title: 'از تلاشت بگو',
                          subtitle: 'چه کاری انجام دادی؟ چه حسی داشتی؟',
                        ),
                        const SizedBox(height: 14),

                        _buildCaptionField(theme),
                        const SizedBox(height: 32),

                        _buildSectionTitle(
                          theme,
                          title: 'تصویر تلاش',
                          subtitle: 'در صورت تمایل می‌تونی یک تصویر اضافه کنی.',
                        ),
                        const SizedBox(height: 14),

                        _buildImagePicker(theme, state),
                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: FilledButton.icon(
                            onPressed: state.isSubmitting
                                ? null
                                : _publishRecord,
                            icon: state.isSubmitting
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.send_rounded),
                            label: Text(
                              state.isSubmitting ? 'در حال ثبت...' : 'ثبت تلاش',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Center(
                          child: Text(
                            'هر قدم کوچکی ارزش ثبت شدن داره 🌱',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: HabitaBottomNavigation(
              selectedIndex: 2,
              onItemSelected: _handleNavigation,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction(ThemeData theme) {
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.primaryContainer.withOpacity(0.55),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.spa_rounded, size: 30, color: colors.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'یک قدم به جلو',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'لازم نیست هر روز فوق‌العاده باشی؛ فقط کافیه برای بهتر شدن تلاش کنی.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.7,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    ThemeData theme, {
    required String title,
    required String subtitle,
  }) {
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildHabitSelector(ThemeData theme, AddRecordState state) {
    final colors = theme.colorScheme;
    final hasSelection = state.selectedHabitName != null;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: _selectHabit,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasSelection
                  ? colors.primary.withOpacity(0.6)
                  : colors.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.track_changes_rounded,
                color: colors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  state.selectedHabitName ?? 'انتخاب عادت',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: hasSelection
                        ? colors.onSurface
                        : colors.onSurfaceVariant,
                    fontWeight: hasSelection
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: colors.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHabitSelectionArea(ThemeData theme, AddRecordState state) {
    if (state.isLoadingHabits) {
      return const SizedBox(
        height: 56,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.habitsError != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.habitsError!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          TextButton.icon(
            onPressed: () {
              _addRecordBloc.add(const AddRecordHabitsRequested());
            },
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('تلاش دوباره'),
          ),
        ],
      );
    }

    if (state.joinedHabits.isEmpty) {
      return Text(
        'هنوز به هیچ عادت فعالی نپیوسته‌ای.',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    }

    return _buildHabitSelector(theme, state);
  }

  Widget _buildCaptionField(ThemeData theme) {
    final colors = theme.colorScheme;

    return TextField(
      controller: _captionController,
      minLines: 5,
      onChanged: (value) {
        _addRecordBloc.add(AddRecordCaptionChanged(value));
      },
      maxLines: 8,
      maxLength: 1000,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.start,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'امروز چه تلاشی کردی؟ برامون تعریف کن...',
        hintMaxLines: 2,
        alignLabelWithHint: true,
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildImagePicker(ThemeData theme, AddRecordState state) {
    final colors = theme.colorScheme;

    if (state.imageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.15,
              child: Image.memory(
                state.imageBytes!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Material(
                color: colors.surface.withOpacity(0.9),
                shape: const CircleBorder(),
                child: IconButton(
                  tooltip: 'حذف تصویر',
                  onPressed: _removeImage,
                  icon: Icon(Icons.delete_outline_rounded, color: colors.error),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  state.imageName ?? 'تصویر انتخاب‌شده',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: _isPickingImage ? null : _pickImage,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: colors.outlineVariant,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            children: [
              if (_isPickingImage)
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 38,
                  color: colors.primary,
                ),
              const SizedBox(height: 12),
              Text(
                _isPickingImage ? 'در حال انتخاب تصویر...' : 'افزودن تصویر',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'اختیاری · انتخاب از گالری',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
