import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/six.dart';

class DriverTripInProgressScreen extends StatelessWidget {
  const DriverTripInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(title: const Text("Trip In Progress"), centerTitle: true),

      body: Column(
        children: [
          /// 🗺️ LIVE MAP
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Text(
                      "LIVE NAVIGATION MAP",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                /// 🔴 TRIP STATUS CHIP
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "TRIP ACTIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🔽 BOTTOM SHEET
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/topHeaderImage.png'),
                fit: BoxFit.cover, // important
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 👤 PASSENGER INFO
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=3",
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Rahul Sharma",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // readable on image
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "⭐ 4.8 rating",
                            style: TextStyle(color: Colors.black45),
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

                const SizedBox(height: 14),

                /// 📍 ROUTE INFO
                _routeRow(
                  icon: Icons.location_on,
                  color: Colors.green,
                  label: "Pickup",
                  value: "Airport Road, Bhopal",
                ),
                const SizedBox(height: 8),
                _routeRow(
                  icon: Icons.flag,
                  color: Colors.red,
                  label: "Drop",
                  value: "MP Nagar Zone 2",
                ),

                const SizedBox(height: 16),

                /// 📊 LIVE STATS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _TripStat(title: "Distance", value: "5.2 km"),
                    _TripStat(title: "Time", value: "18 min"),
                    _TripStat(title: "ETA", value: "7 min"),
                  ],
                ),

                const SizedBox(height: 20),

                /// 🛑 END TRIP BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DriverTripStartedScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "End Trip",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 📍 ROUTE ROW
  Widget _routeRow({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 📊 STAT WIDGET
class _TripStat extends StatelessWidget {
  final String title;
  final String value;

  const _TripStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
