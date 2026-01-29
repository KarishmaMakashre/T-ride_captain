import 'package:flutter/material.dart';

import 'eight.dart';

class DriverCollectPaymentScreen extends StatelessWidget {
  final double amount;
  final String bookingId;
  final String customerName;

  const DriverCollectPaymentScreen({
    super.key,
    required this.amount,
    required this.bookingId,
    required this.customerName,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collect Payment"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,

      body: Stack(
        children: [
          /// 🖼️ BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/topHeaderImage.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🔲 OPTIONAL OVERLAY
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.08),
            ),
          ),

          /// 🧱 MAIN CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _amountCard(),
                  const SizedBox(height: 20),
                  _qrCard(),
                  const SizedBox(height: 20),

                  /// 💵 COLLECT CASH
                  OutlinedButton(
                    onPressed: () => _showCashConfirm(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green, width: 1.5),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Collect Cash",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    "Please collect payment before ending the ride",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- AMOUNT CARD ----------------

  Widget _amountCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          const Text("Amount to Collect",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          Text(
            "₹ ${amount.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Customer: $customerName",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// ---------------- QR CARD ----------------

  Widget _qrCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: const [
          Text(
            "Scan QR to Pay",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Icon(Icons.qr_code_2, size: 150, color: Colors.black54),
          SizedBox(height: 12),
          Text(
            "Ask customer to scan & pay",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// ---------------- CASH CONFIRM ----------------

  void _showCashConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Cash Collected?"),
        content:
        const Text("Have you received the full cash amount?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              /// ✅ OPEN TRIP COMPLETED SCREEN
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const DriverTripCompletedScreen(),
                ),
              );
            },
            child: const Text(
              "Yes, Collected",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
