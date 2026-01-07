// // porter_dashboard.dart
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tryde_partner/core/constants/app_constants.dart';
// import 'package:tryde_partner/core/constants/color_constants.dart';

// class PorterDashboard extends StatelessWidget {
//   const PorterDashboard({super.key});

//   // Dummy address – baad mein Provider se le sakte ho
//   final String currentAddress =
//       "Delhi Apollo Premises, Vijay Nagar, 16 Rithala Lok Colony, Begumpur, Delhi, 110086";

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 10),

//           // Pick up from location card
//           _pickupLocationCard(),

//           const SizedBox(height: 20),

//           // Vehicle Selection: Truck, Bike, Car
//           _vehicleSelection(context),

//           const SizedBox(height: 30),

//           // Porter Rewards Banner
//           _rewardsBanner(),

//           const SizedBox(height: 30),

//           // Announcements Section
//           _announcementsSection(context),

//           const SizedBox(height: 30),

//           // Orders Tabs: Active, Complete, Inbox
//           _ordersSection(context),

//           const SizedBox(height: 100), // Bottom padding for scroll
//         ],
//       ),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────
//   // 1. Pick up Location Card
//   // ─────────────────────────────────────────────────────────────
//   Widget _pickupLocationCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: AppColors.porterPrimaryLight.withOpacity(0.3)),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(Icons.location_on, color: AppColors.porterPrimary, size: 28),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Pick up from",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   currentAddress,
//                   style: TextStyle(fontSize: 14, color: AppColors.textLight),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────
//   // 2. Vehicle Selection
//   // ─────────────────────────────────────────────────────────────
//   Widget _vehicleSelection(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _vehicleOption(context, Icons.local_shipping, "Truck", "truck"),
//         _vehicleOption(context, Icons.two_wheeler, "Bike", "bike"),
//         _vehicleOption(context, Icons.directions_car, "Car", "car"),
//       ],
//     );
//   }

//   Widget _vehicleOption(BuildContext context, IconData icon, String label, String routeParam) {
//     return GestureDetector(
//       onTap: () {
//         context.go('${AppConstants.routePorterSearch}/$routeParam');
//       },
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(22),
//             decoration: BoxDecoration(
//               color: AppColors.porterPrimary.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, size: 42, color: AppColors.porterPrimary),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             label,
//             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
//           ),
//         ],
//       ),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────
//   // 3. Porter Rewards Banner
//   // ─────────────────────────────────────────────────────────────
//   Widget _rewardsBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: AppColors.porterPrimary,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.monetization_on, color: Colors.amber, size: 44),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Explore Porter Rewards",
//                 style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 "Earn 2 coins for every ₹100 spent",
//                 style: TextStyle(color: Colors.white70, fontSize: 14),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // ─────────────────────────────────────────────────────────────
//   // 4. Announcements
//   // ─────────────────────────────────────────────────────────────
//   Widget _announcementsSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Announcements",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
//             ),
//             TextButton(
//               onPressed: () {},
//               child: Text("View all", style: TextStyle(color: AppColors.porterPrimary)),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: AppColors.grey100,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.campaign, color: AppColors.porterPrimary, size: 40),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Introducing Porter Enterprise",
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "Business logistics made simple & affordable",
//                       style: TextStyle(color: AppColors.textLight, fontSize: 13),
//                     ),
//                   ],
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Text("View", style: TextStyle(color: AppColors.porterPrimary)),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ─────────────────────────────────────────────────────────────
//   // 5. Orders Section with Tabs
//   // ─────────────────────────────────────────────────────────────
//   Widget _ordersSection(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Orders",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
//           ),
//           const SizedBox(height: 12),
//           TabBar(
//             labelColor: AppColors.porterPrimary,
//             unselectedLabelColor: AppColors.textLight,
//             indicatorColor: AppColors.porterPrimary,
//             labelStyle: const TextStyle(fontWeight: FontWeight.w600),
//             tabs: const [
//               Tab(text: "Active"),
//               Tab(text: "Complete"),
//               Tab(text: "Inbox"),
//             ],
//           ),
//           const SizedBox(height: 20),
//           SizedBox(
//             height: 420,
//             child: TabBarView(
//               children: [
//                 // Active Orders
//                 ListView(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   children: [
//                     _orderOptionCard(
//                       title: "Deliver Now",
//                       subtitle:
//                           "We will assign a nearby 2-Wheeler to pick up and deliver as soon as possible",
//                       icon: Icons.access_time_filled,
//                       badge: null,
//                     ),
//                     const SizedBox(height: 16),
//                     _orderOptionCard(
//                       title: "By End of the day",
//                       subtitle:
//                           "Place your order by 4 PM → picked up by 6 PM → delivered by 9 PM. Save up to 40%",
//                       icon: Icons.calendar_today,
//                       badge: "Save 40%",
//                     ),
//                   ],
//                 ),

//                 // Completed Orders
//                 const Center(
//                   child: Text(
//                     "No completed orders",
//                     style: TextStyle(color: Colors.grey, fontSize: 16),
//                   ),
//                 ),

//                 // Inbox
//                 const Center(
//                   child: Text(
//                     "No new messages",
//                     style: TextStyle(color: Colors.grey, fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _orderOptionCard({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     String? badge,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: AppColors.porterPrimaryLight.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.porterPrimaryLight.withOpacity(0.2)),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 52, color: AppColors.porterPrimary),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (badge != null)
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     margin: const EdgeInsets.only(bottom: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       badge,
//                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
//                     ),
//                   ),
//                 Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                 const SizedBox(height: 8),
//                 Text(
//                   subtitle,
//                   style: TextStyle(color: AppColors.textLight, fontSize: 13.5, height: 1.4),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// porter_dashboard.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/app_constants.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:lottie/lottie.dart'; // Add this import for Lottie animation

class PorterDashboard extends StatelessWidget {
  const PorterDashboard({super.key});
  // Dummy address – baad mein Provider se le sakte ho
  final String currentAddress =
      "Delhi Apollo Premises, Vijay Nagar, 16 Rithala Lok Colony, Begumpur, Delhi, 110086";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Lottie Animation - Added before Pickup Location Card
          _lottieAnimation(),
          const SizedBox(height: 20), // Extra spacing after animation
          // Pick up from location card
          _pickupLocationCard(context),
          const SizedBox(height: 20),
          // Vehicle Selection: Truck, Bike, Car
          _vehicleSelection(context),
          const SizedBox(height: 30),
          // Porter Rewards Banner
          _rewardsBanner(context),
          const SizedBox(height: 30),
          // Announcements Section
          _announcementsSection(context),
          const SizedBox(height: 30),
          // Orders Tabs: Active, Complete, Inbox
          _ordersSection(context),
          const SizedBox(height: 100), // Bottom padding for scroll
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // New Widget: Lottie Animation
  // ─────────────────────────────────────────────────────────────
  Widget _lottieAnimation() {
    return SizedBox(
      width: double.infinity,
      height: 200, // Adjust height as per your animation needs
      child: Lottie.asset(
        'assets/animations/porter.json', // Replace with your actual Lottie file path (e.g., delivery_animation.json)
        fit: BoxFit.cover,
        repeat: true, // Loop the animation
        onLoaded: (composition) {
          // Optional: Handle when animation loads
        },
        errorBuilder: (context, error, stackTrace) {
          // Fallback if Lottie file not found (use the static image as backup)
          return Image.asset(
            'assets/images/delivery_scene.png', // Replace with path to your static image (the one you shared)
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.local_shipping, size: 100, color: Colors.grey);
            },
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 1. Pick up Location Card
  // ─────────────────────────────────────────────────────────────
  Widget _pickupLocationCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.porterPrimaryLight.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(color: theme.colorScheme.outline.withOpacity(0.1), blurRadius: 10)
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on, color: AppColors.porterPrimary, size: 28),
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
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentAddress,
                  style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurfaceVariant),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // ─────────────────────────────────────────────────────────────
  // 2. Vehicle Selection
  // ─────────────────────────────────────────────────────────────
  // ─────────────────────────────────────────────────────────────
  // 2. Vehicle Selection - Horizontal Scrollable with Asset Images
  // ─────────────────────────────────────────────────────────────
  Widget _vehicleSelection(BuildContext context) {
    final List<Map<String, String>> vehicles = [
      {"label": "Bike",        "image": "assets/images/vehicles/eicher_truck.jpg",        "route": "bike"},
      {"label": "3 Wheeler",   "image": "assets/images/vehicles/concret_truck.jpg",    "route": "3wheeler"},
      {"label": "Mini Truck",  "image": "assets/images/vehicles/heavy_pickup.jpg",  "route": "mini"},
      {"label": "Tata Ace",    "image": "assets/images/vehicles/pickup_truck.jpg",    "route": "tata-ace"},
      {"label": "Pickup 8ft",  "image": "assets/images/vehicles/suzuki_pickup.jpg",  "route": "pickup"},
      {"label": "Truck 14ft",  "image": "assets/images/vehicles/bolero_pickup.jpg",  "route": "truck"},
      {"label": "Truck 17ft",  "image": "assets/images/vehicles/pickup_man.jpg",  "route": "truck-large"},
      {"label": "Loading Van", "image": "assets/images/vehicles/pickup_van.jpg", "route": "van"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            "Choose Vehicle",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 130, // Circle + label ke liye enough height
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 4 : 12,
                  right: index == vehicles.length - 1 ? 4 : 0,
                ),
                child: _vehicleOptionWithImage(
                  context,
                  imagePath: vehicle["image"]!,
                  label: vehicle["label"]!,
                  routeParam: vehicle["route"]!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget _vehicleOptionWithImage(
  //   BuildContext context, {
  //   required String imagePath,
  //   required String label,
  //   required String routeParam,
  // }) {
  //   final theme = Theme.of(context);
  //   return GestureDetector(
  //     onTap: () {
  //       context.go('${AppConstants.routePorterSearch}/$routeParam');
  //     },
  //     child: Column(
  //       children: [
  //         Container(
  //           width: 82,
  //           height: 82,
  //           padding: const EdgeInsets.all(14),
  //           decoration: BoxDecoration(
  //             color: AppColors.porterPrimary.withOpacity(0.1),
  //             shape: BoxShape.circle,
  //             border: Border.all(
  //               color: AppColors.porterPrimary.withOpacity(0.3),
  //               width: 2,
  //             ),
  //           ),
  //           child: Image.asset(
  //             imagePath,
  //             fit: BoxFit.contain,
  //             errorBuilder: (context, error, stackTrace) {
  //               // Agar image nahi mili to fallback icon
  //               return Icon(
  //                 Icons.local_shipping,
  //                 size: 40,
  //                 color: AppColors.porterPrimary,
  //               );
  //             },
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             fontSize: 13,
  //             color: theme.colorScheme.onBackground,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //       ],
  //     ),
  //   );
  // } 

  Widget _vehicleOptionWithImage(
  BuildContext context, {
  required String imagePath,
  required String label,
  required String routeParam,
}) {
  final theme = Theme.of(context);
  return GestureDetector(
    onTap: () {
      context.go('${AppConstants.routePorterSearch}/$routeParam');
    },
    child: Column(
      children: [
        Container(
          width: 86,
          height: 86,
          decoration: BoxDecoration(
            color: AppColors.porterPrimary.withOpacity(0.1),
            shape: BoxShape.circle,
            // border: Border.all(
            //   color: AppColors.porterPrimary.withOpacity(0.3),
            //   width: 1,
            // ),
          ),
          child: ClipOval(                       // Ye sabse important hai!
            child: Image.asset(
              imagePath,
              // width: 86,
              // height: 86 ,
              fit: BoxFit.cover,                  // contain se cover karo
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.local_shipping,
                  size: 40,
                  color: AppColors.porterPrimary,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
  //
  // // ─────────────────────────────────────────────────────────────
  // 3. Porter Rewards Banner
  // ─────────────────────────────────────────────────────────────
  Widget _rewardsBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.porterPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.monetization_on, color: Colors.amber, size: 44),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore Porter Rewards",
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "Earn 2 coins for every ₹100 spent",
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // ─────────────────────────────────────────────────────────────
  // 4. Announcements
  // ─────────────────────────────────────────────────────────────
  Widget _announcementsSection(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Announcements",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onBackground),
            ),
            TextButton(
              onPressed: () {},
              child: Text("View all", style: TextStyle(color: AppColors.porterPrimary)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.campaign, color: AppColors.porterPrimary, size: 40),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Introducing Porter Enterprise",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: theme.colorScheme.onBackground),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Business logistics made simple & affordable",
                      style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 13),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text("View", style: TextStyle(color: AppColors.porterPrimary)),
              ),
            ],
          ),
        ),
      ],
    );
  }
  // ─────────────────────────────────────────────────────────────
  // 5. Orders Section with Tabs
  // ─────────────────────────────────────────────────────────────
  Widget _ordersSection(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Orders",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onBackground),
          ),
          const SizedBox(height: 12),
          TabBar(
            labelColor: AppColors.porterPrimary,
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
            indicatorColor: AppColors.porterPrimary,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: "Active"),
              Tab(text: "Complete"),
              Tab(text: "Inbox"),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 420,
            child: TabBarView(
              children: [
                // Active Orders
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    _orderOptionCard(context,
                      title: "Deliver Now",
                      subtitle:
                          "We will assign a nearby 2-Wheeler to pick up and deliver as soon as possible",
                      icon: Icons.access_time_filled,
                      badge: null,
                    ),
                    const SizedBox(height: 16),
                    _orderOptionCard(context,
                      title: "By End of the day",
                      subtitle:
                          "Place your order by 4 PM → picked up by 6 PM → delivered by 9 PM. Save up to 40%",
                      icon: Icons.calendar_today,
                      badge: "Save 40%",
                    ),
                  ],
                ),
                // Completed Orders
                Center(
                  child: Text(
                    "No completed orders",
                    style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 16),
                  ),
                ),
                // Inbox
                Center(
                  child: Text(
                    "No new messages",
                    style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _orderOptionCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    String? badge,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.porterPrimaryLight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.porterPrimaryLight.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 52, color: AppColors.porterPrimary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: theme.colorScheme.onBackground)),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 13.5, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}