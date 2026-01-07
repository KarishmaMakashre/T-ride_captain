import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/features/rider/first.dart'; // HomeScreen

class WalletPayoutScreen extends StatelessWidget {
  const WalletPayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet & Payout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _walletCard("Available Balance", "₹5,420"),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text("Bank Transfer"),
              subtitle: const Text("Withdraw to bank"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text("Incentives & Bonus"),
              subtitle: const Text("View rewards"),
              onTap: () {},
            ),

            const Spacer(),

            /// ✅ GO TO DASHBOARD → HOME SCREEN
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final role = prefs.getString('user_role');
                print('User role from prefs: $role');

                // 🔥 DIRECT HOME SCREEN
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                      (route) => false,
                );
              },
              child: const Text("Go to dashboard"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _walletCard(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
