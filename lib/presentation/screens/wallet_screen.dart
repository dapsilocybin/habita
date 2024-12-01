import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("HBT Wallet", style: TextStyle(color: colorScheme.primary)),
        backgroundColor: colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Wallet Balance
            Text(
              "Balance: 1234.56 HBT",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(height: 16),

            // Public Address
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "0x1234...abcd",
                      style: TextStyle(color: colorScheme.onSurface),
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
            ),
            SizedBox(height: 16),

            // Transfer Section
            Text(
              "Transfer HBT",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Destination Address",
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Amount",
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Handle transfer submission
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text("Submit Transfer", style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 16),

            // Transaction History
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Placeholder for transaction history length
                itemBuilder: (context, index) {
                  return TransactionCard(
                    type: index % 2 == 0 ? "Sent" : "Received",
                    address: "0xabcd...1234",
                    date: "2024-11-04",
                    time: "14:23",
                    amount: index % 2 == 0 ? "-50.0" : "+20.0",
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

// Transaction Card Widget
class TransactionCard extends StatelessWidget {
  final String type;
  final String address;
  final String date;
  final String time;
  final String amount;
  final ColorScheme colorScheme;

  const TransactionCard({
    Key? key,
    required this.type,
    required this.address,
    required this.date,
    required this.time,
    required this.amount,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: type == "Received" ? colorScheme.primary : colorScheme.error,
                  ),
                ),
                SizedBox(height: 4),
                Text("Address: $address", style: TextStyle(color: colorScheme.onSurface)),
                Text("$date at $time", style: TextStyle(color: colorScheme.onSurfaceVariant)),
              ],
            ),
            Text(
              "$amount HBT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: type == "Received" ? colorScheme.primary : colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
