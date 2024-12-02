import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habita/presentation/screens/habit_management_screen.dart';

class ProfileScreen extends StatelessWidget {
  final List<String> userHabits = ["Reading", "Exercise", "Meditation"];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // User Info & Stats
              ProfileHeaderSection(),

              SizedBox(height: 16),

              // Wallet Address Section
              WalletAddressSection(),

              SizedBox(height: 16),

              // Medals Section
              MedalsSection(),

              SizedBox(height: 16),

              // User Habits Section
              Text("My Habits", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorScheme.onBackground)),
              GridView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: userHabits.length,
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/habit_detail'),
      child: HabitCard(
        habitName: userHabits[index],
      ),
    );
  },
),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Followers
    GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/followers'),
      child: Column(
        children: [
          Icon(Icons.person, color: colorScheme.primary),
          Text("Followers", style: TextStyle(color: colorScheme.onBackground)),
          Text("230", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    ),
    // Following
    GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/following'),
      child: Column(
        children: [
          Icon(Icons.person_add, color: colorScheme.primary),
          Text("Following", style: TextStyle(color: colorScheme.onBackground)),
          Text("120", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  ],
);

  }
}

class WalletAddressSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
  children: [
    Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "0x1234...abcd",
          style: TextStyle(color: colorScheme.onPrimaryContainer),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
    IconButton(
      icon: Icon(Icons.copy, color: colorScheme.secondary),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: "0x1234...abcd"));
      },
    ),
  ],
);

  }
}

class MedalsSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      MedalWidget(medal: "Streak Medal", description: "Awarded for 30-day streak"),
      MedalWidget(medal: "Consistency Medal", description: "Awarded for 5 weekly completions"),
    ],
  ),
);
  }
}

// MedalWidget Example with Tooltip
class MedalWidget extends StatelessWidget {
  final String medal;
  final String description;

  MedalWidget({required this.medal, required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(description),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            );
          },
        );
      },
      child: Column(
        children: [
          Icon(Icons.emoji_events, size: 40, color: Theme.of(context).colorScheme.primary),
          Text(medal, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}



