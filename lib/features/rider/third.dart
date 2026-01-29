import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/four.dart';

class DriverNavigatePickupScreen extends StatelessWidget {
  const DriverNavigatePickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        title: const Text("Navigate to Pickup"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          /// 🗺️ MAP VIEW
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: const Center(
                child: Text(
                  "Google Map View",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),

          /// 🚕 BOTTOM INFO PANEL
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/topHeaderImage.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 👤 PASSENGER INFO
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage:
                      NetworkImage("https://i.pravatar.cc/150?img=3"),
                    ),
                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rahul Sharma",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Pickup: Airport Road",
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

                const SizedBox(height: 16),

                /// 🚦 ARRIVED BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3177D0),
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const DriverPickupVerificationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Arrived at Pickup",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
}
