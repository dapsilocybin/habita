import 'package:flutter/material.dart';

class HabitManagementScreen extends StatelessWidget {
  final List<String> habits = ["Reading", "Exercise", "Meditation", "Hydration", "Journaling"];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        title: Text("Habit Management", style: TextStyle(color: colorScheme.primary)),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt, color: colorScheme.primary),
            onPressed: () {
              // Add filtering logic
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorScheme.background,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Habits'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text("Progress Chart Placeholder", style: TextStyle(color: colorScheme.onPrimaryContainer)),
              ),
            ),
            SizedBox(height: 16),

            // Today's Habits Section Title
            Text(
              "Today’s Habits",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 8),

            // Habit List Section
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  return HabitCard(habitName: habits[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Habit Card Widget
class HabitCard extends StatelessWidget {
  final String habitName;

  const HabitCard({Key? key, required this.habitName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        // Navigate to specific habit page
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Habit Image Placeholder
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text("Habit Image", style: TextStyle(color: colorScheme.onPrimaryContainer)),
                ),
              ),
              SizedBox(height: 8),

              // Habit Category Icon and Title
              Row(
                children: [
                  Icon(Icons.category, color: colorScheme.primary, size: 18), // Habit category icon
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      habitName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Social Rating and Records Info
              Row(
                children: [
                  Icon(Icons.star, color: colorScheme.secondary, size: 18),
                  Text("4.5", style: TextStyle(color: colorScheme.onSurface)), // Placeholder for stars
                  Spacer(),
                  Text("12 records", style: TextStyle(color: colorScheme.onSurface)),
                ],
              ),
              SizedBox(height: 4),

              // Habit Creator and Total Record Count
              Text("Created by: user123", style: TextStyle(color: colorScheme.onSurface.withOpacity(0.6), fontSize: 12)),
              Text("Total: 58 records", style: TextStyle(color: colorScheme.onSurface.withOpacity(0.6), fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
