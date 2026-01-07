import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/seven.dart';

class DriverTripStartedScreen extends StatelessWidget {
  const DriverTripStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trip Started")),
      body: Column(
        children: [
          /// MAP PLACEHOLDER
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: const Center(
                child: Text(
                  "LIVE NAVIGATION MAP",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),

          /// ETA + ACTIONS
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: Column(
              children: [
                _row("ETA", "12 mins"),
                _row("Remaining Distance", "6.1 km"),
                const SizedBox(height: 16),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DriverReachDropScreen(),
                      ),
                    );
                  },
                  child: const Text("Reached Drop Location"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
