import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Explore", style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: 15, // Placeholder for number of trend items
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to habit or post detail page
              },
              child: TrendCard(
                isPost: index % 2 == 0, // Alternate between post and habit card
                colorScheme: colorScheme,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        child: Icon(Icons.search, color: colorScheme.onPrimary),
        onPressed: () {
          _showSearchModal(context);
        },
      ),
    );
  }

  void _showSearchModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SearchModal();
      },
    );
  }
}

// Trend Card Widget (For Habit Post or Habit Card)
class TrendCard extends StatelessWidget {
  final bool isPost;
  final ColorScheme colorScheme;

  const TrendCard({Key? key, required this.isPost, required this.colorScheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Placeholder for post/habit image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorScheme.primaryContainer,
            ),
            child: Center(
              child: Text(
                isPost ? "Habit Post" : "Habit Card",
                style: TextStyle(color: colorScheme.onPrimaryContainer),
              ),
            ),
          ),
          if (!isPost)
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(
                "Habit Name", // Example habit name
                style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}

// Search Modal
class SearchModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: colorScheme.background.withOpacity(0.9),
      insetPadding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search habits or users...",
                filled: true,
                fillColor: colorScheme.surface,
                prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text("Search Results Placeholder", style: TextStyle(color: colorScheme.onBackground)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
