import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/third.dart';

class DriverRideAcceptedScreen extends StatelessWidget {
  const DriverRideAcceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        title: const Text("Ride Accepted"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🚕 PASSENGER CARD
            _card(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage:
                    NetworkImage("https://i.pravatar.cc/150?img=3"),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Rahul Sharma",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "⭐ 4.8 • 52 trips",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.chat, color: Colors.blue),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 📍 ROUTE CARD
            _card(
              child: Column(
                children: [
                  _locationRow(
                    icon: Icons.radio_button_checked,
                    color: Colors.green,
                    title: "Pickup",
                    value: "Airport Road, Bhopal",
                  ),
                  _routeDivider(),
                  _locationRow(
                    icon: Icons.location_on,
                    color: Colors.red,
                    title: "Drop",
                    value: "MP Nagar Zone 2",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 💰 TRIP DETAILS
            _card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _tripInfo("Distance", "8.4 km"),
                  _tripInfo("Fare", "₹320"),
                  _tripInfo("Payment", "Cash"),
                ],
              ),
            ),

            const Spacer(),

            /// 🚦 NAVIGATE BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DriverNavigatePickupScreen(),
                  ),
                );
              },
              child: const Text(
                "Navigate to Pickup",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔲 COMMON CARD
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  /// 📍 LOCATION ROW
  Widget _locationRow({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 🛣️ ROUTE DIVIDER
  Widget _routeDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: const [
          SizedBox(width: 10),
          SizedBox(
            height: 24,
            child: VerticalDivider(thickness: 1),
          ),
        ],
      ),
    );
  }

  /// ℹ️ TRIP INFO
  Widget _tripInfo(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
