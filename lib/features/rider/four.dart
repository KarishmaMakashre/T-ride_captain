import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/five.dart';

class DriverPickupVerificationScreen extends StatefulWidget {
  const DriverPickupVerificationScreen({super.key});

  @override
  State<DriverPickupVerificationScreen> createState() =>
      _DriverPickupVerificationScreenState();
}

class _DriverPickupVerificationScreenState
    extends State<DriverPickupVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  final String correctOtp = "1234";

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    if (otpController.text == correctOtp) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DriverTripInProgressScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Incorrect OTP. Please verify with passenger."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        title: const Text("Pickup Verification"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// 👤 PASSENGER CARD
                  _card(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundImage:
                          NetworkImage("https://i.pravatar.cc/150?img=3"),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Rahul Sharma",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "⭐ 4.8 • 52 trips",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: const [
                            Icon(Icons.verified_user, color: Colors.green),
                            SizedBox(height: 4),
                            Text(
                              "Verified",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(height: 16),

                  /// 📍 PICKUP LOCATION
                  _card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.location_on, color: Colors.green),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pickup Location",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Airport Road, Bhopal (Terminal 2)",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🚕 TRIP SUMMARY
                  _card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _TripStat(title: "Distance", value: "8.4 km"),
                        _TripStat(title: "Fare", value: "₹320"),
                        _TripStat(title: "Payment", value: "Cash"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Enter Trip OTP",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Ask passenger for the OTP to start trip",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 24),

                  /// 🔢 OTP INPUT
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      style: const TextStyle(
                        fontSize: 26,
                        letterSpacing: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "• • • •",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 🛡️ SAFETY NOTE
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.security, color: Colors.orange),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "For your safety, never start the trip without OTP verification.",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🚨 LAST ROW EMERGENCY ICONS (NEW)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _BottomEmergencyIcon(
                        icon: Icons.local_police,
                        label: "Emergency\nPolice",
                        color: Colors.red,
                        onTap: () {},
                      ),
                      _BottomEmergencyIcon(
                        icon: Icons.support_agent,
                        label: "Emergency\nTRYDE",
                        color: Colors.blue,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// 🔘 BOTTOM BUTTON
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: _verifyOtp,
              child: const Text(
                "Verify OTP & Start Trip",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// 🚨 EMERGENCY BUTTON
class _EmergencyButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _EmergencyButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// 🚨 BOTTOM EMERGENCY ICON
class _BottomEmergencyIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _BottomEmergencyIcon({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// 📊 TRIP STAT
class _TripStat extends StatelessWidget {
  final String title;
  final String value;

  const _TripStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
