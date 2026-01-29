import 'package:flutter/material.dart';
import '../auth/screens/role_selection_screen.dart';

class PartnerProfileScreen extends StatelessWidget {
  const PartnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/topHeaderImage.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🔲 Optional overlay (readability)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.12),
            ),
          ),

          /// 🔥 CONTENT
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _profileHeader(),
                  const SizedBox(height: 20),

                  _sectionTitle("Personal Info"),
                  _infoTile(Icons.person, "Name", "Rahul Sharma",),
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
          ),
        ],
      ),
    );
  }

  /// ================= HEADER =================
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Text(
          "Delivery Partner",
          style: TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  /// ================= SECTION TITLE =================
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
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  /// ================= INFO TILE =================
  Widget _infoTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,        // ✅ title black
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  /// ================= STATUS TILE =================
  Widget _statusTile(String title, bool verified) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          verified ? Icons.check_circle : Icons.error,
          color: verified ? Colors.green : Colors.red,
        ),
        title: Text(title),
        subtitle: Text(verified ? "Verified" : "Pending"),
      ),
    );
  }

  /// ================= LOGOUT =================
  Widget _logoutButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const PartnerTypeSelectionScreen(),
          ),
              (route) => false,
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
