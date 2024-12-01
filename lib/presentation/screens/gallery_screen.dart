import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery", style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 10, // Replace with actual record count
          itemBuilder: (context, index) {
            return RecordCard(
              imageUrl: "https://via.placeholder.com/150",
              caption: "Daily Workout",
              location: "Central Park",
              time: "Today, 9:00 AM",
              colorScheme: colorScheme,
            );
          },
        ),
      ),
    );
  }
}

// Record Card Widget
class RecordCard extends StatelessWidget {
  final String imageUrl;
  final String caption;
  final String location;
  final String time;
  final ColorScheme colorScheme;

  const RecordCard({
    Key? key,
    required this.imageUrl,
    required this.caption,
    required this.location,
    required this.time,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Record Image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(caption, style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(location, style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12)),
                Text(time, style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
