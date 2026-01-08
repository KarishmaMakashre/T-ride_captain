import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/features/rider/five.dart';
import '../../../../core/constants/color_constants.dart';

class PickupVerificationMapScreen extends StatefulWidget {
  const PickupVerificationMapScreen({super.key});

  @override
  State<PickupVerificationMapScreen> createState() =>
      _PickupVerificationMapScreenState();
}

class _PickupVerificationMapScreenState
    extends State<PickupVerificationMapScreen> {
  gmaps.GoogleMapController? _mapController;
  final TextEditingController _otpController = TextEditingController();

  // 📍 DEFAULT IND0RE LOCATION
  final gmaps.LatLng pickupLatLng = const gmaps.LatLng(22.719568, 75.857727);

  final String pickupAddress = "Vijay Nagar Square, Indore";

  final String correctOtp = "1234";
  bool isOtpVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🗺️ GOOGLE MAP
          Positioned.fill(
            child: gmaps.GoogleMap(
              initialCameraPosition: gmaps.CameraPosition(
                target: pickupLatLng,
                zoom: 16,
              ),
              onMapCreated: (controller) => _mapController = controller,
              markers: {
                gmaps.Marker(
                  markerId: const gmaps.MarkerId('pickup'),
                  position: pickupLatLng,
                  icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(
                    gmaps.BitmapDescriptor.hueGreen,
                  ),
                ),
              },
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),

          /// 🔙 BACK BUTTON
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ),

          /// ⬆️ BOTTOM SHEET
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.58,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
              ),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _pickupAddress(),
                    const SizedBox(height: 16),
                    _ownerDetails(),
                    const SizedBox(height: 16),
                    _receiverDetails(),
                    const SizedBox(height: 20),
                    _goodsSummary(),
                    const SizedBox(height: 16),
                    _otpInput(),
                    const SizedBox(height: 24),
                    _startRideButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 📍 PICKUP ADDRESS
  Widget _pickupAddress() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, color: Colors.green),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            pickupAddress,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  /// 👤 OWNER DETAILS
  Widget _ownerDetails() {
    return SizedBox(
      width: double.infinity, // 🔥 SAME WIDTH
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: _card(),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rahul Sharma',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Goods Owner', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.call, color: Colors.green),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _goodsSummary() {
    return SizedBox(
      width: double.infinity, // 🔥 SAME WIDTH
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: _card(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Goods Summary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text('• Bed, Table, Chairs'),
            Text('• Weight: 120 kg'),
            Text('• Fragile items included'),
          ],
        ),
      ),
    );
  }


  /// 🔐 OTP INPUT
  Widget _otpInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter Pickup OTP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _otpController,
          maxLength: 4,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '4 Digit OTP',
            counterText: '',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _verifyOtp,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 46),
          ),
          child: const Text('Verify OTP'),
        ),
      ],
    );
  }

  /// 🚚 START RIDE
  Widget _startRideButton() {
    return ElevatedButton(
      onPressed: isOtpVerified ? _startRide : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: Colors.grey,
        minimumSize: const Size(double.infinity, 54),
      ),
      child: const Text('START RIDE', style: TextStyle(fontSize: 18)),
    );
  }

  /// 🔐 OTP LOGIC
  void _verifyOtp() {
    if (_otpController.text == correctOtp) {
      setState(() => isOtpVerified = true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OTP Verified ✅')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid OTP ❌')));
    }
  }

  void _startRide() {
    // context.pushNamed('track-ride');
    // context.pushNamed(
    //   'track-ride',
    //   extra: {
    //     'currentLatLng': widget.currentLatLng,
    //     'destinationLatLng': widget.destinationLatLng,
    //     'originAddress': widget.originAddress,
    //     'destinationAddress': widget.destinationAddress,
    //   },
    // );
    // DriverTripInProgressScreen();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DriverTripInProgressScreen(),
      ),
    );
  }

  BoxDecoration _card() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      color: Colors.white,
    );
  }

  /// 📦 RECEIVER DETAILS
  final String receiverName = "Amit Verma";
  final String receiverAddress = "MP Nagar Zone 1, Bhopal";
  final String receiverMobile = "+91 9876543210";

  void _callReceiver() async {
    final uri = Uri.parse('tel:$receiverMobile');
    // use url_launcher package
  }

  Widget _receiverDetails() {
    return Material(
      color: Colors.white, // 🔥 IMPORTANT
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: _card(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Receiver Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.home, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receiverName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Colors.black, // 🔥 red hata ke test ke liye black
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        receiverAddress,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Text(
                        receiverMobile,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.call, color: Colors.green),
                  onPressed: _callReceiver,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
