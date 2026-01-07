import 'package:flutter/material.dart';
import 'eight.dart';

class DriverReachDropScreen extends StatelessWidget {
  const DriverReachDropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drop Location")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.flag, size: 80, color: Colors.green),
            const SizedBox(height: 20),

            const Text(
              "You have reached the drop location",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DriverTripCompletedScreen(),
                  ),
                );
              },
              child: const Text("Complete Trip"),
            ),
          ],
        ),
      ),
    );
  }
}
