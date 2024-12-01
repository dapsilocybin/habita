import 'package:flutter/material.dart';

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonText;
  final String cancelButtonText;

  const ConfirmationModal({
    Key? key,
    required this.title,
    required this.message,
    this.confirmButtonText = "Confirm",
    this.cancelButtonText = "Cancel",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
        style: TextStyle(color: colorScheme.onBackground),
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            cancelButtonText,
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ),
        // Confirm Button
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}

// Function to show the confirmation modal and return a Future<bool>
Future<bool> showConfirmationModal({
  required BuildContext context,
  required String title,
  required String message,
  String confirmButtonText = "Confirm",
  String cancelButtonText = "Cancel",
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => ConfirmationModal(
      title: title,
      message: message,
      confirmButtonText: confirmButtonText,
      cancelButtonText: cancelButtonText,
    ),
  ).then((value) => value ?? false);
}
