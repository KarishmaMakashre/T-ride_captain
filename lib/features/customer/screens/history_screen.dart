// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../core/constants/color_constants.dart';
// import '../../../core/constants/app_constants.dart';

// // Sample data for rides (replace with API data)
// List<Map<String, dynamic>> sampleRides = [
//   {
//     'id': 'DRI7074049349558',
//     'pickup': 'New Palasia',
//     'dropoff': 'Bangali Square',
//     'distance': '2.3 km',
//     'fare': '₹28.12',
//     'date': 'Dec 9, 2025 2:23 PM',
//     'status': 'Completed',
//     'vehicleType': 'Car',
//     'driverName': 'Akash Raghavanshi',
//     'driverPhoto': 'assets/images/rider_image.jpg',
//     'mapSnapshot': 'assets/images/map_placeholder.png', // Assume map image
//   },
//   {
//     'id': 'DRI7074049349559',
//     'pickup': 'Bangali Square',
//     'dropoff': 'Race Course Road',
//     'distance': '4.7 km',
//     'fare': '₹45.00',
//     'date': 'Dec 6, 2025 9:41 AM',
//     'status': 'Completed',
//     'vehicleType': 'Bike',
//     'driverName': 'Ravi Kumar',
//     'driverPhoto': 'assets/images/driver_placeholder2.png',
//     'mapSnapshot': 'assets/images/map_bike_placeholder.png',
//   },
//   // Add more sample rides as needed
// ];

// class HistoryScreen extends StatelessWidget {
//   const HistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         title: const Text('My Rides'),
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Search rides logic
//             },
//           ),
//         ],
//       ),
//       body: sampleRides.isEmpty
//           ? const Center(
//               child: Text(
//                 'No rides yet. Book your first ride!',
//                 style: TextStyle(fontSize: 16, color: AppColors.textLight),
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               itemCount: sampleRides.length,
//               itemBuilder: (context, index) {
//                 final ride = sampleRides[index];
//                 return RideCard(
//                   ride: ride,
//                   onTap: () {
//                     context.push(AppConstants.routeOverview);
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }

// class RideCard extends StatelessWidget {
//   final Map<String, dynamic> ride;
//   final VoidCallback onTap;

//   const RideCard({super.key, required this.ride, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     Color statusColor = ride['status'] == 'Completed'
//         ? Colors.green
//         : Colors.orange;
//     IconData statusIcon = ride['status'] == 'Completed'
//         ? Icons.check_circle
//         : Icons.schedule;

//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Ride ID and Status
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Ride ID: ${ride['id']}',
//                     style: TextStyle(fontSize: 12, color: AppColors.textLight),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: statusColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(statusIcon, color: statusColor, size: 16),
//                         const SizedBox(width: 4),
//                         Text(
//                           ride['status'],
//                           style: TextStyle(
//                             color: statusColor,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // Map Snapshot
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(
//                  AppConstants.mapImagePath,
//                   height: 120,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // Locations
//               Row(
//                 children: [
//                   Icon(Icons.location_on, color: Colors.green, size: 14),
//                   const SizedBox(width: 4),
//                   Expanded(
//                     child: Text(
//                       ride['pickup'],
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               Row(
//                 children: [
//                   Icon(Icons.location_on, color: Colors.red, size: 14),
//                   const SizedBox(width: 4),
//                   Expanded(
//                     child: Text(
//                       ride['dropoff'],
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),

//               // Distance, Date, Fare
//               Row(
//                 children: [
//                   Text(
//                     ride['distance'],
//                     style: TextStyle(fontSize: 12, color: AppColors.textLight),
//                   ),
//                   const Spacer(),
//                   Text(
//                     ride['date'],
//                     style: TextStyle(fontSize: 12, color: AppColors.textLight),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     ride['fare'],
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               // Driver Photo and Name
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundImage: AssetImage(ride['driverPhoto']),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           ride['driverName'],
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           ride['vehicleType'],
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: AppColors.textLight,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 16,
//                     color: AppColors.textLight,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/app_constants.dart';

// Sample Data (your own data kept same)
List<Map<String, dynamic>> sampleRides = [
  {
    'id': 'DRI7074049349558',
    'pickup': 'New Palasia',
    'dropoff': 'Bangali Square',
    'distance': '2.3 km',
    'fare': '₹28.12',
    'date': 'Dec 9, 2025 2:23 PM',
    'status': 'Completed',
    'vehicleType': 'Car',
    'driverName': 'Akash Raghavanshi',
    'driverPhoto': 'assets/images/rider_image.jpg',
    'mapSnapshot': 'assets/images/map_placeholder.png',
  },
  {
    'id': 'DRI7074049349559',
    'pickup': 'Bangali Square',
    'dropoff': 'Race Course Road',
    'distance': '4.7 km',
    'fare': '₹45.00',
    'date': 'Dec 6, 2025 9:41 AM',
    'status': 'Completed',
    'vehicleType': 'Bike',
    'driverName': 'Ravi Kumar',
    'driverPhoto': 'assets/images/driver_placeholder2.png',
    'mapSnapshot': 'assets/images/map_bike_placeholder.png',
  },
];

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          "Ride History",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 26),
            onPressed: () {},
          ),
        ],
      ),
      body: sampleRides.isEmpty
          ? const Center(
              child: Text(
                "No rides yet.\nBook your first ride!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textLight,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sampleRides.length,
              itemBuilder: (context, index) {
                final ride = sampleRides[index];
                return RideCard(
                  ride: ride,
                  onTap: () {
                    context.push(AppConstants.routeOverview);
                  },
                );
              },
            ),
    );
  }
}

class RideCard extends StatelessWidget {
  final Map<String, dynamic> ride;
  final VoidCallback onTap;

  const RideCard({super.key, required this.ride, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final statusColor =
        ride['status'] == "Completed" ? Colors.green : Colors.orange;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(
            color: Colors.black.withOpacity(0.04),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ride ID + Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ride ID: ${ride['id']}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle,
                          size: 16, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        ride['status'],
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // MAP BANNER
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
               AppConstants.mapImagePath,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 14),

            // Pickup & Drop
            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 16, color: Colors.green),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    ride['pickup'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.flag, size: 16, color: Colors.red),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    ride['dropoff'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // DISTANCE - DATE - FARE
            Row(
              children: [
                Text(
                  ride['distance'],
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textLight),
                ),
                const Spacer(),
                Text(
                  ride['date'],
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textLight),
                ),
                const SizedBox(width: 10),
                Text(
                  ride['fare'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // DRIVER DETAILS
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: AssetImage(ride['driverPhoto']),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ride['driverName'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      ride['vehicleType'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios,
                    size: 16, color: AppColors.textLight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

