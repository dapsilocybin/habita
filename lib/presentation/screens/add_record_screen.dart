import 'package:flutter/material.dart';

class AddRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Record", style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Picture Container
            GestureDetector(
              onTap: () {
                // Logic to upload picture
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(Icons.camera_alt, color: colorScheme.onSurface, size: 40),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Caption Field
            TextFormField(
              decoration: InputDecoration(
                labelText: "Write a caption...",
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),

            // Location and Date/Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Location: Current Location", style: TextStyle(color: colorScheme.onSurface)),
                    Text("Date: ${DateTime.now().toLocal()}", style: TextStyle(color: colorScheme.onSurface)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // Current Habit and Record Counter
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Habit: Running (Record #15)",
                style: TextStyle(color: colorScheme.onPrimaryContainer, fontSize: 16),
              ),
            ),
            SizedBox(height: 16),

            // Add Button
            ElevatedButton(
              onPressed: () {
                // Submit record logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Add", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
