import 'package:flutter/material.dart';
import 'eleven.dart';

class EarningsUpdatedScreen extends StatelessWidget {
  const EarningsUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🖼️ BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/topHeaderImage.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🔲 DARK OVERLAY (for readability)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.10),
            ),
          ),

          /// 🧱 MAIN CONTENT
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_balance_wallet,
                      size: 80,
                      color: Colors.green,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "₹340 added to your earnings",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // better contrast
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TripHistoryScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "View Trip History",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
