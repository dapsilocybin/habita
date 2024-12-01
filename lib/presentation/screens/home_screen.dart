import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  void _openComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CommentsSection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        leading: Icon(Icons.home, color: colorScheme.onBackground),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: colorScheme.onBackground),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.message, color: colorScheme.onBackground),
            onPressed: () {},
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
      body: ListView.builder(
        itemCount: 10, // Example: Replace with actual post count
        itemBuilder: (context, index) => PostCard(
          onCommentTap: () => _openComments(context),
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final VoidCallback onCommentTap;

  const PostCard({Key? key, required this.onCommentTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header
            Row(
              children: [
                CircleAvatar(backgroundColor: colorScheme.primaryContainer),
                SizedBox(width: 8),
                Text("Username", style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onBackground)),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Chip(
                    label: Text("Habit Tag"),
                    backgroundColor: colorScheme.secondary,
                    labelStyle: TextStyle(color: colorScheme.onSecondary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Post Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/200'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),

            // Caption
            Text("This is a caption for the post", style: TextStyle(color: colorScheme.onBackground)),

            // Location and Time
            Text("Location • 5 mins ago", style: TextStyle(color: colorScheme.onBackground.withOpacity(0.6))),

            // Likes and Comments Row
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: colorScheme.onBackground,
                  onPressed: () {},
                ),
                Text("23", style: TextStyle(color: colorScheme.onBackground)),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: onCommentTap,
                  child: Row(
                    children: [
                      Icon(Icons.comment, color: colorScheme.onBackground),
                      SizedBox(width: 4),
                      Text("5", style: TextStyle(color: colorScheme.onBackground)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Comment Section Modal
class CommentsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Comments", style: TextStyle(color: colorScheme.primary, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(backgroundColor: colorScheme.primaryContainer),
                title: Text("Commenter", style: TextStyle(color: colorScheme.onBackground)),
                subtitle: Text("Nice post!", style: TextStyle(color: colorScheme.onBackground.withOpacity(0.8))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
