import 'package:flutter/material.dart';
import 'eleven.dart';

class EarningsUpdatedScreen extends StatelessWidget {
  const EarningsUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_balance_wallet,
                  size: 80, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                "₹340 added to your earnings",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TripHistoryScreen(),
                    ),
                  );
                },
                child: const Text("View Trip History"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
