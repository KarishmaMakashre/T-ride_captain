import 'package:flutter/material.dart';

import '../auth/screens/role_selection_screen.dart';

class PartnerProfileScreen extends StatelessWidget {
  const PartnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _profileHeader(),
            const SizedBox(height: 20),

            _sectionTitle("Personal Info"),
            _infoTile(Icons.person, "Name", "Rahul Sharma"),
            _infoTile(Icons.badge, "Partner ID", "FDX102938"),

            _sectionTitle("Documents"),
            _statusTile("Driving License", true),
            _statusTile("RC Book", true),
            _statusTile("Insurance", false),
            _statusTile("ID Proof", true),

            _sectionTitle("Vehicle"),
            _infoTile(Icons.delivery_dining, "Vehicle Type", "Bike"),
            _infoTile(Icons.confirmation_number, "Vehicle Number", "MP09 AB 1234"),

            _sectionTitle("Bank Details"),
            _infoTile(Icons.account_balance, "Bank", "SBI"),
            _infoTile(Icons.credit_card, "Account No", "XXXXXX4321"),

            const SizedBox(height: 20),
            _logoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(
            "https://i.pravatar.cc/150?img=3",
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Rahul Sharma",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Delivery Partner",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _statusTile(String title, bool verified) {
    return ListTile(
      leading: Icon(
        verified ? Icons.check_circle : Icons.error,
        color: verified ? Colors.green : Colors.red,
      ),
      title: Text(title),
      subtitle: Text(verified ? "Verified" : "Pending"),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const PartnerTypeSelectionScreen(),
          ),
              (route) => false, // 🔥 clear back stack
        );
      },
      icon: const Icon(Icons.logout),
      label: const Text("Logout"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
