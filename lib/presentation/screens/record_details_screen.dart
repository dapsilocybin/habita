import 'package:flutter/material.dart';

class RecordDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Record Details", style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Record Picture
          Image.network(
            "https://via.placeholder.com/300x200",
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Caption
                Text("Daily Workout", style: TextStyle(color: colorScheme.onBackground, fontSize: 18)),
                SizedBox(height: 8),
                // Location and Time
                Text("Location: Central Park", style: TextStyle(color: colorScheme.onSurfaceVariant)),
                Text("Today, 9:00 AM", style: TextStyle(color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Divider(),

          // Comments Section
          Expanded(
            child: CommentSection(),
          ),
        ],
      ),
      bottomNavigationBar: AddCommentField(),
    );
  }
}

// Comment Section Widget
class CommentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 5, // Placeholder for comments count
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(backgroundColor: colorScheme.primaryContainer),
          title: Text("User$index", style: TextStyle(color: colorScheme.onBackground)),
          subtitle: Text("Great job!", style: TextStyle(color: colorScheme.onSurface)),
        );
      },
    );
  }
}

// Add Comment Field
class AddCommentField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Add a comment...",
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: colorScheme.primary),
            onPressed: () {
              // Logic to post comment
            },
          ),
        ],
      ),
    );
  }
}
