import 'package:flutter/material.dart';

class SingleHabitScreen extends StatelessWidget {
  final bool isMember; // Toggle this for demo purposes

  const SingleHabitScreen({Key? key, required this.isMember}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Habit Detail", style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Habit Image with Overlay Info
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network("https://via.placeholder.com/300x200", fit: BoxFit.cover),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Habit Title", style: TextStyle(color: colorScheme.onPrimary, fontSize: 20)),
                      Row(
                        children: [
                          Icon(Icons.people, color: colorScheme.onPrimary, size: 16),
                          SizedBox(width: 4),
                          Text("Members: 123", style: TextStyle(color: colorScheme.onPrimary)),
                          SizedBox(width: 16),
                          Icon(Icons.star, color: colorScheme.secondary, size: 16),
                          Text("4.5", style: TextStyle(color: colorScheme.onPrimary)),
                        ],
                      ),
                      Text("Created by: User123", style: TextStyle(color: colorScheme.onPrimary)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "This is the description of the habit. It explains what the habit is about and its main goals.",
                style: TextStyle(color: colorScheme.onBackground),
              ),
            ),

            // Tags
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ["#fitness", "#health", "#mindset"].map((tag) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(label: Text(tag)),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Famous Members
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Famous Members", style: TextStyle(fontSize: 16, color: colorScheme.onBackground)),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: colorScheme.primaryContainer,
                            child: Icon(Icons.person, color: colorScheme.onPrimaryContainer),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Action Buttons
            if (!isMember)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Join habit logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text("Join (1 HBT)"),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add Record logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text("Add Record"),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Gallery logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text("Gallery"),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Group Chat logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text("Group Chat"),
                    ),
                    SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        // Quit Habit logic
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.error,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text("Quit Habit"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
