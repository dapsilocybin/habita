import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture Section
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: colorScheme.primaryContainer,
                      backgroundImage: NetworkImage("https://via.placeholder.com/150"), // Placeholder for current image
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Logic to select new image
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: colorScheme.secondary,
                          child: Icon(Icons.camera_alt, color: colorScheme.onSecondary, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // User Info Fields
              TextFormField(
                initialValue: "Current Username", // Placeholder
                decoration: InputDecoration(
                  labelText: "Username",
                  filled: true,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 16),

              TextFormField(
                initialValue: "Current First Name", // Placeholder
                decoration: InputDecoration(
                  labelText: "First Name",
                  filled: true,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 16),

              TextFormField(
                initialValue: "Current Last Name", // Placeholder
                decoration: InputDecoration(
                  labelText: "Last Name",
                  filled: true,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 16),

              TextFormField(
                initialValue: "Current Bio", // Placeholder
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Bio",
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text("Update Profile", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
