import 'package:flutter/material.dart';

class DriverMenuScreen extends StatelessWidget {
  const DriverMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Menu",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          /// 🔹 MENU LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _menuTile(
                  icon: Icons.person,
                  title: "My Profile",
                  subtitle: "View & edit profile details",
                  onTap: () {},
                ),
                _menuTile(
                  icon: Icons.account_balance_wallet,
                  title: "Wallet & Earnings",
                  subtitle: "View balance & payouts",
                  onTap: () {},
                ),
                _menuTile(
                  icon: Icons.history,
                  title: "Trip History",
                  subtitle: "Your completed rides",
                  onTap: () {},
                ),
                _menuTile(
                  icon: Icons.settings,
                  title: "Settings",
                  subtitle: "App preferences & account",
                  onTap: () {},
                ),
                _menuTile(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  subtitle: "Get help or contact support",
                  onTap: () {},
                ),
              ],
            ),
          ),

          /// 🔴 LOGOUT
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                elevation: 2,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= MENU TILE =================
  Widget _menuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.green),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.black45,
        ),
        onTap: onTap,
      ),
    );
  }
}
