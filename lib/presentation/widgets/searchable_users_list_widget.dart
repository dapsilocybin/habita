import 'package:flutter/material.dart';

class SearchableUsersListWidget extends StatefulWidget {
  final String pageTitle;

  const SearchableUsersListWidget({Key? key, required this.pageTitle}) : super(key: key);

  @override
  _SearchableUsersListWidgetState createState() => _SearchableUsersListWidgetState();
}

class _SearchableUsersListWidgetState extends State<SearchableUsersListWidget> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _users = [
    {"username": "user1", "isFollowing": true},
    {"username": "user2", "isFollowing": false},
    // Add more users here
  ];
  List<Map<String, dynamic>> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _filteredUsers = _users;
    _searchController.addListener(_filterUsers);
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users.where((user) {
        return user['username'].toLowerCase().contains(query);
      }).toList();
    });
  }

  void _toggleFollow(int index) {
    setState(() {
      _filteredUsers[index]['isFollowing'] = !_filteredUsers[index]['isFollowing'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle, style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search ${widget.pageTitle}",
                filled: true,
                fillColor: colorScheme.surface,
                prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: colorScheme.onSurfaceVariant),
                        onPressed: () => _searchController.clear(),
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredUsers.length,
        itemBuilder: (context, index) {
          final user = _filteredUsers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: colorScheme.primaryContainer,
              child: Icon(Icons.person, color: colorScheme.onPrimaryContainer),
            ),
            title: Text(user['username'], style: TextStyle(color: colorScheme.onBackground)),
            trailing: ElevatedButton(
              onPressed: () => _toggleFollow(index),
              style: ElevatedButton.styleFrom(
                backgroundColor: user['isFollowing'] ? colorScheme.primary : colorScheme.secondary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(user['isFollowing'] ? "Following" : "Follow"),
            ),
          );
        },
      ),
    );
  }
}
