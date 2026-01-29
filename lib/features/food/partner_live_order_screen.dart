import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PartnerLiveOrderScreen extends StatefulWidget {
  const PartnerLiveOrderScreen({super.key});

  @override
  State<PartnerLiveOrderScreen> createState() =>
      _PartnerLiveOrderScreenState();
}

class _PartnerLiveOrderScreenState extends State<PartnerLiveOrderScreen> {
  GoogleMapController? mapController;
  LatLng? currentLatLng;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  /// 📍 LOCATION PERMISSION + FETCH
  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentLatLng = LatLng(pos.latitude, pos.longitude);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                /// 🗺 GOOGLE MAP
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: currentLatLng!,
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("partner"),
                      position: currentLatLng!,
                    ),
                  },
                ),

                /// 🔙 BACK BUTTON
                Positioned(
                  top: 50,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                /// 📦 BOTTOM ORDER CARD
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _orderBottomSheet(),
                ),
              ],
            ),
    );
  }

  /// 🧾 ORDER DETAILS CARD
  Widget _orderBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 40,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          /// 👤 CUSTOMER
          Row(
            children: const [
              CircleAvatar(
                radius: 26,
                backgroundImage:
                    NetworkImage("https://i.pravatar.cc/150?img=4"),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Aman Sharma",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Order #FD1023",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// 📍 ADDRESS
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.location_on, color: Colors.green),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "201/D Ananta Apartments, Andheri East, Mumbai",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// ☎ ACTIONS
          Row(
            children: [
              _actionButton(Icons.call, "Call", Colors.green),
              const SizedBox(width: 12),
              _actionButton(Icons.chat, "Chat", Colors.orange),
            ],
          ),

          const SizedBox(height: 20),

          /// 🚀 START BUTTON
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "START DELIVERY",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String text, Color color) {
    return Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 6),
            Text(text,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
