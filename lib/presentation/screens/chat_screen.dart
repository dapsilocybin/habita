import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Habit Group Chat", style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true, // To show the latest messages at the bottom
              itemCount: 20, // Placeholder count for messages
              itemBuilder: (context, index) {
                bool isUserMessage = index % 2 == 0; // Alternate for demo
                return MessageBubble(
                  isUserMessage: isUserMessage,
                  message: "This is a message #$index",
                  sender: isUserMessage ? "You" : "Member$index",
                  timestamp: "10:${index} AM",
                  colorScheme: colorScheme,
                );
              },
            ),
          ),
          Divider(),

          // Message Input Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      filled: true,
                      fillColor: colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: colorScheme.primary),
                  onPressed: () {
                    // Logic to send message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Message Bubble Widget
class MessageBubble extends StatelessWidget {
  final bool isUserMessage;
  final String message;
  final String sender;
  final String timestamp;
  final ColorScheme colorScheme;

  const MessageBubble({
    Key? key,
    required this.isUserMessage,
    required this.message,
    required this.sender,
    required this.timestamp,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUserMessage ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(sender, style: TextStyle(color: colorScheme.onPrimary, fontSize: 12)),
            SizedBox(height: 4),
            Text(message, style: TextStyle(color: colorScheme.onPrimary, fontSize: 16)),
            SizedBox(height: 4),
            Text(timestamp, style: TextStyle(color: colorScheme.onPrimary.withOpacity(0.7), fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
