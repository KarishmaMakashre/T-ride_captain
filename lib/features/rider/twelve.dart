import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/features/rider/first.dart';
import '../porter_partner/screens/porter_dashboard_screen.dart';



class WalletPayoutScreen extends StatelessWidget {
  const WalletPayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔙 Back + Title
              Row(
                children: const [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 12),
                  Text(
                    "Wallet & Payout",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 💰 Balance Card (PORTER GREEN)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.porterGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available Balance",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "₹5,420",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// 💸 Payout Options
              const Text(
                "Payout Options",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 12),

              _optionTile(
                icon: Icons.account_balance,
                title: "Bank Transfer",
                subtitle: "Withdraw money to your bank account",
                onTap: () {},
              ),

              const SizedBox(height: 10),

              _optionTile(
                icon: Icons.qr_code,
                title: "UPI Transfer",
                subtitle: "Instant payout to UPI",
                onTap: () {},
              ),

              const SizedBox(height: 24),

              /// 🎁 Rewards
              const Text(
                "Rewards & Incentives",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 12),

              _optionTile(
                icon: Icons.card_giftcard,
                title: "Incentives & Bonus",
                subtitle: "View today’s rewards and bonuses",
                onTap: () {},
              ),

              const SizedBox(height: 24),

              /// 🖼 Offers Image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  "https://images.unsplash.com/photo-1520975916090-3105956dac38",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const Spacer(),

              /// ✅ GO TO DASHBOARD (PORTER GREEN DARK)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.porterGreenDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final role = prefs.getString('user_role');
                    debugPrint('User role from prefs: $role');
                    if(role ==  'rider'){

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                            (route) => false,
                      );

                    }else{
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PartnerDashboard(),
                        ),
                            (route) => false,
                      );

                    }

                  },
                  child: const Text(
                    "Go to dashboard",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Option Tile Widget (PORTER COLORS)
  Widget _optionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.porterGreenLight,
            child: Icon(icon, color: AppColors.porterGreenDark),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
