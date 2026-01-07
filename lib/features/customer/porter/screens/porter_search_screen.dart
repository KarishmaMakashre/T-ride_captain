// // porter_new_order_screen.dart
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tryde_partner/core/constants/app_constants.dart';
// import 'package:tryde_partner/core/constants/color_constants.dart';

// class PorterNewOrderScreen extends StatefulWidget {
//   final String vehicleType; // "Truck", "Bike", or "Car"

//   const PorterNewOrderScreen({super.key, required this.vehicleType});

//   @override
//   State<PorterNewOrderScreen> createState() => _PorterNewOrderScreenState();
// }

// class _PorterNewOrderScreenState extends State<PorterNewOrderScreen> {
//   int selectedTabIndex = 0; // 0 = Deliver Now, 1 = By End of Day, 2 = Schedule

//   final List<Map<String, String>> tabs = [
//     {"title": "Deliver Now", "price": "from ₹45"},
//     {"title": "By End of Day", "price": "from ₹45"},
//     {"title": "Schedule", "price": "from ₹45"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false, // Default back arrow ko disable kar diya
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.black), // Ya Icons.arrow_back bhi use kar sakte ho
//           onPressed: () {
//             // GoRouter ke saath safe back
//             context.pop();
//           },
//         ),
//         title: const Text(
//           "New Order",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Clear all fields if needed
//             },
//             child: const Text("Clear", style: TextStyle(color: Colors.black54)),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Tabs
//             Row(
//               children: tabs.asMap().entries.map((entry) {
//                 int idx = entry.key;
//                 var tab = entry.value;
//                 bool isSelected = selectedTabIndex == idx;

//                 return Expanded(
//                   child: GestureDetector(
//                     onTap: () => setState(() => selectedTabIndex = idx),
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       decoration: BoxDecoration(
//                         color: isSelected ? AppColors.porterPrimary : AppColors.grey100,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Column(
//                         children: [
//                           Icon(
//                             idx == 0 ? Icons.access_time : idx == 1 ? Icons.calendar_today : Icons.schedule,
//                             color: isSelected ? Colors.white : AppColors.textLight,
//                             size: 20,
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             tab["title"]!,
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : AppColors.textPrimary,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           Text(
//                             tab["price"]!,
//                             style: TextStyle(
//                               color: isSelected ? Colors.white70 : AppColors.textLight,
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),

//             const SizedBox(height: 20),

//             // Vehicle Type Badge
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: AppColors.porterPrimary,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     widget.vehicleType == "Truck"
//                         ? Icons.local_shipping
//                         : widget.vehicleType == "Bike"
//                             ? Icons.two_wheeler
//                             : Icons.directions_car,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "${widget.vehicleType} • 2-Wheeler",
//                     style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 8),
//                   Text("up to 10 kg", style: TextStyle(color: Colors.white70, fontSize: 12)),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             // Pickup Point
//             _buildLocationCard(
//               number: "1",
//               title: "Pickup point",
//               address: "177, Extension, Gumashtha Extension, Telephone Nagar, Indore, Madhya Pradesh 452018, India",
//               onTap: () {},
//             ),

//             const SizedBox(height: 16),

//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: AppColors.porterPrimaryLight.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: const [
//                   Icon(Icons.info_outline, color: AppColors.porterPrimary),
//                   SizedBox(width: 8),
//                   Text("We will find a courier in 2 min", style: TextStyle(fontWeight: FontWeight.w500)),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 16),

//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Phone number",
//                 prefixIcon: const Icon(Icons.phone_outlined),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//             ),

//             const SizedBox(height: 16),

//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 hintText: "Instructions for the courier",
//                 prefixIcon: const Icon(Icons.note_alt_outlined),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               items: ["Leave at reception", "Call before delivery", "Hand it to me"]
//                   .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                   .toList(),
//               onChanged: (val) {},
//             ),

//             const SizedBox(height: 24),

//             _buildLocationCard(
//               number: "2",
//               title: "Delivery point",
//               address: "Add delivery point",
//               isAdd: true,
//               onTap: () {},
//             ),

//             const SizedBox(height: 20),

//             Center(
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text("Rearrange addresses", style: TextStyle(color: AppColors.porterPrimary)),
//               ),
//             ),

//             const SizedBox(height: 24),

//             DropdownButtonFormField<String>(
//               value: "Up to 1 kg",
//               decoration: InputDecoration(
//                 hintText: "Package",
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               items: ["Up to 1 kg", "1-5 kg", "5-10 kg", "10-20 kg"]
//                   .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                   .toList(),
//               onChanged: (val) {},
//             ),

//             const SizedBox(height: 80), // Extra space for bottom button
//           ],
//         ),
//       ),

//       // Bottom Fixed Bar
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           color: AppColors.white,
//           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//         ),
//         child: SafeArea( // Important: Notch ke liye safe area
//           child: Row(
//             children: [
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text("Total", style: TextStyle(fontSize: 12, color: AppColors.textLight)),
//                   Text("₹ 45 ~", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//               const Spacer(),
//               ElevatedButton(
//                 onPressed: () {
//                   context.push(AppConstants.routePorterSubmit); // Submit screen pe jao
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.porterPrimary,
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: const Text("Create order", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationCard({
//     required String number,
//     required String title,
//     required String address,
//     bool isAdd = false,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.grey300),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 16,
//               backgroundColor: AppColors.porterPrimary,
//               child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 4),
//                   Text(
//                     address,
//                     style: TextStyle(
//                       color: isAdd ? AppColors.porterPrimary : AppColors.textPrimary,
//                       fontWeight: isAdd ? FontWeight.w600 : FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (!isAdd) const Icon(Icons.location_on_outlined, color: AppColors.porterPrimary),
//           ],
//         ),
//       ),
//     );
//   }
// }





// // Updated PorterDashboardScreen remains the same, no changes needed there.

// // Updated porter_new_order_screen.dart
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tryde_partner/core/constants/app_constants.dart';
// import 'package:tryde_partner/core/constants/color_constants.dart';
// import 'package:tryde_partner/features/customer/porter/screens/item_detail_screen.dart';
// import 'package:tryde_partner/features/customer/ride/search/map_search_screen.dart';
// import 'package:tryde_partner/services/google_maps_service.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart'; // For date formatting

// class PorterNewOrderScreen extends StatefulWidget {
//   final String vehicleType; // "Truck", "Bike", or "Car"
//   const PorterNewOrderScreen({super.key, required this.vehicleType});

//   @override
//   State<PorterNewOrderScreen> createState() => _PorterNewOrderScreenState();
// }

// class _PorterNewOrderScreenState extends State<PorterNewOrderScreen> {
//   int selectedTabIndex = 0; // 0 = Deliver Now, 1 = By End of Day, 2 = Schedule
//   final List<Map<String, String>> tabs = [
//     {"title": "Deliver Now", "price": "from ₹45"},
//     {"title": "By End of Day", "price": "from ₹45"},
//     {"title": "Schedule", "price": "from ₹45"},
//   ];

//   String _pickupAddress = 'Fetching location...'; // Initial
//   String _deliveryAddress = 'Add delivery point';
//   LatLng? _pickupLatLng;
//   LatLng? _deliveryLatLng;

//   DateTime? _pickupDateTime; // For schedule tab
//   final TextEditingController _dateTimeController = TextEditingController();

//   // Item details from ItemDetailsScreen
//   String _itemDescription = '';
//   double _itemWeight = 0.0; // In kg
//   double _itemHeight = 0.0; // In cm

//   @override
//   void initState() {
//     super.initState();
//     _fetchCurrentLocation();
//   }

//   Future<void> _fetchCurrentLocation() async {
//     try {
//       final locationData = await GoogleMapsService.getCurrentLocationWithAddress();
//       setState(() {
//         _pickupAddress = locationData['address'];
//         _pickupLatLng = locationData['latLng'];
//       });
//     } catch (e) {
//       setState(() {
//         _pickupAddress = 'Unable to fetch location: $e';
//       });
//     }
//   }

//   Future<void> _selectDateTime() async {
//     final date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 30)),
//     );
//     if (date == null) return;

//     final time = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (time == null) return;

//     setState(() {
//       _pickupDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
//       _dateTimeController.text = DateFormat('yyyy-MM-dd HH:mm').format(_pickupDateTime!);
//     });
//   }

//   Future<void> _openItemDetails() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const ItemDetailsScreen(),
//       ),
//     );
//     if (result != null) {
//       setState(() {
//         _itemDescription = result['description'];
//         _itemWeight = result['weight'];
//         _itemHeight = result['height'];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.black),
//           onPressed: () => context.pop(),
//         ),
//         title: const Text(
//           "New Order",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Clear all fields
//               setState(() {
//                 _pickupAddress = 'Fetching location...';
//                 _deliveryAddress = 'Add delivery point';
//                 _pickupDateTime = null;
//                 _dateTimeController.clear();
//                 _itemDescription = '';
//                 _itemWeight = 0.0;
//                 _itemHeight = 0.0;
//                 _fetchCurrentLocation();
//               });
//             },
//             child: const Text("Clear", style: TextStyle(color: Colors.black54)),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Tabs
//             Row(
//               children: tabs.asMap().entries.map((entry) {
//                 int idx = entry.key;
//                 var tab = entry.value;
//                 bool isSelected = selectedTabIndex == idx;
//                 return Expanded(
//                   child: GestureDetector(
//                     onTap: () => setState(() => selectedTabIndex = idx),
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       decoration: BoxDecoration(
//                         color: isSelected ? AppColors.porterPrimary : AppColors.grey100,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Column(
//                         children: [
//                           Icon(
//                             idx == 0 ? Icons.access_time : idx == 1 ? Icons.calendar_today : Icons.schedule,
//                             color: isSelected ? Colors.white : AppColors.textLight,
//                             size: 20,
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             tab["title"]!,
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : AppColors.textPrimary,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           Text(
//                             tab["price"]!,
//                             style: TextStyle(
//                               color: isSelected ? Colors.white70 : AppColors.textLight,
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),
//             // Vehicle Type Badge
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: AppColors.porterPrimary,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     widget.vehicleType == "Truck"
//                         ? Icons.local_shipping
//                         : widget.vehicleType == "Bike"
//                             ? Icons.two_wheeler
//                             : Icons.directions_car,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "${widget.vehicleType} • 2-Wheeler",
//                     style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 8),
//                   Text("up to 10 kg", style: TextStyle(color: Colors.white70, fontSize: 12)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             // Pickup Point
//             _buildLocationCard(
//               number: "1",
//               title: "Pickup point",
//               address: _pickupAddress,
//               onTap: () async {
//                 final result = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => MapSelectionScreen(
//                       mode: 'origin',
//                       currentLatLng: _pickupLatLng,
//                       onSelected: (latLng, address) {
//                         // Handled in pop
//                       },
//                     ),
//                   ),
//                 );
//                 if (result != null) {
//                   setState(() {
//                     _pickupLatLng = result;
//                     GoogleMapsService.getAddressFromLatLng(result).then((addr) {
//                       setState(() => _pickupAddress = addr);
//                     });
//                   });
//                 }
//               },
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: AppColors.porterPrimaryLight.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: const [
//                   Icon(Icons.info_outline, color: AppColors.porterPrimary),
//                   SizedBox(width: 8),
//                   Text("We will find a courier in 2 min", style: TextStyle(fontWeight: FontWeight.w500)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Phone number",
//                 prefixIcon: const Icon(Icons.phone_outlined),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 hintText: "Instructions for the courier",
//                 prefixIcon: const Icon(Icons.note_alt_outlined),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               items: ["Leave at reception", "Call before delivery", "Hand it to me"]
//                   .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                   .toList(),
//               onChanged: (val) {},
//             ),
//             const SizedBox(height: 24),
//             // Delivery Point
//             _buildLocationCard(
//               number: "2",
//               title: "Delivery point",
//               address: _deliveryAddress,
//               isAdd: _deliveryAddress == 'Add delivery point',
//               onTap: () async {
//                 final result = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => MapSelectionScreen(
//                       mode: 'destination',
//                       currentLatLng: _deliveryLatLng,
//                       onSelected: (latLng, address) {
//                         // Handled in pop
//                       },
//                     ),
//                   ),
//                 );
//                 if (result != null) {
//                   setState(() {
//                     _deliveryLatLng = result;
//                     GoogleMapsService.getAddressFromLatLng(result).then((addr) {
//                       setState(() => _deliveryAddress = addr);
//                     });
//                   });
//                 }
//               },
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text("Rearrange addresses", style: TextStyle(color: AppColors.porterPrimary)),
//               ),
//             ),
//             const SizedBox(height: 24),
//             // Pickup Date and Time (Shown if Schedule tab selected)
//             if (selectedTabIndex == 2)
//               TextField(
//                 controller: _dateTimeController,
//                 readOnly: true,
//                 onTap: _selectDateTime,
//                 decoration: InputDecoration(
//                   hintText: "Pickup Date & Time",
//                   prefixIcon: const Icon(Icons.calendar_today),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//               ),
//             if (selectedTabIndex == 2) const SizedBox(height: 24),
//             // Item Details Section
//             InkWell(
//               onTap: _openItemDetails,
//               borderRadius: BorderRadius.circular(16),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.grey300),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Item Details", style: TextStyle(fontWeight: FontWeight.bold)),
//                     const Icon(Icons.arrow_forward_ios, size: 16),
//                   ],
//                 ),
//               ),
//             ),
//             if (_itemWeight > 0) const SizedBox(height: 16),
//             if (_itemWeight > 0)
//               Text("Estimated Weight: $_itemWeight kg, Height: $_itemHeight cm"),
//             const SizedBox(height: 24),
//             DropdownButtonFormField<String>(
//               value: "Up to 1 kg",
//               decoration: InputDecoration(
//                 hintText: "Package",
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               items: ["Up to 1 kg", "1-5 kg", "5-10 kg", "10-20 kg"]
//                   .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                   .toList(),
//               onChanged: (val) {},
//             ),
//             const SizedBox(height: 80), // Extra space for bottom button
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           color: AppColors.white,
//           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//         ),
//         child: SafeArea(
//           child: Row(
//             children: [
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text("Total", style: TextStyle(fontSize: 12, color: AppColors.textLight)),
//                   Text("₹ 45 ~", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//               const Spacer(),
//               ElevatedButton(
//                 onPressed: () {
//                   context.push(AppConstants.routePorterSubmit); // Submit screen pe jao
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.porterPrimary,
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: const Text("Create order", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationCard({
//     required String number,
//     required String title,
//     required String address,
//     bool isAdd = false,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.grey300),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 16,
//               backgroundColor: AppColors.porterPrimary,
//               child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 4),
//                   Text(
//                     address,
//                     style: TextStyle(
//                       color: isAdd ? AppColors.porterPrimary : AppColors.textPrimary,
//                       fontWeight: isAdd ? FontWeight.w600 : FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (!isAdd) const Icon(Icons.location_on_outlined, color: AppColors.porterPrimary),
//           ],
//         ),
//       ),
//     );
//   }
// }



// Updated porter_new_order_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/app_constants.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/features/customer/porter/screens/item_detail_screen.dart';
import 'package:tryde_partner/features/customer/ride/search/map_search_screen.dart';
import 'package:tryde_partner/services/google_maps_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart'; // For date formatting

class PorterNewOrderScreen extends StatefulWidget {
  final String vehicleType; // "Truck", "Bike", or "Car"
  const PorterNewOrderScreen({super.key, required this.vehicleType});

  @override
  State<PorterNewOrderScreen> createState() => _PorterNewOrderScreenState();
}

class _PorterNewOrderScreenState extends State<PorterNewOrderScreen> {
  int selectedTabIndex = 0; // 0 = Deliver Now, 1 = By End of Day, 2 = Schedule
  final List<Map<String, String>> tabs = [
    {"title": "Deliver Now", "price": "from ₹45"},
    {"title": "By End of Day", "price": "from ₹45"},
    {"title": "Schedule", "price": "from ₹45"},
  ];

  String _pickupAddress = 'Fetching location...'; // Initial
  String _deliveryAddress = 'Add delivery point';
  LatLng? _pickupLatLng;
  LatLng? _deliveryLatLng;

  DateTime? _pickupDateTime; // For pickup date/time
  final TextEditingController _dateTimeController = TextEditingController();

  // Item details from ItemDetailsScreen
  String _itemDescription = '';
  double _itemWeight = 0.0; // In kg
  double _itemHeight = 0.0; // In cm
  double _itemLength = 0.0; // In cm
  double _itemBreadth = 0.0; // In cm
  double _itemArea = 0.0; // In cm²

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
    // Set default pickup time to now
    _pickupDateTime = DateTime.now();
    _dateTimeController.text = DateFormat('yyyy-MM-dd HH:mm').format(_pickupDateTime!);
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      final locationData = await GoogleMapsService.getCurrentLocationWithAddress();
      setState(() {
        _pickupAddress = locationData['address'];
        _pickupLatLng = locationData['latLng'];
      });
    } catch (e) {
      setState(() {
        _pickupAddress = 'Unable to fetch location: $e';
      });
    }
  }

  Future<void> _selectDateTime() async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    // For Deliver Now or By End of Day, restrict to today or future
    if (selectedTabIndex == 0 || selectedTabIndex == 1) {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 1)), // Up to tomorrow for By End of Day
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.porterPrimary,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors.porterPrimary,
                foregroundColor: Colors.white,
              ),
            ),
            child: child!,
          );
        },
      );
    } else {
      // For Schedule, up to 30 days
      selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.porterPrimary,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors.porterPrimary,
                foregroundColor: Colors.white,
              ),
            ),
            child: child!,
          );
        },
      );
    }

    if (selectedDate == null) return;

    selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.porterPrimary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedTime == null) return;

    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    setState(() {
      _pickupDateTime = selectedDateTime;
      _dateTimeController.text = DateFormat('yyyy-MM-dd HH:mm').format(_pickupDateTime!);
    });
  }

  Future<void> _openItemDetails() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ItemDetailsScreen(),
      ),
    );
    if (result != null) {
      setState(() {
        _itemDescription = result['description'];
        _itemWeight = result['weight'];
        _itemHeight = result['height'];
        _itemLength = result['length'] ?? 0.0;
        _itemBreadth = result['breadth'] ?? 0.0;
        _itemArea = result['area'] ?? 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasDateSelected = _dateTimeController.text.isNotEmpty;
    final borderColor = hasDateSelected ? AppColors.porterPrimary : Colors.grey;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          "New Order",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Clear all fields
              setState(() {
                _pickupAddress = 'Fetching location...';
                _deliveryAddress = 'Add delivery point';
                _pickupDateTime = DateTime.now();
                _dateTimeController.text = DateFormat('yyyy-MM-dd HH:mm').format(_pickupDateTime!);
                _itemDescription = '';
                _itemWeight = 0.0;
                _itemHeight = 0.0;
                _itemLength = 0.0;
                _itemBreadth = 0.0;
                _itemArea = 0.0;
                _fetchCurrentLocation();
              });
            },
            child: const Text("Clear", style: TextStyle(color: Colors.black54)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Tabs
            Row(
              children: tabs.asMap().entries.map((entry) {
                int idx = entry.key;
                var tab = entry.value;
                bool isSelected = selectedTabIndex == idx;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = idx),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.porterPrimary : AppColors.grey100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            idx == 0 ? Icons.access_time : idx == 1 ? Icons.calendar_today : Icons.schedule,
                            color: isSelected ? Colors.white : AppColors.textLight,
                            size: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tab["title"]!,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            tab["price"]!,
                            style: TextStyle(
                              color: isSelected ? Colors.white70 : AppColors.textLight,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Vehicle Type Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.porterPrimary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.vehicleType == "Truck"
                        ? Icons.local_shipping
                        : widget.vehicleType == "Bike"
                            ? Icons.two_wheeler
                            : Icons.directions_car,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${widget.vehicleType} • 2-Wheeler",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text("up to 10 kg", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Pickup Point
            _buildLocationCard(
              number: "1",
              title: "Pickup point",
              address: _pickupAddress,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapSelectionScreen(
                      mode: 'origin',
                      currentLatLng: _pickupLatLng,
                      onSelected: (latLng, address) {
                        // Handled in pop
                      },
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    _pickupLatLng = result;
                    GoogleMapsService.getAddressFromLatLng(result).then((addr) {
                      setState(() => _pickupAddress = addr);
                    });
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            // Pickup Date & Time Field (Always shown)
            TextField(
              controller: _dateTimeController,
              readOnly: true,
              onTap: _selectDateTime,
              decoration: InputDecoration(
                hintText: "Pickup Date & Time",
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.porterPrimary, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.porterPrimaryLight.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info_outline, color: AppColors.porterPrimary),
                  SizedBox(width: 8),
                  Text("We will find a courier in 2 min", style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "Phone number",
                prefixIcon: const Icon(Icons.phone_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: "Instructions for the courier",
                prefixIcon: const Icon(Icons.note_alt_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: ["Leave at reception", "Call before delivery", "Hand it to me"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {},
            ),
            const SizedBox(height: 24),
            // Delivery Point
            _buildLocationCard(
              number: "2",
              title: "Delivery point",
              address: _deliveryAddress,
              isAdd: _deliveryAddress == 'Add delivery point',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapSelectionScreen(
                      mode: 'destination',
                      currentLatLng: _deliveryLatLng,
                      onSelected: (latLng, address) {
                        // Handled in pop
                      },
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    _deliveryLatLng = result;
                    GoogleMapsService.getAddressFromLatLng(result).then((addr) {
                      setState(() => _deliveryAddress = addr);
                    });
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Rearrange addresses", style: TextStyle(color: AppColors.porterPrimary)),
              ),
            ),
            const SizedBox(height: 24),
            // Item Details Section
            InkWell(
              onTap: _openItemDetails,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey300),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Item Details", style: TextStyle(fontWeight: FontWeight.bold)),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            if (_itemWeight > 0) const SizedBox(height: 16),
            if (_itemWeight > 0)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Item: $_itemDescription",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text("Est. Weight: $_itemWeight kg"),
                    Text("Est. Dimensions: L: $_itemLength cm x B: $_itemBreadth cm x H: $_itemHeight cm"),
                    Text("Est. Area: $_itemArea cm²"),
                  ],
                ),
              ),
            const SizedBox(height: 80), // Extra space for bottom button
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Total", style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                  Text("₹ 45 ~", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.push(AppConstants.routePorterSubmit); // Submit screen pe jao
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.porterPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Create order", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard({
    required String number,
    required String title,
    required String address,
    bool isAdd = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.porterPrimary,
              child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(
                      color: isAdd ? AppColors.porterPrimary : AppColors.textPrimary,
                      fontWeight: isAdd ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            if (!isAdd) const Icon(Icons.location_on_outlined, color: AppColors.porterPrimary),
          ],
        ),
      ),
    );
  }
}