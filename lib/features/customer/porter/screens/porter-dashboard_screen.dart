import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/app_constants.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/l10n/app_localizations.dart';

class PorterDashboardScreen extends StatefulWidget {
  const PorterDashboardScreen({super.key});

  @override
  State<PorterDashboardScreen> createState() => _PorterDashboardScreenState();
}

class _PorterDashboardScreenState extends State<PorterDashboardScreen> {
  final String _currentAddress =
      "Delhi Apollo Premises, Vijay Nagar, 16 Rithala Lok Colony...";

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Pick up from location card (Fixed layout to match screenshot)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.porterPrimaryLight.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.porterPrimary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pick up from",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _currentAddress,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textLight,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Vehicle selection (with images/icons as per screenshot)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    vehicleOption(Icons.local_shipping, "Truck"),
                    vehicleOption(Icons.two_wheeler, "Bike"),
                    vehicleOption(Icons.directions_car, "Car"),
                  ],
                ),

                const SizedBox(height: 30),

                // Porter Rewards
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.porterPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Colors.yellow,
                        size: 40,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore Porter Rewards",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Earn 2 coins for every ₹100 spent",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Announcements
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Announcements",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "View all",
                        style: TextStyle(color: AppColors.porterPrimary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.campaign,
                        color: AppColors.porterPrimary,
                        size: 40,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Introducing Porter Enterprise",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Add more details if needed
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View all",
                          style: TextStyle(color: AppColors.porterPrimary),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Orders Tabs
                DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Orders",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TabBar(
                        labelColor: AppColors.porterPrimary,
                        unselectedLabelColor: AppColors.textLight,
                        indicatorColor: AppColors.porterPrimary,
                        tabs: const [
                          Tab(text: "Active"),
                          Tab(text: "Complete"),
                          Tab(text: "Inbox"),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 350, // Increased a bit for better spacing
                        child: TabBarView(
                          children: [
                            // Active Tab Content
                            ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                orderOptionCard(
                                  title: "Deliver Now",
                                  subtitle:
                                      "We will assign a nearby 2-Wheeler to pick up and deliver as soon as possible",
                                  icon: Icons.access_time_filled,
                                  color: AppColors.porterPrimaryLight,
                                ),
                                const SizedBox(height: 16),
                                orderOptionCard(
                                  title: "By End of the day",
                                  subtitle:
                                      "Place your order by 4 PM and get it picked up to 6 PM and delivered by 9 PM. Rides combine orders into routes, and you save 40%",
                                  icon: Icons.calendar_today,
                                  color: AppColors.porterPrimaryLight,
                                  badge: "Save 40%",
                                ),
                              ],
                            ),
                            Center(child: Text("No completed orders")),
                            Center(child: Text("No inbox items")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100), // Extra space for bottom
              ],
            ),
          ),
        ),
      ),

      // Removed Bottom Navigation Bar completely as per request
    );
  }

  Widget vehicleOption(IconData icon, String label) {
    // Lowercase route ke liye (truck, bike, car)
    final String routeVehicle = label.toLowerCase();

    return GestureDetector(
      onTap: () {
        context.go('${AppConstants.routePorterSearch}/$routeVehicle');
        // Ya phir push use kar sakte ho agar back stack chahiye
        // context.push('/porter-new-order/$routeVehicle');
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.porterPrimary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40, color: AppColors.porterPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget orderOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    String? badge,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 50, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(color: AppColors.textLight, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
