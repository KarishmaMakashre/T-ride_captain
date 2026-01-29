import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

/// ---------------- ENUM ----------------
enum DeliveryStep {
  navigateToRestaurant,
  reachedRestaurant,
  pickupConfirmed,
  outForDelivery,
  reachedCustomer,
  deliveryOtp,
}

/// ---------------- MAIN SCREEN ----------------
class DeliveryFlowScreen extends StatefulWidget {
  const DeliveryFlowScreen({super.key});

  @override
  State<DeliveryFlowScreen> createState() => _DeliveryFlowScreenState();
}

class _DeliveryFlowScreenState extends State<DeliveryFlowScreen> {
  DeliveryStep currentStep = DeliveryStep.navigateToRestaurant;

  GoogleMapController? mapController;
  Position? currentPosition;

  final TextEditingController otpController = TextEditingController();

  /// dummy coordinates
  final LatLng restaurantLatLng =
      const LatLng(22.7196, 75.8577); // Indore
  final LatLng customerLatLng =
      const LatLng(22.7250, 75.8650);

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  /// ---------------- LOCATION ----------------
  Future<void> _getLocation() async {
    await Geolocator.requestPermission();
    currentPosition = await Geolocator.getCurrentPosition();
    setState(() {});
  }

  /// ---------------- NEXT STEP ----------------
  void _nextStep() {
    if (currentStep == DeliveryStep.deliveryOtp) {
      if (otpController.text.length == 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Delivery Completed 🎉")),
        );
      }
      return;
    }

    setState(() {
      currentStep = DeliveryStep.values[currentStep.index + 1];
    });
  }

  /// ---------------- DESTINATION LOGIC ----------------
  LatLng get destination {
    if (currentStep.index <= DeliveryStep.pickupConfirmed.index) {
      return restaurantLatLng;
    }
    return customerLatLng;
  }

  /// ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          _buildMap(),
          Expanded(child: _buildContent()),
          _buildBottomButton(),
        ],
      ),
    );
  }

  /// ---------------- MAP (ALWAYS VISIBLE) ----------------
  Widget _buildMap() {
    if (currentPosition == null) {
      return const SizedBox(
        height: 280,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: 280,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: destination,
          zoom: 14,
        ),
        myLocationEnabled: true,
        onMapCreated: (controller) => mapController = controller,
        markers: {
          Marker(
            markerId: const MarkerId("destination"),
            position: destination,
          ),
        },
      ),
    );
  }

  /// ---------------- STEP CONTENT ----------------
  Widget _buildContent() {
    switch (currentStep) {
      case DeliveryStep.navigateToRestaurant:
        return _infoCard(
          "Navigate to Restaurant",
          "Proceed to pickup location",
          Icons.restaurant,
        );

      case DeliveryStep.reachedRestaurant:
        return _infoCard(
          "Reached Restaurant",
          "Wait for order preparation",
          Icons.hourglass_bottom,
        );

      case DeliveryStep.pickupConfirmed:
        return _infoCard(
          "Pickup Confirmed",
          "Order collected successfully",
          Icons.check_circle,
        );

      case DeliveryStep.outForDelivery:
        return _infoCard(
          "Out for Delivery",
          "Deliver order to customer",
          Icons.delivery_dining,
        );

      case DeliveryStep.reachedCustomer:
        return _infoCard(
          "Reached Customer",
          "Ask for OTP to complete delivery",
          Icons.person_pin_circle,
        );

      case DeliveryStep.deliveryOtp:
        return _otpView();
    }
  }

  /// ---------------- COMMON INFO CARD ----------------
  Widget _infoCard(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- OTP VIEW ----------------
  Widget _otpView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Enter Delivery OTP",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              letterSpacing: 20,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- BOTTOM BUTTON ----------------
  Widget _buildBottomButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Text(
            currentStep == DeliveryStep.deliveryOtp
                ? "VERIFY & COMPLETE"
                : "CONTINUE",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
