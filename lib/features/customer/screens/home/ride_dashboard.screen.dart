// // // ride_dashboard.dart
// // import 'package:flutter/material.dart';
// // import 'package:tryde_partner/core/constants/color_constants.dart';

// // class RideDashboard extends StatelessWidget {
// //   const RideDashboard({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.all(16),
// //       child: Column(
// //         children: [
// //           _rideOption("Auto", "₹89 - ₹129", Icons.directions_car),
// //           const SizedBox(height: 16),
// //           _rideOption("Mini", "₹129 - ₹179", Icons.local_taxi),
// //           const SizedBox(height: 16),
// //           _rideOption("Prime Sedan", "₹199 - ₹249", Icons.car_repair),
// //           const SizedBox(height: 30),
// //           Container(
// //             padding: EdgeInsets.all(20),
// //             decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
// //             child: Text("Where to?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _rideOption(String title, String price, IconData icon) {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
// //       child: Row(
// //         children: [
// //           Icon(icon, size: 40, color: AppColors.primary),
// //           SizedBox(width: 16),
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// //               Text(price, style: TextStyle(color: AppColors.textLight)),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// // ride_dashboard.dart
// import 'package:flutter/material.dart';
// import 'package:tryde_partner/core/constants/color_constants.dart';
// class RideDashboard extends StatelessWidget {
//   const RideDashboard({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           _rideOption(context, "Auto", "₹89 - ₹129", Icons.directions_car),
//           const SizedBox(height: 16),
//           _rideOption(context, "Mini", "₹129 - ₹179", Icons.local_taxi),
//           const SizedBox(height: 16),
//           _rideOption(context, "Prime Sedan", "₹199 - ₹249", Icons.car_repair),
//           const SizedBox(height: 30),
//           Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(color: AppColors.ridePrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
//             child: Text("Where to?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.colorScheme.onBackground)),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _rideOption(BuildContext context, String title, String price, IconData icon) {
//     final theme = Theme.of(context);
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(color: theme.colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(16)),
//       child: Row(
//         children: [
//           Icon(icon, size: 40, color: AppColors.ridePrimary),
//           SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.colorScheme.onBackground)),
//               Text(price, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// ride_dashboard.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class RideDashboard extends StatelessWidget {
  const RideDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field-like UI
          GestureDetector(
            onTap: () => context.push('/ride'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.ridePrimary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: AppColors.ridePrimary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Where are you going?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ridePrimary,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.ridePrimary.withOpacity(0.6),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Recent History Section
          Text(
            "Recent",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          _recentRideCard(
            context,
            "Home to Office",
            "Today, 10:30 AM",
            Icons.location_on,
          ),
          const SizedBox(height: 12),
          _recentRideCard(
            context,
            "Office to Mall",
            "Yesterday, 6:45 PM",
            Icons.location_on,
          ),
          const SizedBox(height: 24),

          // Ride Options Section
          Text(
            "Ride Options",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          // First row: 2 options
          Row(
            children: [
              Expanded(child: _rideOptionSmall(context, "Auto", "₹89 - ₹129", Icons.directions_car)),
              const SizedBox(width: 12),
              Expanded(child: _rideOptionSmall(context, "Mini Cab", "₹129 - ₹179", Icons.local_taxi)),
            ],
          ),
          const SizedBox(height: 12),
          // Second row: 2 options
          Row(
            children: [
              Expanded(child: _rideOptionSmall(context, "Bike Cab", "₹69 - ₹99", Icons.two_wheeler)),
              const SizedBox(width: 12),
              Expanded(child: _rideOptionSmall(context, "Premium Bike", "₹99 - ₹149", Icons.motorcycle)),
            ],
          ),
          const SizedBox(height: 12),
          // Third row: Single option
          _rideOptionSmall(context, "Premium", "₹199 - ₹249", Icons.car_repair),
        ],
      ),
    );
  }

  Widget _rideOptionSmall(BuildContext context, String title, String price, IconData icon) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => context.push('/ride'),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.ridePrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 24, color: AppColors.ridePrimary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    price,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentRideCard(BuildContext context, String destination, String time, IconData icon) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => context.push('/ride'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.ridePrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.history, color: AppColors.ridePrimary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.ridePrimary.withOpacity(0.7), size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destination,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: theme.colorScheme.onSurfaceVariant, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}