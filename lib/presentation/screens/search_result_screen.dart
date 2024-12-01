import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchQuery;

  const SearchResultScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String _selectedType = "Users";
  String _sortOption = "Fame";
  List<String> _categoryFilters = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results", style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: widget.searchQuery,
                prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onTap: () {
                // Open search overlay modal
              },
            ),
            SizedBox(height: 16),

            // Type Toggle Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ToggleButtons(
                  isSelected: [_selectedType == "Users", _selectedType == "Habits"],
                  onPressed: (index) {
                    setState(() {
                      _selectedType = index == 0 ? "Users" : "Habits";
                    });
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Users", style: TextStyle(color: colorScheme.onSurface)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Habits", style: TextStyle(color: colorScheme.onSurface)),
                    ),
                  ],
                  color: colorScheme.onSurface,
                  selectedColor: colorScheme.primary,
                  fillColor: colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                // Sort Dropdown
                DropdownButton<String>(
                  value: _sortOption,
                  items: (_selectedType == "Users" ? userSortOptions : habitSortOptions)
                      .map((option) => DropdownMenuItem(
                            child: Text(option),
                            value: option,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _sortOption = value!;
                    });
                  },
                  hint: Text("Sort by", style: TextStyle(color: colorScheme.onSurface)),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Category Filter Dropdown (only for Habits)
            if (_selectedType == "Habits")
              DropdownButtonFormField(
                items: categoryOptions
                    .map((category) => DropdownMenuItem(
                          child: Text(category),
                          value: category,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (_categoryFilters.contains(value)) {
                      _categoryFilters.remove(value);
                    } else {
                      _categoryFilters.add(value as String);
                    }
                  });
                },
                decoration: InputDecoration(
                  labelText: "Filter by Category",
                  filled: true,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            SizedBox(height: 16),

            // Search Results (Grid for Habits, List for Users)
            Expanded(
              child: _selectedType == "Habits"
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 10, // Placeholder count
                      itemBuilder: (context, index) {
                        return HabitCard(
                          habitName: "Habit $index",
                          colorScheme: colorScheme,
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: 10, // Placeholder count
                      itemBuilder: (context, index) {
                        return UserListItem(
                          username: "User$index",
                          fullName: "Full Name $index",
                          activeHabits: index * 3,
                          medals: index,
                          colorScheme: colorScheme,
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

// Dummy Data and Widgets
final List<String> userSortOptions = ["Fame", "Medals", "Registered Habits", "Total Records"];
final List<String> habitSortOptions = ["Stars", "Records", "Members"];
final List<String> categoryOptions = ["Workout", "Learning", "Art", "Music", "Mental Health"];

class HabitCard extends StatelessWidget {
  final String habitName;
  final ColorScheme colorScheme;

  const HabitCard({Key? key, required this.habitName, required this.colorScheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(habitName, style: TextStyle(color: colorScheme.onSurface)),
      ),
    );
  }
}

class UserListItem extends StatelessWidget {
  final String username;
  final String fullName;
  final int activeHabits;
  final int medals;
  final ColorScheme colorScheme;

  const UserListItem({
    Key? key,
    required this.username,
    required this.fullName,
    required this.activeHabits,
    required this.medals,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorScheme.primaryContainer,
        child: Icon(Icons.person, color: colorScheme.onPrimaryContainer),
      ),
      title: Text(username, style: TextStyle(color: colorScheme.onBackground)),
      subtitle: Text("Habits: $activeHabits, Medals: $medals", style: TextStyle(color: colorScheme.onSurface)),
      trailing: Text(fullName, style: TextStyle(color: colorScheme.onBackground)),
    );
  }
}
