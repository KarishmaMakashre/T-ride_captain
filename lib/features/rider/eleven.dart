import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/twelve.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

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

          /// 🔲 OVERLAY
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.10),
            ),
          ),

          /// 🧱 MAIN CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔙 Back + Title
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Trip History",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// 🧾 Section Title
                  const Text(
                    "Recent Trips",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 🚕 Trip List
                  _tripTile(
                    title: "Airport → MP Nagar",
                    subtitle: "Today • 10:30 AM",
                    amount: "₹320",
                  ),
                  _tripTile(
                    title: "ISBT → New Market",
                    subtitle: "Yesterday • 8:15 PM",
                    amount: "₹280",
                  ),
                  _tripTile(
                    title: "Railway Stn → Area Colony",
                    subtitle: "Yesterday • 2:40 PM",
                    amount: "₹410",
                  ),

                  const SizedBox(height: 20),

                  /// ⬇ Download Statement
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.download),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Download Statement",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Daily / Weekly",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🎁 Offers Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1607082352121-fa243f3dde32",
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const Spacer(),

                  /// ✅ Go to Wallet
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WalletPayoutScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Go to Wallet",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🚕 Trip Tile
  Widget _tripTile({
    required String title,
    required String subtitle,
    required String amount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
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
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
