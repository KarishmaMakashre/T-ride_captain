
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tryde_partner/services/google_maps_service.dart';
// import '../../../../core/constants/color_constants.dart';
// import '../../../../core/constants/app_constants.dart';

// class RideSearchResultScreen extends StatefulWidget {
//   final gmaps.LatLng currentLatLng;
//   final gmaps.LatLng destinationLatLng;
//   final String originAddress;
//   final String destinationAddress;
//   final String selectedRideType;
//   final String selectedPrice;
//   final Map<String, dynamic> selectedRideOption;

//   const RideSearchResultScreen({
//     super.key,
//     required this.currentLatLng,
//     required this.destinationLatLng,
//     required this.originAddress,
//     required this.destinationAddress,
//     required this.selectedRideType,
//     required this.selectedPrice,
//     required this.selectedRideOption,
//   });

//   @override
//   State<RideSearchResultScreen> createState() => _RideSearchResultScreenState();
// }

// class _RideSearchResultScreenState extends State<RideSearchResultScreen>
//     with SingleTickerProviderStateMixin {
//   gmaps.GoogleMapController? _mapController;
//   Set<gmaps.Marker> _markers = {};
//   Set<gmaps.Polyline> _polylines = {};
//   bool _isSearching = true;
//   int _currentTextIndex = 0;
//   Timer? _textTimer;
//   late AnimationController _animationController;

//   final List<String> _searchPhases = [
//     'Finding rider for you...',
//     '18 riders found',
//     'Waiting for their accept request...',
//   ];

//   bool _rideSharingEnabled = false;
//   String _rideSharingGender = 'both_mixed';
//   int _pickupMinutes = 2;

//   // Fixed OTP for demo (real app mein backend se aayega)
//   final String _displayedOtp = "4647";

//   // Driver phone number
//   final String _driverPhone = "+919644782290";

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 6));
//     _loadRideSharingPreferences();
//     _startSearchAnimation();
//   }

//   Future<void> _loadRideSharingPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _rideSharingEnabled = prefs.getBool('ride_sharing_enabled') ?? false;
//       _rideSharingGender = prefs.getString('ride_sharing_gender') ?? 'both_mixed';
//     });
//   }

//   void _initializeMap() async {
//     _markers = {
//       gmaps.Marker(
//         markerId: const gmaps.MarkerId('origin'),
//         position: widget.currentLatLng,
//         icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueGreen),
//       ),
//       gmaps.Marker(
//         markerId: const gmaps.MarkerId('destination'),
//         position: widget.destinationLatLng,
//         icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueBlue),
//       ),
//     };

//     try {
//       final route = await GoogleMapsService.getSimpleRoute(widget.currentLatLng, widget.destinationLatLng);
//       _polylines = {
//         gmaps.Polyline(
//           polylineId: const gmaps.PolylineId('route'),
//           points: route,
//           color: Colors.blue,
//           width: 5,
//         ),
//       };
//     } catch (e) {}

//     if (_mapController != null) {
//       final bounds = gmaps.LatLngBounds(
//         southwest: gmaps.LatLng(
//           widget.currentLatLng.latitude < widget.destinationLatLng.latitude ? widget.currentLatLng.latitude : widget.destinationLatLng.latitude,
//           widget.currentLatLng.longitude < widget.destinationLatLng.longitude ? widget.currentLatLng.longitude : widget.destinationLatLng.longitude,
//         ),
//         northeast: gmaps.LatLng(
//           widget.currentLatLng.latitude > widget.destinationLatLng.latitude ? widget.currentLatLng.latitude : widget.destinationLatLng.latitude,
//           widget.currentLatLng.longitude > widget.destinationLatLng.longitude ? widget.currentLatLng.longitude : widget.destinationLatLng.longitude,
//         ),
//       );
//       _mapController!.animateCamera(gmaps.CameraUpdate.newLatLngBounds(bounds, 80));
//     }
//     setState(() {});
//   }

//   void _startSearchAnimation() {
//     _animationController.forward();
//     _textTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
//       if (_currentTextIndex < _searchPhases.length - 1) {
//         setState(() => _currentTextIndex++);
//       } else {
//         timer.cancel();
//         setState(() {
//           _isSearching = false;
//           _initializeMap();
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _textTimer?.cancel();
//     _animationController.dispose();
//     _mapController?.dispose();
//     super.dispose();
//   }

//   void _centerMap() {
//     _mapController?.animateCamera(gmaps.CameraUpdate.newCameraPosition(
//       gmaps.CameraPosition(target: widget.currentLatLng, zoom: 15),
//     ));
//   }

//   // Direct navigate to Track Ride
//   void _goToTrackRide() {
//     context.pushNamed(
//       'track-ride',
//       extra: {
//         'currentLatLng': widget.currentLatLng,
//         'destinationLatLng': widget.destinationLatLng,
//         'originAddress': widget.originAddress,
//         'destinationAddress': widget.destinationAddress,
//       },
//     );
//   }

//   // Call & Message functions (url_launcher add karna padega real mein)
//   void _makeCall() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Calling $_driverPhone...")),
//     );
//     // await launchUrl(Uri(scheme: 'tel', path: _driverPhone));
//   }

//   void _sendMessage() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Opening messages to $_driverPhone")),
//     );
//     // await launchUrl(Uri(scheme: 'sms', path: _driverPhone));
//   }

//   @override
//   Widget build(BuildContext context) {
//     String genderLabel = _rideSharingGender == 'only_male'
//         ? 'Only Male'
//         : _rideSharingGender == 'only_female'
//             ? 'Only Female'
//             : 'Both (Mixed)';

//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: gmaps.GoogleMap(
//               initialCameraPosition: gmaps.CameraPosition(target: widget.currentLatLng, zoom: 15),
//               onMapCreated: (controller) {
//                 _mapController = controller;
//                 if (!_isSearching) _initializeMap();
//               },
//               markers: _markers,
//               polylines: _polylines,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               zoomControlsEnabled: false,
//             ),
//           ),

//           // Back Button
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 12.0, top: 8.0),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     shape: BoxShape.circle,
//                     boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
//                     onPressed: () => context.pop(),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Top-right buttons
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.only(right: 12.0, top: 8.0),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     _smallRoundButton(icon: Icons.warning_amber_rounded, bgColor: Colors.red, onTap: () {}),
//                     const SizedBox(height: 10),
//                     _smallRoundButton(icon: Icons.menu, bgColor: Colors.white, onTap: () => showModalBottomSheet(context: context, builder: (_) => _menuSheet())),
//                     const SizedBox(height: 10),
//                     _smallRoundButton(icon: Icons.my_location, bgColor: Colors.white, onTap: _centerMap),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Searching overlay
//           if (_isSearching) ...[
//             Positioned.fill(
//               child: Container(
//                 color: Colors.white.withOpacity(0.9),
//                 child: Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(
//                         width: 220,
//                         height: 220,
//                         child: Lottie.asset('assets/animations/Searching_radius.json', controller: _animationController,
//                           onLoaded: (composition) => _animationController.duration = composition.duration,
//                         ),
//                       ),
//                       const SizedBox(height: 18),
//                       AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 400),
//                         child: Text(_searchPhases[_currentTextIndex], key: ValueKey(_currentTextIndex),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.ridePrimary),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       const Text('Searching nearby riders...', style: TextStyle(color: Colors.black54)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],

//           // Bottom Sheet
//           DraggableScrollableSheet(
//             initialChildSize: 0.15,
//             minChildSize: 0.1,
//             maxChildSize: 0.7,
//             builder: (context, scrollController) {
//               return Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                   boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//                 ),
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   physics: const BouncingScrollPhysics(),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Center(child: Container(width: 40, height: 4, color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4))),
//                         const SizedBox(height: 16),

//                         // Pickup time + OTP Display
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text('Pickup in', style: TextStyle(fontWeight: FontWeight.w600)),
//                                 const SizedBox(height: 6),
//                                 Text('$_pickupMinutes min', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 // 4-digit OTP Box
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.ridePrimary,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Text(
//                                     _displayedOtp,
//                                     style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 6),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 16),

//                         // Addresses
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('From', style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
//                               const SizedBox(height: 6),
//                               Text(widget.originAddress, style: const TextStyle(fontWeight: FontWeight.w600)),
//                               const SizedBox(height: 10),
//                               Text('To', style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
//                               const SizedBox(height: 6),
//                               Text(widget.destinationAddress, style: const TextStyle(fontWeight: FontWeight.w600)),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 16),

//                         // Driver Card
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
//                           child: Row(
//                             children: [
//                               const CircleAvatar(radius: 26, backgroundImage: AssetImage('assets/images/rider_image.jpg')),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text('Akash Raghu', style: TextStyle(fontWeight: FontWeight.bold)),
//                                     const SizedBox(height: 4),
//                                     Text('MP13DR3986 • Dark Grey Hero Passion Pro', style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
//                                     const SizedBox(height: 6),
//                                     Row(
//                                       children: const [
//                                         Icon(Icons.star, color: Colors.amber, size: 16),
//                                         SizedBox(width: 4),
//                                         Text('4.8', style: TextStyle(fontWeight: FontWeight.bold)),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Column(
//                                 children: [
//                                   IconButton(onPressed: _sendMessage, icon: const Icon(Icons.message, color: Colors.blue)),
//                                   IconButton(onPressed: _makeCall, icon: const Icon(Icons.call, color: Colors.green)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 16),

//                         // Ride Sharing
//                         GestureDetector(
//                           onTap: () => context.push('/ride-sharing'),
//                           child: Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text('Ride Sharing', style: TextStyle(fontWeight: FontWeight.w600)),
//                                     const SizedBox(height: 6),
//                                     Text(_rideSharingEnabled ? 'On - $genderLabel' : 'Off - Solo Ride Only',
//                                         style: TextStyle(color: _rideSharingEnabled ? AppColors.ridePrimary : Colors.grey)),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(_rideSharingEnabled ? Icons.toggle_on : Icons.toggle_off,
//                                         color: _rideSharingEnabled ? AppColors.ridePrimary : Colors.grey),
//                                     const SizedBox(width: 6),
//                                     const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         // Action Buttons
//                         Row(
//                           children: [
//                             Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Cancel Ride'))),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: _goToTrackRide,
//                                 style: ElevatedButton.styleFrom(backgroundColor: AppColors.ridePrimary),
//                                 child: const Text('Track Ride'),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 30),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _smallRoundButton({required IconData icon, required Color bgColor, required VoidCallback onTap}) {
//     return Material(
//       color: bgColor,
//       shape: const CircleBorder(),
//       elevation: 4,
//       child: InkWell(
//         customBorder: const CircleBorder(),
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Icon(icon, color: bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white, size: 20),
//         ),
//       ),
//     );
//   }

//   Widget _menuSheet() {
//     return SafeArea(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(leading: const Icon(Icons.info_outline), title: const Text('Trip Details'), onTap: () => Navigator.pop(context)),
//           ListTile(leading: const Icon(Icons.payment), title: const Text('Payment'), onTap: () => Navigator.pop(context)),
//           ListTile(leading: const Icon(Icons.report), title: const Text('Report Issue'), onTap: () => Navigator.pop(context)),
//           const SizedBox(height: 8),
//         ],
//       ),
//     );
//   }
// }




import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryde_partner/services/google_maps_service.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/app_constants.dart';

class RideSearchResultScreen extends StatefulWidget {
  final gmaps.LatLng currentLatLng;
  final gmaps.LatLng destinationLatLng;
  final String originAddress;
  final String destinationAddress;
  final String selectedRideType;
  final String selectedPrice;
  final Map<String, dynamic> selectedRideOption;

  const RideSearchResultScreen({
    super.key,
    required this.currentLatLng,
    required this.destinationLatLng,
    required this.originAddress,
    required this.destinationAddress,
    required this.selectedRideType,
    required this.selectedPrice,
    required this.selectedRideOption,
  });

  @override
  State<RideSearchResultScreen> createState() => _RideSearchResultScreenState();
}

class _RideSearchResultScreenState extends State<RideSearchResultScreen>
    with SingleTickerProviderStateMixin {
  gmaps.GoogleMapController? _mapController;
  Set<gmaps.Marker> _markers = {};
  Set<gmaps.Polyline> _polylines = {};
  bool _isSearching = true;
  int _currentTextIndex = 0;
  Timer? _textTimer;
  late AnimationController _animationController;

  final List<String> _searchPhases = [
    'Finding rider for you...',
    '18 riders found',
    'Waiting for their accept request...',
  ];

  bool _rideSharingEnabled = false;
  String _rideSharingGender = 'both_mixed';
  int _pickupMinutes = 3; // Updated to 3 minutes

  // Fixed OTP for demo (real app mein backend se aayega)
  final String _displayedOtp = "4647";

  // Driver phone number
  final String _driverPhone = "+919644782290";

  late String _estimatedDropTime; // Added for estimated drop time

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _loadRideSharingPreferences();
    _calculateEstimatedDropTime(); // Added calculation
    _startSearchAnimation();
  }

  void _calculateEstimatedDropTime() {
    // Demo: pickup 3 min + approx 20 min ride (real mein distance se calculate karna)
    final now = DateTime.now();
    final dropTime = now.add(const Duration(minutes: 23));
    final hour = dropTime.hour % 12 == 0 ? 12 : dropTime.hour % 12;
    final amPm = dropTime.hour >= 12 ? 'PM' : 'AM';
    final minute = dropTime.minute.toString().padLeft(2, '0');
    _estimatedDropTime = '$hour:$minute $amPm';
  }

  Future<void> _loadRideSharingPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rideSharingEnabled = prefs.getBool('ride_sharing_enabled') ?? false;
      _rideSharingGender = prefs.getString('ride_sharing_gender') ?? 'both_mixed';
    });
  }

  void _initializeMap() async {
    _markers = {
      gmaps.Marker(
        markerId: const gmaps.MarkerId('origin'),
        position: widget.currentLatLng,
        icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueGreen),
      ),
      gmaps.Marker(
        markerId: const gmaps.MarkerId('destination'),
        position: widget.destinationLatLng,
        icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueBlue),
      ),
    };

    try {
      final route = await GoogleMapsService.getSimpleRoute(widget.currentLatLng, widget.destinationLatLng);
      _polylines = {
        gmaps.Polyline(
          polylineId: const gmaps.PolylineId('route'),
          points: route,
          color: Colors.blue,
          width: 5,
        ),
      };
    } catch (e) {}

    if (_mapController != null) {
      final bounds = gmaps.LatLngBounds(
        southwest: gmaps.LatLng(
          widget.currentLatLng.latitude < widget.destinationLatLng.latitude ? widget.currentLatLng.latitude : widget.destinationLatLng.latitude,
          widget.currentLatLng.longitude < widget.destinationLatLng.longitude ? widget.currentLatLng.longitude : widget.destinationLatLng.longitude,
        ),
        northeast: gmaps.LatLng(
          widget.currentLatLng.latitude > widget.destinationLatLng.latitude ? widget.currentLatLng.latitude : widget.destinationLatLng.latitude,
          widget.currentLatLng.longitude > widget.destinationLatLng.longitude ? widget.currentLatLng.longitude : widget.destinationLatLng.longitude,
        ),
      );
      _mapController!.animateCamera(gmaps.CameraUpdate.newLatLngBounds(bounds, 80));
    }
    setState(() {});
  }

  void _startSearchAnimation() {
    _animationController.forward();
    _textTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentTextIndex < _searchPhases.length - 1) {
        setState(() => _currentTextIndex++);
      } else {
        timer.cancel();
        setState(() {
          _isSearching = false;
        });
        _initializeMap(); // Moved outside setState to avoid nested setState
      }
    });
  }

  @override
  void dispose() {
    _textTimer?.cancel();
    _animationController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _centerMap() {
    _mapController?.animateCamera(gmaps.CameraUpdate.newCameraPosition(
      gmaps.CameraPosition(target: widget.currentLatLng, zoom: 15),
    ));
  }

  // Direct navigate to Track Ride
  void _goToTrackRide() {
    context.pushNamed(
      'track-ride',
      extra: {
        'currentLatLng': widget.currentLatLng,
        'destinationLatLng': widget.destinationLatLng,
        'originAddress': widget.originAddress,
        'destinationAddress': widget.destinationAddress,
      },
    );
  }

  // Call & Message functions (url_launcher add karna padega real mein)
  void _makeCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Calling $_driverPhone...")),
    );
    // await launchUrl(Uri(scheme: 'tel', path: _driverPhone));
  }

  void _sendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Opening messages to $_driverPhone")),
    );
    // await launchUrl(Uri(scheme: 'sms', path: _driverPhone));
  }

  @override
  Widget build(BuildContext context) {
    String genderLabel = _rideSharingGender == 'only_male'
        ? 'Only Male'
        : _rideSharingGender == 'only_female'
            ? 'Only Female'
            : 'Both (Mixed)';

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: gmaps.GoogleMap(
              initialCameraPosition: gmaps.CameraPosition(target: widget.currentLatLng, zoom: 15),
              onMapCreated: (controller) {
                _mapController = controller;
                if (!_isSearching) _initializeMap();
              },
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          ),

          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
            ),
          ),

          // Top-right buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0, top: 8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _smallRoundButton(icon: Icons.warning_amber_rounded, bgColor: Colors.red, onTap: () {}),
                    const SizedBox(height: 10),
                    _smallRoundButton(icon: Icons.menu, bgColor: Colors.white, onTap: () => showModalBottomSheet(context: context, builder: (_) => _menuSheet())),
                    const SizedBox(height: 10),
                    _smallRoundButton(icon: Icons.my_location, bgColor: Colors.white, onTap: _centerMap),
                  ],
                ),
              ),
            ),
          ),

          // Searching overlay
          if (_isSearching) ...[
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.9),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: Lottie.asset('assets/animations/Searching_radius.json', controller: _animationController,
                          onLoaded: (composition) => _animationController.duration = composition.duration,
                        ),
                      ),
                      const SizedBox(height: 18),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: Text(_searchPhases[_currentTextIndex], key: ValueKey(_currentTextIndex),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.ridePrimary),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Searching nearby riders...', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ),
          ],

          // Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.22, // Increased for better visibility
            minChildSize: 0.15,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16, spreadRadius: 4)],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24), // Improved padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pickup + Drop Time + OTP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pickup in', style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                                Text('$_pickupMinutes minutes', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 12),
                                Text('Est. drop-off', style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                                Text(_estimatedDropTime, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.ridePrimary)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                              decoration: BoxDecoration(
                                color: AppColors.ridePrimary,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                              ),
                              child: Text(
                                _displayedOtp,
                                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 10),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // From - To Addresses with icons
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.my_location, color: AppColors.ridePrimary, size: 24),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(widget.originAddress, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, color: Colors.red, size: 24),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(widget.destinationAddress, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Vehicle Details Card (Vehicle-focused, no rider name)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 36,
                                backgroundImage: AssetImage('assets/images/hero_passion_pro.jpg'), // Vehicle-focused image
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Vehicle arriving soon', style: TextStyle(color: Colors.grey[600], fontSize: 15)), // Vehicle-focused text
                                    const SizedBox(height: 8),
                                    const Text('MP13 DR 3986', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                    const Text('Dark Grey • Hero Passion Pro', style: TextStyle(fontSize: 16, color: Colors.black87)),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: const [
                                        Icon(Icons.star, color: Colors.amber, size: 20),
                                        SizedBox(width: 6),
                                        Text('4.8 (126 rides)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    iconSize: 36,
                                    icon: const Icon(Icons.message_rounded, color: Colors.blue),
                                    onPressed: _sendMessage,
                                  ),
                                  IconButton(
                                    iconSize: 36,
                                    icon: const Icon(Icons.call_rounded, color: Colors.green),
                                    onPressed: _makeCall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Ride Sharing
                        GestureDetector(
                          onTap: () => context.push('/ride-sharing'),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Ride Sharing', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text(_rideSharingEnabled ? 'On - $genderLabel' : 'Off - Solo Ride Only',
                                        style: TextStyle(fontSize: 14, color: _rideSharingEnabled ? AppColors.ridePrimary : Colors.grey)),
                                  ],
                                ),
                                Icon(_rideSharingEnabled ? Icons.toggle_on : Icons.toggle_off,
                                    size: 36, color: _rideSharingEnabled ? AppColors.ridePrimary : Colors.grey),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  side: BorderSide(color: Colors.grey.shade400),
                                ),
                                onPressed: () {}, // Cancel ride
                                child: const Text('Cancel Ride', style: TextStyle(fontSize: 17)),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.ridePrimary,
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                ),
                                onPressed: _goToTrackRide,
                                child: const Text('Track Ride', style: TextStyle(fontSize: 17, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _smallRoundButton({required IconData icon, required Color bgColor, required VoidCallback onTap}) {
    return Material(
      color: bgColor,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(icon, color: bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _menuSheet() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(leading: const Icon(Icons.info_outline), title: const Text('Trip Details'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.payment), title: const Text('Payment'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.report), title: const Text('Report Issue'), onTap: () => Navigator.pop(context)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}