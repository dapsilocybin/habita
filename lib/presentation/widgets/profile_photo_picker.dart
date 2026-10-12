
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/app_theme.dart';

class ProfilePhotoPicker extends StatefulWidget {
  const ProfilePhotoPicker({
    super.key,
    this.size = 112,
    this.onPhotoChanged,
  });

  final double size;
  final ValueChanged<XFile?>? onPhotoChanged;

  @override
  State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedPhoto;
  ImageProvider? _imageProvider;
  bool _isPicking = false;

  Future<void> _choosePhoto() async {
    if (_isPicking) return;

    setState(() => _isPicking = true);

    try {
      final photo = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
      );

      if (!mounted || photo == null) return;

      final bytes = await photo.readAsBytes();

      if (!mounted) return;

      setState(() {
        _selectedPhoto = photo;
        _imageProvider = MemoryImage(bytes);
      });

      widget.onPhotoChanged?.call(photo);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('انتخاب عکس با مشکل مواجه شد. دوباره تلاش کن.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isPicking = false);
      }
    }
  }

  void _removePhoto() {
    setState(() {
      _selectedPhoto = null;
      _imageProvider = null;
    });

    widget.onPhotoChanged?.call(null);
  }

  Future<void> _showPhotoOptions() async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final action = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      backgroundColor: colorScheme.surface,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'عکس پروفایل',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: Text(
                    _imageProvider == null
                        ? 'انتخاب عکس'
                        : 'تغییر عکس',
                  ),
                  onTap: () => Navigator.pop(sheetContext, 'choose'),
                ),
                if (_imageProvider != null)
                  ListTile(
                    leading: Icon(
                      Icons.delete_outline,
                      color: colorScheme.error,
                    ),
                    title: Text(
                      'حذف عکس',
                      style: TextStyle(color: colorScheme.error),
                    ),
                    onTap: () => Navigator.pop(sheetContext, 'remove'),
                  ),
              ],
            ),
          ),
        );
      },
    );

    if (!mounted) return;

    switch (action) {
      case 'choose':
        await _choosePhoto();
      case 'remove':
        _removePhoto();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final neomorphism =
        theme.extension<NeomorphismStyleExtension>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          button: true,
          label: 'انتخاب یا تغییر عکس پروفایل',
          child: InkWell(
            onTap: _isPicking ? null : _showPhotoOptions,
            customBorder: const CircleBorder(),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: widget.size,
                  height: widget.size,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.surface,
                    boxShadow: neomorphism?.shadows,
                  ),
                  child: ClipOval(
                    child: _imageProvider != null
                        ? Image(
                            image: _imageProvider!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : Container(
                            color: colorScheme.primaryContainer,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.person_outline,
                              size: widget.size * 0.46,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                  ),
                ),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.surface,
                        width: 3,
                      ),
                    ),
                    child: _isPicking
                        ? Padding(
                            padding: const EdgeInsets.all(7),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.onPrimary,
                            ),
                          )
                        : Icon(
                            Icons.camera_alt_outlined,
                            size: 18,
                            color: colorScheme.onPrimary,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: _isPicking ? null : _showPhotoOptions,
          child: Text(
            _imageProvider == null
                ? 'افزودن عکس پروفایل'
                : 'تغییر عکس پروفایل',
          ),
        ),
      ],
    );
  }
}
