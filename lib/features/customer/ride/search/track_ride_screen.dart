// // track_ride_screen.dart
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
// import 'package:lottie/lottie.dart';
// import 'package:tryde_partner/services/google_maps_service.dart';
// import '../../../../core/constants/color_constants.dart';

// class TrackRideScreen extends StatefulWidget {
//   final gmaps.LatLng pickupLatLng;
//   final gmaps.LatLng destinationLatLng;
//   final String pickupAddress;
//   final String destinationAddress;
//   final String driverName;
//   final String vehicleDetails;
//   final String vehicleNumber;

//   const TrackRideScreen({
//     super.key,
//     required this.pickupLatLng,
//     required this.destinationLatLng,
//     required this.pickupAddress,
//     required this.destinationAddress,
//     this.driverName = "Akash Raghu",
//     this.vehicleDetails = "Hero Passion Pro • Dark Grey",
//     this.vehicleNumber = "MP13 DR 3986",
//   });

//   @override
//   State<TrackRideScreen> createState() => _TrackRideScreenState();
// }

// class _TrackRideScreenState extends State<TrackRideScreen>
//     with SingleTickerProviderStateMixin {
//   gmaps.GoogleMapController? _mapController;
//   Set<gmaps.Marker> _markers = {};        // <-- YEH THA DECLARED
//   Set<gmaps.Polyline> _polylines = {};
//   Timer? _locationTimer;

//   gmaps.LatLng _driverCurrentPosition = const gmaps.LatLng(22.7196, 75.8577);

//   late AnimationController _pulseController;

//   @override
//   void initState() {
//     super.initState();
//     _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))
//       ..repeat();
//     _setupMap();
//     _startDriverMovementSimulation();
//   }

//   Future<void> _setupMap() async {
//     // Clear previous
//     _markers.clear();

//     // Pickup Marker
//     _markers.add(
//       gmaps.Marker(
//       markerId: const gmaps.MarkerId('pickup'),
//       position: widget.pickupLatLng,
//       icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueGreen),
//       infoWindow: const gmaps.InfoWindow(title: "Pickup"),
//     ),
//     );

//     // Destination Marker
//     _markers.add(
//       gmaps.Marker(
//       markerId: const gmaps.MarkerId('destination'),
//       position: widget.destinationLatLng,
//       icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueRed),
//       infoWindow: const gmaps.InfoWindow(title: "Drop"),
//     ),
//     );

//     // Driver Marker
//     _markers.add(
//       gmaps.Marker(
//       markerId: const gmaps.MarkerId('driver'),
//       position: _driverCurrentPosition,
//       icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueOrange),
//       rotation: 0, // Will be updated dynamically
//       anchor: const Offset(0.5, 0.5),
//       zIndex: 10,
//     ),
//     );

//     // Route Polyline
//     try {
//       final routePoints = await GoogleMapsService.getSimpleRoute(
//         widget.pickupLatLng,
//         widget.destinationLatLng,
//       );

//       _polylines.clear();
//       _polylines.add(
//         gmaps.Polyline(
//           polylineId: const gmaps.PolylineId('route'),
//           points: routePoints,
//           color: AppColors.ridePrimary,
//           width: 6,
//           patterns: [gmaps.PatternItem.dash(20), gmaps.PatternItem.gap(10)],
//         ),
//       );
//     } catch (e) {
//       debugPrint("Route error: $e");
//     }

//     if (mounted) setState(() {});
//     _moveCameraToRoute();
//   }

//   void _moveCameraToRoute() {
//     if (_mapController == null) return;

//     final bounds = gmaps.LatLngBounds(
//       southwest: gmaps.LatLng(
//         widget.pickupLatLng.latitude < widget.destinationLatLng.latitude
//             ? widget.pickupLatLng.latitude
//             : widget.destinationLatLng.latitude,
//         widget.pickupLatLng.longitude < widget.destinationLatLng.longitude
//             ? widget.pickupLatLng.longitude
//             : widget.destinationLatLng.longitude,
//       ),
//       northeast: gmaps.LatLng(
//         widget.pickupLatLng.latitude > widget.destinationLatLng.latitude
//             ? widget.pickupLatLng.latitude
//             : widget.destinationLatLng.latitude,
//         widget.pickupLatLng.longitude > widget.destinationLatLng.longitude
//             ? widget.pickupLatLng.longitude
//             : widget.destinationLatLng.longitude,
//       ),
//     );

//     _mapController!.animateCamera(gmaps.CameraUpdate.newLatLngBounds(bounds, 100));
//   }

//   void _startDriverMovementSimulation() {
//     _locationTimer = Timer.periodic(const Duration(seconds: 3), (_) {
//       setState(() {
//         // Move driver slightly towards destination
//         double latDiff = (widget.destinationLatLng.latitude - widget.pickupLatLng.latitude) * 0.008;
//         double lngDiff = (widget.destinationLatLng.longitude - widget.pickupLatLng.longitude) * 0.008;

//         _driverCurrentPosition = gmaps.LatLng(
//           _driverCurrentPosition.latitude + latDiff,
//           _driverCurrentPosition.longitude + lngDiff,
//         );

//         // Update driver marker only
//         _markers.removeWhere((m) => m.markerId.value == 'driver');
//         _markers.add(
//           gmaps.Marker(
//             markerId: const gmaps.MarkerId('driver'),
//             position: _driverCurrentPosition,
//             icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueOrange),
//             rotation: _calculateBearing(), // Realistic rotation
//             anchor: const Offset(0.5, 0.5),
//             zIndex: 10,
//           ),
//         );
//       });

//       // Follow driver smoothly
//       _mapController?.animateCamera(
//         gmaps.CameraUpdate.newCameraPosition(
//           gmaps.CameraPosition(
//             target: _driverCurrentPosition,
//             zoom: 16.5,
//             tilt: 60,
//           ),
//         ),
//       );
//     });
//   }

//   // Calculate bearing for realistic car rotation
//   double _calculateBearing() {
//     // Simple bearing calculation (you can improve this)
//     return (_driverCurrentPosition.latitude > widget.pickupLatLng.latitude ? 45 : 225);
//   }

//   @override
//   void dispose() {
//     _locationTimer?.cancel();
//     _pulseController.dispose();
//     _mapController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           gmaps.GoogleMap(
//             initialCameraPosition: gmaps.CameraPosition(target: widget.pickupLatLng, zoom: 15),
//             onMapCreated: (controller) => _mapController = controller,
//             markers: _markers,        // <-- Ab sahi variable use ho raha hai
//             polylines: _polylines,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: false,
//             tiltGesturesEnabled: true,
//           ),

//           // Back Button
//           const SafeArea(
//             child: Padding(
//               padding: EdgeInsets.all(12.0),
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: BackButton(color: Colors.black),
//               ),
//             ),
//           ),

//           // Top Pulse Animation (Driver is coming)
//           Positioned(
//             top: MediaQuery.of(context).padding.top + 20,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Image.asset(
//                 'assets/images/vehicles/van.png',
//                 width: 140,
//                 // controller: _pulseController,
//                 // repeat: true,
//               ),
//             ),
//           ),

//           // Bottom Sheet
//           DraggableScrollableSheet(
//             initialChildSize: 0.35,
//             minChildSize: 0.25,
//             maxChildSize: 0.75,
//             builder: (context, scrollController) {
//               return Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                   boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15)],
//                 ),
//                 child: ListView(
//                   controller: scrollController,
//                   padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
//                   children: [
//                     Center(
//                       child: Container(
//                         width: 50,
//                         height: 5,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Driver Card
//                     Card(
//                       elevation: 2,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Row(
//                           children: [
//                             const CircleAvatar(
//                               radius: 34,
//                               backgroundImage: AssetImage('assets/images/rider_image.jpg'),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(widget.driverName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                                   Text(widget.vehicleDetails, style: TextStyle(color: Colors.grey[600])),
//                                   Text(widget.vehicleNumber, style: const TextStyle(fontWeight: FontWeight.w600)),
//                                   const SizedBox(height: 8),
//                                   Row(
//                                     children: const [
//                                       Icon(Icons.star, color: Colors.amber, size: 20),
//                                       SizedBox(width: 6),
//                                       Text('4.8', style: TextStyle(fontWeight: FontWeight.bold)),
//                                       Text(' • Arriving in 4 min', style: TextStyle(color: Colors.grey)),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Column(
//                               children: [
//                                 IconButton(icon: const Icon(Icons.message), color: AppColors.ridePrimary, onPressed: () {}),
//                                 IconButton(icon: const Icon(Icons.call), color: AppColors.ridePrimary, onPressed: () {}),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),

// _actionTile(Icons.local_offer, "Offers & Promo", () => showModalBottomSheet(
//   context: context,
//   isScrollControlled: true,
//   builder: (_) => const OffersPaymentBottomSheet(type: 'offers'),
// )),

// _actionTile(Icons.payment, "Payment • ₹29", () => showModalBottomSheet(  // Fare screenshot ke hisab se ₹29
//   context: context,
//   isScrollControlled: true,
//   builder: (_) => const OffersPaymentBottomSheet(type: 'payment'),
// )),
//                     _actionTile(Icons.share, "Share Trip Status", () {}),
//                     _actionTile(Icons.location_on, "Change Drop Location", () {
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Coming soon!")));
//                     }),
//                     _actionTile(Icons.cancel, "Cancel Ride", () {
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: const Text("Cancel Ride?"),
//                           actions: [
//                             TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
//                             TextButton(
//                               onPressed: () => context.go('/home'),
//                               child: const Text("Yes, Cancel", style: TextStyle(color: Colors.red)),
//                             ),
//                           ],
//                         ),
//                       );
//                     }, color: Colors.red.shade600),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _actionTile(IconData icon, String title, VoidCallback onTap, {Color? color}) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: ListTile(
//         leading: Icon(icon, color: color ?? AppColors.ridePrimary),
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: onTap,
//       ),
//     );
//   }
// }

// // track_ride_screen.dart ke end mein add karo

// class OffersPaymentBottomSheet extends StatelessWidget {
//   final String type; // 'offers' ya 'payment'

//   const OffersPaymentBottomSheet({super.key, required this.type});

//   @override
//   Widget build(BuildContext context) {
//     final bool isOffers = type == 'offers';

//     return DraggableScrollableSheet(
//       initialChildSize: 0.9,
//       minChildSize: 0.7,
//       maxChildSize: 0.95,
//       expand: false,
//       builder: (context, scrollController) {
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: SingleChildScrollView(
//             controller: scrollController,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       width: 50,
//                       height: 5,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   Text(
//                     isOffers ? "Offers" : "Payments",
//                     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),

//                   if (isOffers) ...[
//                     // Rapido Coins
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text("Use Rapido Coins", style: TextStyle(fontWeight: FontWeight.w600)),
//                           Row(
//                             children: const [
//                               Text("0", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                               SizedBox(width: 8),
//                               Icon(Icons.currency_rupee, color: Colors.amber),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text("You don't have any coins currently.", style: TextStyle(color: Colors.grey)),

//                     const SizedBox(height: 24),
//                     const Text("Coupons", style: TextStyle(fontWeight: FontWeight.w600)),

//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: "Enter Coupon Code",
//                         suffixIcon: TextButton(onPressed: () {}, child: const Text("APPLY", style: TextStyle(color: Colors.blue))),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Coupon Card
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey[300]!),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text("RIDE BIKE30", style: TextStyle(fontWeight: FontWeight.bold)),
//                               ElevatedButton(onPressed: null, child: const Text("Apply")),
//                             ],
//                           ),
//                           const Text("Get 25% OFF and also get additional Cashback"),
//                           const SizedBox(height: 8),
//                           const Text("• Offer not applicable due to high demand.", style: TextStyle(color: Colors.red)),
//                           const Divider(),
//                           const Text("Save ₹6 on this ride & get 6 coins as cashback."),
//                         ],
//                       ),
//                     ),
//                   ],

//                   if (!isOffers) ...[
//                     // Payment Screen UI
//                     const Text("Total Fare", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     const Text("₹29", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),

//                     const SizedBox(height: 16),
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       color: Colors.blue[50],
//                       child: const Text("Cashback behind scratch card upto rs.25, assured rs.5 | min order value of rs.39 | once per month"),
//                     ),

//                     const SizedBox(height: 24),
//                     const Text("Pay by any UPI app", style: TextStyle(fontWeight: FontWeight.w600)),
//                     const SizedBox(height: 12),
//                     ListTile(
//                       leading: Image.asset('assets/images/gpay.png', width: 40), // agar asset ho to
//                       title: const Text("GPay"),
//                       trailing: Radio(value: true, groupValue: true, onChanged: (v) {}),
//                     ),

//                     const SizedBox(height: 24),
//                     const Text("Pay Later", style: TextStyle(fontWeight: FontWeight.w600)),
//                     ListTile(
//                       leading: const Icon(Icons.qr_code),
//                       title: const Text("Pay at drop"),
//                       subtitle: const Text("Go cashless, after ride pay by scanning QR code"),
//                       trailing: Radio(value: false, groupValue: true, onChanged: (v) {}),
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.link), label: const Text("Simpl"), style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan[50])),

//                     const SizedBox(height: 24),
//                     const Text("Others", style: TextStyle(fontWeight: FontWeight.w600)),
//                     ListTile(
//                       leading: const Icon(Icons.money),
//                       title: const Text("Cash"),
//                       trailing: Radio(value: true, groupValue: false, onChanged: (v) {}),
//                     ),
//                   ],

//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class OffersBottomSheet extends StatelessWidget {
//   const OffersBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text("Available Offers", style: Theme.of(context).textTheme.titleLarge),
//           const Divider(),
//           const ListTile(leading: Icon(Icons.local_offer, color: Colors.green), title: Text("FLAT50 – ₹50 off")),
//           const ListTile(leading: Icon(Icons.local_offer, color: Colors.green), title: Text("FIRST10 – 10% off")),
//           ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
//         ],
//       ),
//     );
//   }
// }


// track_ride_screen.dart (Improved and Connected)
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:lottie/lottie.dart';
import 'package:tryde_partner/services/google_maps_service.dart';
import '../../../../core/constants/color_constants.dart';

class TrackRideScreen extends StatefulWidget {
  final gmaps.LatLng pickupLatLng;
  final gmaps.LatLng destinationLatLng;
  final String pickupAddress;
  final String destinationAddress;
  final String driverName;
  final String vehicleDetails;
  final String vehicleNumber;

  const TrackRideScreen({
    super.key,
    required this.pickupLatLng,
    required this.destinationLatLng,
    required this.pickupAddress,
    required this.destinationAddress,
    this.driverName = "Akash Raghu",
    this.vehicleDetails = "Hero Passion Pro • Dark Grey",
    this.vehicleNumber = "MP13 DR 3986",
  });

  @override
  State<TrackRideScreen> createState() => _TrackRideScreenState();
}

class _TrackRideScreenState extends State<TrackRideScreen>
    with SingleTickerProviderStateMixin {
  gmaps.GoogleMapController? _mapController;
  Set<gmaps.Marker> _markers = {};
  Set<gmaps.Polyline> _polylines = {};
  Timer? _locationTimer;

  gmaps.LatLng _driverCurrentPosition = const gmaps.LatLng(22.7196, 75.8577);

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
    _setupMap();
    _startDriverMovementSimulation();
  }

  Future<void> _setupMap() async {
    // Clear previous
    _markers.clear();

    // Pickup Marker
    _markers.add(
      gmaps.Marker(
        markerId: const gmaps.MarkerId('pickup'),
        position: widget.pickupLatLng,
        icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueGreen),
        infoWindow: const gmaps.InfoWindow(title: "Pickup"),
      ),
    );

    // Destination Marker
    _markers.add(
      gmaps.Marker(
        markerId: const gmaps.MarkerId('destination'),
        position: widget.destinationLatLng,
        icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueRed),
        infoWindow: const gmaps.InfoWindow(title: "Drop"),
      ),
    );

    // Driver Marker
    _markers.add(
      gmaps.Marker(
        markerId: const gmaps.MarkerId('driver'),
        position: _driverCurrentPosition,
        icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueOrange),
        rotation: 0, // Will be updated dynamically
        anchor: const Offset(0.5, 0.5),
        zIndex: 10,
      ),
    );

    // Route Polyline
    try {
      final routePoints = await GoogleMapsService.getSimpleRoute(
        widget.pickupLatLng,
        widget.destinationLatLng,
      );

      _polylines.clear();
      _polylines.add(
        gmaps.Polyline(
          polylineId: const gmaps.PolylineId('route'),
          points: routePoints,
          color: AppColors.ridePrimary,
          width: 6,
          patterns: [gmaps.PatternItem.dash(20), gmaps.PatternItem.gap(10)],
        ),
      );
    } catch (e) {
      debugPrint("Route error: $e");
    }

    if (mounted) setState(() {});
    _moveCameraToRoute();
  }

  void _moveCameraToRoute() {
    if (_mapController == null) return;

    final bounds = gmaps.LatLngBounds(
      southwest: gmaps.LatLng(
        widget.pickupLatLng.latitude < widget.destinationLatLng.latitude
            ? widget.pickupLatLng.latitude
            : widget.destinationLatLng.latitude,
        widget.pickupLatLng.longitude < widget.destinationLatLng.longitude
            ? widget.pickupLatLng.longitude
            : widget.destinationLatLng.longitude,
      ),
      northeast: gmaps.LatLng(
        widget.pickupLatLng.latitude > widget.destinationLatLng.latitude
            ? widget.pickupLatLng.latitude
            : widget.destinationLatLng.latitude,
        widget.pickupLatLng.longitude > widget.destinationLatLng.longitude
            ? widget.pickupLatLng.longitude
            : widget.destinationLatLng.longitude,
      ),
    );

    _mapController!.animateCamera(gmaps.CameraUpdate.newLatLngBounds(bounds, 100));
  }

  void _startDriverMovementSimulation() {
    _locationTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      setState(() {
        // Move driver slightly towards destination
        double latDiff = (widget.destinationLatLng.latitude - widget.pickupLatLng.latitude) * 0.008;
        double lngDiff = (widget.destinationLatLng.longitude - widget.pickupLatLng.longitude) * 0.008;

        _driverCurrentPosition = gmaps.LatLng(
          _driverCurrentPosition.latitude + latDiff,
          _driverCurrentPosition.longitude + lngDiff,
        );

        // Update driver marker only
        _markers.removeWhere((m) => m.markerId.value == 'driver');
        _markers.add(
          gmaps.Marker(
            markerId: const gmaps.MarkerId('driver'),
            position: _driverCurrentPosition,
            icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueOrange),
            rotation: _calculateBearing(), // Realistic rotation
            anchor: const Offset(0.5, 0.5),
            zIndex: 10,
          ),
        );
      });

      // Follow driver smoothly
      _mapController?.animateCamera(
        gmaps.CameraUpdate.newCameraPosition(
          gmaps.CameraPosition(
            target: _driverCurrentPosition,
            zoom: 16.5,
            tilt: 60,
          ),
        ),
      );
    });
  }

  // Calculate bearing for realistic car rotation
  double _calculateBearing() {
    // Simple bearing calculation (you can improve this)
    return (_driverCurrentPosition.latitude > widget.pickupLatLng.latitude ? 45 : 225);
  }

  @override
  void dispose() {
    _locationTimer?.cancel();
    _pulseController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          gmaps.GoogleMap(
            initialCameraPosition: gmaps.CameraPosition(target: widget.pickupLatLng, zoom: 15),
            onMapCreated: (controller) => _mapController = controller,
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            tiltGesturesEnabled: true,
          ),

          // Back Button
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: BackButton(color: Colors.black),
              ),
            ),
          ),

          // Top Pulse Animation (Driver is coming)
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 0,
            right: 0,
            child: Center(
              // child: Image.asset(
              //   'assets/images/vehicles/van.png',
              //   width: 140,
              // ),
            ),
          ),

          // Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.25,
            maxChildSize: 0.75,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15)],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Driver Card
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 34,
                              backgroundImage: AssetImage('assets/images/rider_image.jpg'),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.driverName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text(widget.vehicleDetails, style: TextStyle(color: Colors.grey[600])),
                                  Text(widget.vehicleNumber, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: const [
                                      Icon(Icons.star, color: Colors.amber, size: 20),
                                      SizedBox(width: 6),
                                      Text('4.8', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(' • Arriving in 4 min', style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(icon: const Icon(Icons.message), color: AppColors.ridePrimary, onPressed: () {}),
                                IconButton(icon: const Icon(Icons.call), color: AppColors.ridePrimary, onPressed: () {}),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    _actionTile(Icons.local_offer, "Offers & Promo", () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => const OffersPaymentBottomSheet(type: 'offers'),
                    )),

                    _actionTile(Icons.payment, "Payment • ₹39", () => showModalBottomSheet(  // Updated fare to ₹39
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => const OffersPaymentBottomSheet(type: 'payment'),
                    )),

                    _actionTile(Icons.share, "Share Trip Status", () {}),
                    _actionTile(Icons.location_on, "Change Drop Location", () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Coming soon!")));
                    }),
                    _actionTile(Icons.cancel, "Cancel Ride", () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Cancel Ride?"),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
                            TextButton(
                              onPressed: () => context.go('/home'),
                              child: const Text("Yes, Cancel", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    }, color: Colors.red.shade600),

                    // New: End Trip Button (Dummy - Simulates ride end and opens payment)
                    _actionTile(Icons.stop_circle, "End Trip", () {
                      // Simulate ride end: Stop timer, open payment bottom sheet directly
                      _locationTimer?.cancel();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => const OffersPaymentBottomSheet(type: 'payment', isEndTrip: true),  // Pass flag for end trip mode
                      );
                    }, color: Colors.green.shade600),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _actionTile(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColors.ridePrimary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

// Improved OffersPaymentBottomSheet with fare breakdown and connection to success/feedback
class OffersPaymentBottomSheet extends StatelessWidget {
  final String type; // 'offers' or 'payment'
  final bool isEndTrip; // New flag to show as payment confirmation after end trip

  const OffersPaymentBottomSheet({
    super.key,
    required this.type,
    this.isEndTrip = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOffers = type == 'offers';
    final bool isPayment = type == 'payment';

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.7,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    isOffers ? "Offers" : (isEndTrip ? "Confirm Payment" : "Payments"),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  if (isOffers) ...[
                    // Rapido Coins
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Use Rapido Coins", style: TextStyle(fontWeight: FontWeight.w600)),
                          Row(
                            children: const [
                              Text("0", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.currency_rupee, color: Colors.amber),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text("You don't have any coins currently.", style: TextStyle(color: Colors.grey)),

                    const SizedBox(height: 24),
                    const Text("Coupons", style: TextStyle(fontWeight: FontWeight.w600)),

                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Coupon Code",
                        suffixIcon: TextButton(onPressed: () {}, child: const Text("APPLY", style: TextStyle(color: Colors.blue))),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Coupon Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("RIDE BIKE30", style: TextStyle(fontWeight: FontWeight.bold)),
                              ElevatedButton(onPressed: null, child: const Text("Apply")),
                            ],
                          ),
                          const Text("Get 25% OFF and also get additional Cashback"),
                          const SizedBox(height: 8),
                          const Text("• Offer not applicable due to high demand.", style: TextStyle(color: Colors.red)),
                          const Divider(),
                          const Text("Save ₹6 on this ride & get 6 coins as cashback."),
                        ],
                      ),
                    ),
                  ],

                  if (isPayment || isEndTrip) ...[
                    // Payment Screen UI with Fare Breakdown
                    const Text("Fare Breakdown", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            _FareItem("Base Fare", "₹20"),
                            _FareItem("Distance (5 km)", "₹10"),
                            _FareItem("Time (10 min)", "₹5"),
                            _FareItem("Taxes & Fees", "₹4"),
                            Divider(),
                            _FareItem("Total Payable", "₹39", isBold: true),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.blue[50],
                      child: const Text("Cashback behind scratch card upto rs.25, assured rs.5 | min order value of rs.39 | once per month"),
                    ),

                    const SizedBox(height: 24),
                    const Text("Pay by any UPI app", style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: Image.asset('assets/icons/google_icon.png', width: 40), // Assume asset exists
                      title: const Text("GPay"),
                      trailing: Radio(value: true, groupValue: true, onChanged: (v) {}),
                    ),

                    const SizedBox(height: 24),
                    const Text("Pay Later", style: TextStyle(fontWeight: FontWeight.w600)),
                    ListTile(
                      leading: const Icon(Icons.qr_code),
                      title: const Text("Pay at drop"),
                      subtitle: const Text("Go cashless, after ride pay by scanning QR code"),
                      trailing: Radio(value: false, groupValue: true, onChanged: (v) {}),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.link), label: const Text("Simpl"), style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan[50])),

                    const SizedBox(height: 24),
                    const Text("Others", style: TextStyle(fontWeight: FontWeight.w600)),
                    ListTile(
                      leading: const Icon(Icons.money),
                      title: const Text("Cash"),
                      trailing: Radio(value: true, groupValue: false, onChanged: (v) {}),
                    ),

                    const SizedBox(height: 32),

                    // Pay Button - Dummy payment simulation
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Close bottom sheet
                          context.push('/payment-success'); // Go to success screen
                        },
                        child: const Text("Pay ₹39 Now", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Helper for Fare Items
class _FareItem extends StatelessWidget {
  final String label;
  final String amount;
  final bool isBold;

  const _FareItem(this.label, this.amount, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(amount, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}