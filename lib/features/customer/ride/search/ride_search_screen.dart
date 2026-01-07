// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Add for SharedPreferences
// import 'package:tryde_partner/core/constants/color_constants.dart';
// import 'package:tryde_partner/services/google_maps_service.dart';

// class RideSearchScreen extends StatefulWidget {
//   const RideSearchScreen({super.key});

//   @override
//   State<RideSearchScreen> createState() => _RideSearchScreenState();
// }

// class _RideSearchScreenState extends State<RideSearchScreen> {
//   int _currentStep = 0;
//   final TextEditingController _destinationController = TextEditingController();

//   // Hardcoded ride options for demo
//   final List<Map<String, dynamic>> _rideOptions = [
//     {
//       'type': 'Bike',
//       'icon': 'assets/images/bike.png',
//       'time': '1 min',
//       'price': '₹21',
//       'pay': 'Pay direct to driver/cash',
//     },
//     {
//       'type': 'Auto',
//       'icon': 'assets/images/auto.png', 
//       'time': '2 min',
//       'price': '₹28',
//       'pay': 'Pay direct to driver/cash',
//     },
//     {
//       'type': 'Economy',
//       'icon': 'assets/images/car.png', 
//       'time': '2 min',
//       'price': '₹130',
//       'pay': 'Pay direct to driver/cash',
//     },
//     {
//       'type': 'Cab',
//       'icon': 'assets/images/car.png', 
//       'time': '2 min',
//       'price': '₹130',
//       'pay': 'Pay direct to driver/cash',
//     },
//   ];

//   String _selectedRide = 'Bike'; 
//   int _selectedRideIndex = 0;

//   // Map-related variables
//   GoogleMapController? _mapController;
//   LatLng? _currentLatLng; // Now can be changed if user selects new origin
//   LatLng? _destinationLatLng;
//   Set<Marker> _markers = {};
//   Set<Polyline> _polylines = {};
//   String _currentAddress = 'Fetching current location...';
//   String _destinationAddress = 'Select destination on map';
//   bool _isLoadingLocation = true;

//   // Ride Sharing Preferences (loaded in initState)
//   bool _rideSharingEnabled = false;
//   String _rideSharingGender = 'both_mixed';

//   @override
//   void initState() {
//     super.initState();
//     _initializeLocation();
//     _loadRideSharingPreferences(); // Load preferences
//   }

//   // Load Ride Sharing Preferences
//   Future<void> _loadRideSharingPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _rideSharingEnabled = prefs.getBool('ride_sharing_enabled') ?? false;
//       _rideSharingGender = prefs.getString('ride_sharing_gender') ?? 'both_mixed';
//     });
//   }

//   Future<void> _initializeLocation() async {
//     try {
//       final locationData = await GoogleMapsService.getCurrentLocationWithAddress();
//       setState(() {
//         _currentLatLng = locationData['latLng'];
//         _currentAddress = locationData['address'];
//         _isLoadingLocation = false;
//       });

//       // Add current location marker
//       _updateOriginMarker();
//     } catch (e) {
//       setState(() {
//         _currentAddress = 'Error fetching location: $e';
//         _isLoadingLocation = false;
//       });
//     }
//   }

//   void _updateOriginMarker() {
//     _markers.removeWhere((m) => m.markerId.value == 'origin');
//     if (_currentLatLng != null) {
//       _markers.add(Marker(
//         markerId: const MarkerId('origin'),
//         position: _currentLatLng!,
//         infoWindow: InfoWindow(title: 'Origin'),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//       ));
//     }
//   }

//   // Handle origin selection
//   void _selectOrigin(LatLng latLng, String address) {
//     setState(() {
//       _currentLatLng = latLng;
//       _currentAddress = address;
//     });
//     _updateOriginMarker();
//     // Update map camera
//     if (_mapController != null) {
//       _mapController!.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
//     }
//   }

//   // Handle destination selection
//   void _selectDestination(LatLng latLng, String address) {
//     setState(() {
//       _destinationLatLng = latLng;
//       _destinationAddress = address;
//       _destinationController.text = address;
//     });

//     // Add destination marker
//     _markers.removeWhere((m) => m.markerId.value == 'destination');
//     _markers.add(Marker(
//       markerId: const MarkerId('destination'),
//       position: latLng,
//       infoWindow: InfoWindow(title: address),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//     ));

//     // Update map camera
//     if (_mapController != null) {
//       _mapController!.animateCamera(CameraUpdate.newLatLngBounds(
//         LatLngBounds(
//           southwest: LatLng(
//             (_currentLatLng!.latitude < latLng.latitude ? _currentLatLng!.latitude : latLng.latitude) - 0.01,
//             (_currentLatLng!.longitude < latLng.longitude ? _currentLatLng!.longitude : latLng.longitude) - 0.01,
//           ),
//           northeast: LatLng(
//             (_currentLatLng!.latitude > latLng.latitude ? _currentLatLng!.latitude : latLng.latitude) + 0.01,
//             (_currentLatLng!.longitude > latLng.longitude ? _currentLatLng!.longitude : latLng.longitude) + 0.01,
//           ),
//         ),
//         100,
//       ));
//     }

//     // Draw route
//     _drawRoute();
//   }

//   // Open map selection screen
//   void _openMapSelection(String mode) {
//     if (_isLoadingLocation && mode == 'origin') return;

//     final Function(LatLng, String) callback = mode == 'origin' ? _selectOrigin : _selectDestination;
     
//     context.push(
//       '/map-selection/$mode',
//       extra: {
//         'currentLatLng': mode == 'origin' ? _currentLatLng : null,
//         'onSelected': callback,
//       },
//     );
//   }

//   Future<void> _drawRoute() async {
//     if (_currentLatLng == null || _destinationLatLng == null) return;

//     final route = await GoogleMapsService.getSimpleRoute(_currentLatLng!, _destinationLatLng!);
//     _polylines.removeWhere((p) => p.polylineId.value == 'route');
//     _polylines.add(Polyline(
//       polylineId: const PolylineId('route'),
//       points: route,
//       color: Colors.blue,
//       width: 5,
//     ));
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _destinationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => context.pop(),
//         ),
//         title: Text(
//           'Ride',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         backgroundColor: AppColors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),

//               // Step indicator
//               _buildStepIndicator(),

//               const SizedBox(height: 20),

//               // Conditional content based on step
//               if (_currentStep == 0) ..._buildPlanYourRide(),
//               if (_currentStep == 1) ..._buildSelectYourRide(),
//               if (_currentStep == 2) ..._buildRideDetails(),

//               const SizedBox(height: 20),

//               // Navigation buttons
//               _buildNavigationButtons(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Step indicator (unchanged)
//   Widget _buildStepIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(3, (index) {
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 4),
//           width: 30,
//           height: 4,
//           decoration: BoxDecoration(
//             color: index <= _currentStep ? AppColors.ridePrimary : AppColors.grey200,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         );
//       }),
//     );
//   }

//   // Updated Plan Your Ride Step: Both origin and destination tappable
//   List<Widget> _buildPlanYourRide() {
//     return [
//       // Header
//       const Text(
//         'Get ride in 3 minutes',
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textPrimary,
//         ),
//       ),
//       const SizedBox(height: 20),

//       // Tappable Origin input (default current, but changeable)
//       if (_isLoadingLocation)
//         const Center(child: CircularProgressIndicator())
//       else
//         GestureDetector(
//           onTap: () => _openMapSelection('origin'),
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: AppColors.grey100,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.my_location, color: AppColors.ridePrimary),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Origin', style: TextStyle(fontWeight: FontWeight.w600)),
//                       Text(_currentAddress, style: TextStyle(color: AppColors.textPrimary)),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.edit, color: AppColors.ridePrimary), // Edit icon to indicate tappable
//               ],
//             ),
//           ),
//         ),
//       const SizedBox(height: 16),

//       // Tappable Destination input
//       GestureDetector(
//         onTap: () => _openMapSelection('destination'),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: AppColors.grey100,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//           child: Row(
//             children: [
//               const Icon(Icons.search, color: AppColors.ridePrimary),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Destination', style: TextStyle(fontWeight: FontWeight.w600)),
//                     Text(
//                       _destinationAddress,
//                       style: TextStyle(
//                         color: _destinationLatLng != null ? AppColors.textPrimary : AppColors.textLight,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Icon(Icons.edit, color: AppColors.ridePrimary),
//             ],
//           ),
//         ),
//       ),
//       const SizedBox(height: 20),

//       // Main Map
//       if (!_isLoadingLocation)
//         SizedBox(
//           height: 250,
//           child: Stack(
//             children: [
//               GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: _currentLatLng ?? const LatLng(22.7196, 75.8577),
//                   zoom: 15,
//                 ),
//                 onMapCreated: (GoogleMapController controller) {
//                   _mapController = controller;
//                   if (_currentLatLng != null) {
//                     controller.animateCamera(CameraUpdate.newLatLngZoom(_currentLatLng!, 15));
//                   }
//                 },
//                 markers: _markers,
//                 polylines: _polylines,
//                 myLocationEnabled: true,
//                 myLocationButtonEnabled: true,
//               ),
//               // Route info overlay
//               if (_destinationLatLng != null)
//                 Positioned(
//                   bottom: 20,
//                   left: 20,
//                   right: 20,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Row(
//                       children: [
//                         Icon(Icons.directions, color: AppColors.ridePrimary, size: 20),
//                         SizedBox(width: 8),
//                         Text('2.3 km, 7 min'),
//                       ],
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//     ];
//   }

//   // _buildSelectYourRide (unchanged)
//   List<Widget> _buildSelectYourRide() {
//     return [
//       const Text(
//         'Choose your ride',
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
//       ),
//       const SizedBox(height: 20),
//       ...List.generate(_rideOptions.length, (index) {
//         final option = _rideOptions[index];
//         final isSelected = _selectedRideIndex == index;
//         return GestureDetector(
//           onTap: () => setState(() => _selectedRideIndex = index),
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 12),
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: isSelected ? AppColors.ridePrimary.withOpacity(0.1) : AppColors.grey100,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: isSelected ? AppColors.ridePrimary : Colors.transparent, width: 1),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(color: AppColors.ridePrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
//                   child: Image.asset(option['icon'], height: 30, width: 30, errorBuilder: (context, error, stackTrace) => Icon(Icons.directions_bike, color: isSelected ? Colors.white : AppColors.ridePrimary, size: 30)),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(option['type'], style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
//                       const SizedBox(height: 4),
//                       Text(option['time'], style: TextStyle(color: AppColors.textLight)),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Text(option['price'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.ridePrimary)),
//                           const SizedBox(width: 8),
//                           Text(option['pay'], style: TextStyle(fontSize: 12, color: AppColors.textLight)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (isSelected) const Icon(Icons.check_circle, color: AppColors.ridePrimary),
//               ],
//             ),
//           ),
//         );
//       }),
//     ];
//   }

//   // Updated Ride Details Step: Added Ride Sharing Section
//   List<Widget> _buildRideDetails() {
//     final selectedOption = _rideOptions[_selectedRideIndex];
//     String genderLabel = _rideSharingGender == 'only_male' ? 'Only Male' : 
//                         _rideSharingGender == 'only_female' ? 'Only Female' : 'Both (Mixed)';
//     return [
//       // Header
//       const Text(
//         'Ride details',
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textPrimary,
//         ),
//       ),
//       const SizedBox(height: 20),

//       // Meet point (now uses selected destination)
//       Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.grey100,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Meet at picked point', style: TextStyle(fontWeight: FontWeight.w600)),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Icon(Icons.location_on, color: AppColors.ridePrimary, size: 16),
//                 SizedBox(width: 4),
//                 Expanded(child: Text(_destinationAddress)),
//               ],
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Checkbox(value: true, onChanged: null),
//                 const Text('Share PIN with driver'),
//               ],
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),

//       // Ride Sharing Status (New Section - Tappable)
//       GestureDetector(
//         onTap: () {
//           context.push('/ride-sharing'); // Navigate to Ride Sharing Screen
//         },
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: AppColors.grey100,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Ride Sharing', style: TextStyle(fontWeight: FontWeight.w600)),
//                   const SizedBox(height: 4),
//                   Text(
//                     _rideSharingEnabled 
//                       ? 'On - $genderLabel' 
//                       : 'Off - Solo Ride Only',
//                     style: TextStyle(
//                       color: _rideSharingEnabled ? AppColors.ridePrimary : AppColors.textLight,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Icon(
//                     _rideSharingEnabled ? Icons.toggle_on : Icons.toggle_off,
//                     color: _rideSharingEnabled ? AppColors.ridePrimary : Colors.grey,
//                   ),
//                   const SizedBox(width: 8),
//                   const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.textLight),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       const SizedBox(height: 16),

//       // PIN section (unchanged)
//       Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.grey100,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Your PIN', style: TextStyle(fontWeight: FontWeight.w600)),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.numbers, color: AppColors.ridePrimary),
//                 const SizedBox(width: 12),
//                 const Text('9890', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                 const Spacer(),
//                 ElevatedButton(
//                   onPressed: () => setState(() {}),
//                   child: const Text('New PIN'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),

//       // Driver info (unchanged)
//       Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.grey100,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             const CircleAvatar(
//               radius: 25,
//               child: Icon(Icons.person, size: 30),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Akash Ragh', style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text('${selectedOption['type']} • Dark Grey', style: TextStyle(color: AppColors.textLight)),
//                   const SizedBox(height: 4),
//                   Text(selectedOption['price'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.ridePrimary)),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.phone),
//                   onPressed: () {},
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.message),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ];
//   }

//   // Navigation buttons (updated validation for both origin and destination)
//   Widget _buildNavigationButtons() {
//     return Column(
//       children: [
//         if (_currentStep < 2)
//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_currentStep == 0) {
//                   if (_currentLatLng == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an origin')));
//                     return;
//                   }
//                   if (_destinationLatLng == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a destination')));
//                     return;
//                   }
//                 }
//                 setState(() => _currentStep++);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.ridePrimary,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               child: Text(
//                 _currentStep == 0 ? 'Find Rides' : 'Continue',
//                 style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           )
//         else
//           SizedBox(
//     width: double.infinity,
//     height: 50,
//     child: ElevatedButton(
//       onPressed: () {
//         context.push(
//           '/ride-search-result',
//           extra: {
//             'currentLatLng': _currentLatLng,
//             'destinationLatLng': _destinationLatLng,
//             'originAddress': _currentAddress,
//             'destinationAddress': _destinationAddress,
//             'selectedRideType': _rideOptions[_selectedRideIndex]['type'],
//             'selectedPrice': _rideOptions[_selectedRideIndex]['price'],
//             'selectedRideOption': _rideOptions[_selectedRideIndex],
//           },
//         );
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.ridePrimary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       child: const Text('Confirm Ride', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//     ),
//   ),
//         const SizedBox(height: 16),
//         if (_currentStep > 0)
//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: OutlinedButton(
//               onPressed: () => setState(() => _currentStep--),
//               style: OutlinedButton.styleFrom(
//                 side: BorderSide(color: AppColors.ridePrimary),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               child: const Text('Back', style: TextStyle(color: AppColors.ridePrimary)),
//             ),
//           ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add for SharedPreferences
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/services/google_maps_service.dart';

class RideSearchScreen extends StatefulWidget {
  const RideSearchScreen({super.key});

  @override
  State<RideSearchScreen> createState() => _RideSearchScreenState();
}

class _RideSearchScreenState extends State<RideSearchScreen> {
  int _currentStep = 0;
  final TextEditingController _destinationController = TextEditingController();

  // Hardcoded ride options for demo
  final List<Map<String, dynamic>> _rideOptions = [
    {
      'type': 'Bike',
      'icon': 'assets/images/bike.png',
      'time': '1 min',
      'price': '₹21',
      'pay': 'Pay direct to driver/cash',
    },
    {
      'type': 'Auto',
      'icon': 'assets/images/auto.png', 
      'time': '2 min',
      'price': '₹28',
      'pay': 'Pay direct to driver/cash',
    },
    {
      'type': 'Economy',
      'icon': 'assets/images/car.png', 
      'time': '2 min',
      'price': '₹130',
      'pay': 'Pay direct to driver/cash',
    },
    {
      'type': 'Cab',
      'icon': 'assets/images/car.png', 
      'time': '2 min',
      'price': '₹130',
      'pay': 'Pay direct to driver/cash',
    },
  ];

  String _selectedRide = 'Bike'; 
  int _selectedRideIndex = 0;

  // Map-related variables
  GoogleMapController? _mapController;
  LatLng? _currentLatLng; // Now can be changed if user selects new origin
  LatLng? _destinationLatLng;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  String _currentAddress = 'Fetching current location...';
  String _destinationAddress = 'Select destination on map';
  bool _isLoadingLocation = true;

  // Ride Sharing Preferences (loaded in initState)
  bool _rideSharingEnabled = false;
  String _rideSharingGender = 'both_mixed';

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _loadRideSharingPreferences(); // Load preferences
  }

  // Load Ride Sharing Preferences
  Future<void> _loadRideSharingPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rideSharingEnabled = prefs.getBool('ride_sharing_enabled') ?? false;
      _rideSharingGender = prefs.getString('ride_sharing_gender') ?? 'both_mixed';
    });
  }

  Future<void> _initializeLocation() async {
    try {
      final locationData = await GoogleMapsService.getCurrentLocationWithAddress();
      setState(() {
        _currentLatLng = locationData['latLng'];
        _currentAddress = locationData['address'];
        _isLoadingLocation = false;
      });

      // Add current location marker
      _updateOriginMarker();
    } catch (e) {
      setState(() {
        _currentAddress = 'Error fetching location: $e';
        _isLoadingLocation = false;
      });
    }
  }

  void _updateOriginMarker() {
    _markers.removeWhere((m) => m.markerId.value == 'origin');
    if (_currentLatLng != null) {
      _markers.add(Marker(
        markerId: const MarkerId('origin'),
        position: _currentLatLng!,
        infoWindow: InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ));
    }
  }

  // Handle origin selection
  void _selectOrigin(LatLng latLng, String address) {
    setState(() {
      _currentLatLng = latLng;
      _currentAddress = address;
    });
    _updateOriginMarker();
    // Update map camera
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
    }
  }

  // Handle destination selection
  void _selectDestination(LatLng latLng, String address) {
    setState(() {
      _destinationLatLng = latLng;
      _destinationAddress = address;
      _destinationController.text = address;
    });

    // Add destination marker
    _markers.removeWhere((m) => m.markerId.value == 'destination');
    _markers.add(Marker(
      markerId: const MarkerId('destination'),
      position: latLng,
      infoWindow: InfoWindow(title: address),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ));

    // Update map camera
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            (_currentLatLng!.latitude < latLng.latitude ? _currentLatLng!.latitude : latLng.latitude) - 0.01,
            (_currentLatLng!.longitude < latLng.longitude ? _currentLatLng!.longitude : latLng.longitude) - 0.01,
          ),
          northeast: LatLng(
            (_currentLatLng!.latitude > latLng.latitude ? _currentLatLng!.latitude : latLng.latitude) + 0.01,
            (_currentLatLng!.longitude > latLng.longitude ? _currentLatLng!.longitude : latLng.longitude) + 0.01,
          ),
        ),
        100,
      ));
    }

    // Draw route
    _drawRoute();
  }

  // Open map selection screen
  void _openMapSelection(String mode) {
    if (_isLoadingLocation && mode == 'origin') return;

    final Function(LatLng, String) callback = mode == 'origin' ? _selectOrigin : _selectDestination;
     
    context.push(
      '/map-selection/$mode',
      extra: {
        'currentLatLng': mode == 'origin' ? _currentLatLng : null,
        'onSelected': callback,
      },
    );
  }

  Future<void> _drawRoute() async {
    if (_currentLatLng == null || _destinationLatLng == null) return;

    final route = await GoogleMapsService.getSimpleRoute(_currentLatLng!, _destinationLatLng!);
    _polylines.removeWhere((p) => p.polylineId.value == 'route');
    _polylines.add(Polyline(
      polylineId: const PolylineId('route'),
      points: route,
      color: Colors.blue,
      width: 5,
    ));
    setState(() {});
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Ride',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Step indicator
              _buildStepIndicator(),

              const SizedBox(height: 20),

              // Conditional content based on step
              if (_currentStep == 0) ..._buildPlanYourRide(),
              if (_currentStep == 1) ..._buildSelectYourRide(),
              if (_currentStep == 2) ..._buildRideDetails(),

              const SizedBox(height: 20),

              // Navigation buttons
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // Step indicator (unchanged)
  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 30,
          height: 4,
          decoration: BoxDecoration(
            color: index <= _currentStep ? AppColors.ridePrimary : AppColors.grey200,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }

  // Updated Plan Your Ride Step: Both origin and destination tappable
  List<Widget> _buildPlanYourRide() {
    return [
      // Header
      const Text(
        'Get ride in 3 minutes',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      const SizedBox(height: 20),

      // Tappable Origin input (default current, but changeable)
      if (_isLoadingLocation)
        const Center(child: CircularProgressIndicator())
      else
        GestureDetector(
          onTap: () => _openMapSelection('origin'),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                const Icon(Icons.my_location, color: AppColors.ridePrimary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Origin', style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(_currentAddress, style: TextStyle(color: AppColors.textPrimary)),
                    ],
                  ),
                ),
                const Icon(Icons.edit, color: AppColors.ridePrimary), // Edit icon to indicate tappable
              ],
            ),
          ),
        ),
      const SizedBox(height: 16),

      // Tappable Destination input
      GestureDetector(
        onTap: () => _openMapSelection('destination'),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: AppColors.ridePrimary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Destination', style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(
                      _destinationAddress,
                      style: TextStyle(
                        color: _destinationLatLng != null ? AppColors.textPrimary : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.edit, color: AppColors.ridePrimary),
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),

      // Main Map
      if (!_isLoadingLocation)
        SizedBox(
          height: 250,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _currentLatLng ?? const LatLng(22.7196, 75.8577),
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                  if (_currentLatLng != null) {
                    controller.animateCamera(CameraUpdate.newLatLngZoom(_currentLatLng!, 15));
                  }
                },
                markers: _markers,
                polylines: _polylines,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
              // Route info overlay
              if (_destinationLatLng != null)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.directions, color: AppColors.ridePrimary, size: 20),
                        SizedBox(width: 8),
                        Text('2.3 km, 7 min'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
    ];
  }

  // _buildSelectYourRide (unchanged)
  List<Widget> _buildSelectYourRide() {
    return [
      const Text(
        'Choose your ride',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      ),
      const SizedBox(height: 20),
      ...List.generate(_rideOptions.length, (index) {
        final option = _rideOptions[index];
        final isSelected = _selectedRideIndex == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedRideIndex = index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.ridePrimary.withOpacity(0.1) : AppColors.grey100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? AppColors.ridePrimary : Colors.transparent, width: 1),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.ridePrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Image.asset(option['icon'], height: 30, width: 30, errorBuilder: (context, error, stackTrace) => Icon(Icons.directions_bike, color: isSelected ? Colors.white : AppColors.ridePrimary, size: 30)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(option['type'], style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Text(option['time'], style: TextStyle(color: AppColors.textLight)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(option['price'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.ridePrimary)),
                          const SizedBox(width: 8),
                          Text(option['pay'], style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isSelected) const Icon(Icons.check_circle, color: AppColors.ridePrimary),
              ],
            ),
          ),
        );
      }),
    ];
  }

  // Updated Ride Details Step: Modified UI, added Change button for meet point, removed driver info, added selected ride section
  List<Widget> _buildRideDetails() {
    final selectedOption = _rideOptions[_selectedRideIndex];
    String genderLabel = _rideSharingGender == 'only_male' ? 'Only Male' : 
                        _rideSharingGender == 'only_female' ? 'Only Female' : 'Both (Mixed)';
    return [
      // Header
      const Text(
        'Ride details',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      const SizedBox(height: 20),

      // Meet point (now tappable with edit icon)
      GestureDetector(
        onTap: () => _openMapSelection('destination'),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Meet at picked point', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.ridePrimary, size: 16),
                        const SizedBox(width: 4),
                        Expanded(child: Text(_destinationAddress)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: null),
                        const Text('Share PIN with driver'),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.edit, color: AppColors.ridePrimary),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),

      // Ride Sharing Status (New Section - Tappable)
      GestureDetector(
        onTap: () {
          context.push('/ride-sharing'); // Navigate to Ride Sharing Screen
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ride Sharing', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(
                    _rideSharingEnabled 
                      ? 'On - $genderLabel' 
                      : 'Off - Solo Ride Only',
                    style: TextStyle(
                      color: _rideSharingEnabled ? AppColors.ridePrimary : AppColors.textLight,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    _rideSharingEnabled ? Icons.toggle_on : Icons.toggle_off,
                    color: _rideSharingEnabled ? AppColors.ridePrimary : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.textLight),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),

      // PIN section (unchanged)
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your PIN', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.numbers, color: AppColors.ridePrimary),
                const SizedBox(width: 12),
                const Text('9890', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: const Text('New PIN'),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),

      // Selected Ride section (new, replaces driver info)
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.ridePrimary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.ridePrimary.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.ridePrimary.withOpacity(0.1), 
                borderRadius: BorderRadius.circular(8)
              ),
              child: Image.asset(
                selectedOption['icon'], 
                height: 30, 
                width: 30, 
                errorBuilder: (context, error, stackTrace) => 
                  Icon(Icons.directions_car, color: AppColors.ridePrimary, size: 30)
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedOption['type'], 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      color: AppColors.textPrimary,
                      fontSize: 16
                    )
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedOption['time'], 
                    style: TextStyle(color: AppColors.textLight, fontSize: 14)
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        selectedOption['price'], 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 18, 
                          color: AppColors.ridePrimary
                        )
                      ),
                      const SizedBox(width: 8),
                      Text(
                        selectedOption['pay'], 
                        style: TextStyle(
                          fontSize: 12, 
                          color: AppColors.textLight
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  // Navigation buttons (updated validation for both origin and destination)
  Widget _buildNavigationButtons() {
    return Column(
      children: [
        if (_currentStep < 2)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep == 0) {
                  if (_currentLatLng == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an origin')));
                    return;
                  }
                  if (_destinationLatLng == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a destination')));
                    return;
                  }
                }
                setState(() => _currentStep++);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ridePrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                _currentStep == 0 ? 'Find Rides' : 'Continue',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        else
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                context.push(
                  '/ride-search-result',
                  extra: {
                    'currentLatLng': _currentLatLng,
                    'destinationLatLng': _destinationLatLng,
                    'originAddress': _currentAddress,
                    'destinationAddress': _destinationAddress,
                    'selectedRideType': _rideOptions[_selectedRideIndex]['type'],
                    'selectedPrice': _rideOptions[_selectedRideIndex]['price'],
                    'selectedRideOption': _rideOptions[_selectedRideIndex],
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ridePrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Confirm Ride', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        const SizedBox(height: 16),
        if (_currentStep > 0)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () => setState(() => _currentStep--),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.ridePrimary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Back', style: TextStyle(color: AppColors.ridePrimary)),
            ),
          ),
      ],
    );
  }
}