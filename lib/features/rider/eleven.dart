import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/twelve.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trip History")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _summaryCard("Today", "₹1,250"),
            _summaryCard("This Week", "₹8,940"),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.download),
              title: const Text("Download Statement"),
              subtitle: const Text("Daily / Weekly report"),
              onTap: () {
                // TODO: PDF download
              },
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WalletPayoutScreen(),
                  ),
                );
              },
              child: const Text("Go to Wallet"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String title, String amount) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(
          amount,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
