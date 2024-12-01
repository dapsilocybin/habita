import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: colorScheme.background.withOpacity(0.95),
      insetPadding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search habits or users...",
                filled: true,
                fillColor: colorScheme.surface,
                prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: colorScheme.onSurfaceVariant),
                  onPressed: () {
                    // Clear search query logic
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),

            // Predefined Search Categories (Grid)
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: predefinedCategories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Trigger predefined search based on category
                    },
                    child: Card(
                      color: colorScheme.surface,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          predefinedCategories[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(color: colorScheme.onSurface),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Predefined Search Categories
final List<String> predefinedCategories = [
  "Trending Habits",
  "Trending Users",
  "Workout",
  "Learning",
  "Music",
  "Art",
  "Hobbies",
  "Mental Health",
  // Add more categories as needed
];
