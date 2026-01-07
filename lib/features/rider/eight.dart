import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/nine.dart';

class DriverTripCompletedScreen extends StatelessWidget {
  const DriverTripCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double baseFare = 80;
    final double distanceFare = 220;
    final double timeFare = 40;
    final double total = baseFare + distanceFare + timeFare;

    return Scaffold(
      appBar: AppBar(title: const Text("Trip Completed")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 10),
            const Text(
              "Trip Successfully Completed",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            _fareRow("Base Fare", baseFare),
            _fareRow("Distance Fare", distanceFare),
            _fareRow("Time Fare", timeFare),
            const Divider(),
            _fareRow("TOTAL", total, bold: true),

            const SizedBox(height: 30),

            _paymentStatusCard(),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RatePassengerScreen(),
                  ),

                );
              },
              child: const Text("Rate User"),

            ),
          ],
        ),
      ),
    );
  }

  Widget _fareRow(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: bold ? 16 : 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "₹${value.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: bold ? 16 : 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: const [
          Icon(Icons.payments, color: Colors.green),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Payment Received (Cash)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
