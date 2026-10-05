import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: 'مصطفی');

  final _usernameController = TextEditingController(text: 'mostafa');

  final _bioController = TextEditingController(
    text: 'در مسیر ساختن نسخه بهتر خودم.',
  );

  final String _phoneNumber = '09123456789';

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _changeProfileImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('انتخاب تصویر در نسخه نهایی اضافه می‌شود.')),
    );
  }

  void _saveProfile() {
    final name = _nameController.text.trim();
    final username = _usernameController.text.trim();

    if (name.isEmpty || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لطفاً نام و نام کاربری را وارد کن.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('اطلاعات پروفایل با موفقیت ذخیره شد.')),
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
        title: const Text('ویرایش پروفایل'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            children: [
              _buildProfileImage(colorScheme),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: _changeProfileImage,
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('تغییر تصویر پروفایل'),
              ),
              const SizedBox(height: 32),
              _buildSectionTitle(context, 'اطلاعات عمومی'),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'نام',
                  hintText: 'نام نمایشی شما',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                textDirection: TextDirection.ltr,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'نام کاربری',
                  hintText: 'username',
                  prefixIcon: Icon(Icons.alternate_email),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _bioController,
                maxLines: 4,
                maxLength: 160,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  labelText: 'درباره من',
                  hintText: 'کمی درباره خودت بنویس...',
                  prefixIcon: Icon(Icons.edit_note_outlined),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle(context, 'شماره موبایل'),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: _phoneNumber),
                readOnly: true,
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  labelText: 'شماره موبایل',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  suffixIcon: Icon(
                    Icons.lock_outline,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'شماره موبایل برای ورود به حساب استفاده می‌شود.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.check),
                  label: const Text('ذخیره تغییرات'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(ColorScheme colorScheme) {
    return Container(
      width: 132,
      height: 132,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.20),
            offset: const Offset(12, 12),
            blurRadius: 24,
          ),
          BoxShadow(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.8),
            offset: const Offset(-10, -10),
            blurRadius: 20,
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: ClipOval(
        child: Image.asset('assets/images/man.jpg', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
