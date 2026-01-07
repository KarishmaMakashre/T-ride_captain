import 'package:flutter/material.dart';

import 'delivery_completed_flow.dart';

enum DeliveryStep {
  navigateToRestaurant,
  reachedRestaurant,
  pickupConfirmed,
  outForDelivery,
  reachedCustomer,
  deliveryOtp,
}

class DeliveryFlowScreen extends StatefulWidget {
  const DeliveryFlowScreen({super.key});

  @override
  State<DeliveryFlowScreen> createState() => _DeliveryFlowScreenState();
}

class _DeliveryFlowScreenState extends State<DeliveryFlowScreen> {
  DeliveryStep currentStep = DeliveryStep.navigateToRestaurant;
  final TextEditingController otpController = TextEditingController();

  // Modern Theme Colors
  final Color primaryColor = const Color(0xFF6366F1); // Indigo
  final Color accentColor = const Color(0xFFF59E0B); // Amber
  final Color backgroundColor = const Color(0xFFF8FAFC);

  // Update the _nextStep function
  void _nextStep() {
    if (currentStep == DeliveryStep.deliveryOtp) {
      _handleOtpVerification();
      return;
    }

    setState(() {
      if (currentStep.index < DeliveryStep.values.length - 1) {
        currentStep = DeliveryStep.values[currentStep.index + 1];
      }
    });
  }

  // New function to handle OTP and Navigation
  void _handleOtpVerification() {
    if (otpController.text.length == 4) {
      // Success Haptic/Feedback could be added here
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const DeliveryCompletedFlowScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeOutQuart)),
                ),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    } else {
      // Basic validation feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please enter a valid 4-digit OTP"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  // Ensure the button text updates correctly in _buildBottomAction
  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: currentStep == DeliveryStep.deliveryOtp
                ? Colors
                      .green // Change color for the final action
                : primaryColor,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
          ),
          child: Text(
            currentStep == DeliveryStep.deliveryOtp
                ? "VERIFY & COMPLETE"
                : "CONTINUE",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _stepContent(currentStep),
              ),
            ),
          ),
          _buildBottomAction(),
        ],
      ),
    );
  }

  /// ---------------- MODERN HEADER ----------------
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        bottom: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ACTIVE DELIVERY",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Order #FD-2847",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "ON TIME",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          _ProgressStepper(currentStep: currentStep, activeColor: primaryColor),
        ],
      ),
    );
  }

  /// ---------------- CONTENT LOGIC ----------------
  Widget _stepContent(DeliveryStep step) {
    switch (step) {
      case DeliveryStep.navigateToRestaurant:
        return _buildLocationCard(
          title: "Pickup Point",
          name: "Burger King - MG Road",
          address: "Sector 4, Near Metro Station",
          distance: "1.2 km",
          eta: "5 mins",
          icon: Icons.restaurant,
        );
      case DeliveryStep.reachedRestaurant:
        return _buildInfoCard(
          "Waiting for Kitchen",
          "Order is being prepared. Please wait at the designated pickup counter.",
          Icons.hourglass_bottom_rounded,
          accentColor,
        );
      case DeliveryStep.pickupConfirmed:
        return _buildChecklistCard();
      case DeliveryStep.outForDelivery:
        return _buildCustomerCard();
      case DeliveryStep.reachedCustomer:
        return _buildLocationCard(
          title: "Delivery Point",
          name: "Alex Johnson",
          address: "Apt 4B, Sunset Boulevard",
          distance: "0.2 km",
          eta: "Now",
          icon: Icons.person_pin_circle,
        );
      case DeliveryStep.deliveryOtp:
        return _buildOtpEntry();
    }
  }

  /// ---------------- STYLISH COMPONENTS ----------------

  Widget _buildLocationCard({
    required String title,
    required String name,
    required String address,
    required String distance,
    required String eta,
    required IconData icon,
  }) {
    return Column(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: NetworkImage('https://api.placeholder.com/400/200'),
              // Replace with actual Map snapshot
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Icon(Icons.location_on, color: primaryColor, size: 40),
          ),
        ),
        const SizedBox(height: 20),
        _detailTile(title, name, address, icon),
      ],
    );
  }

  Widget _buildCustomerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a'),
          ),
          const SizedBox(height: 15),
          const Text(
            "Alex Johnson",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Regular Customer • 4.9 ★",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _actionBtn(Icons.call, "Call", Colors.green)),
              const SizedBox(width: 12),
              Expanded(
                child: _actionBtn(Icons.chat_bubble, "Message", primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtpEntry() {
    return Column(
      children: [
        const Text(
          "Verify Delivery",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "Enter the 4-digit code provided by the customer",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 30),
        TextField(
          controller: otpController,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 4,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 20,
          ),
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _detailTile(String label, String main, String sub, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  main,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  sub,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(icon, size: 60, color: color),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Verify Items",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _checkItem("1x Whopper Burger"),
          _checkItem("1x Large Fries"),
          _checkItem("1x Coke Zero"),
          const Divider(height: 30),
          const Row(
            children: [
              Icon(Icons.verified_user, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Text(
                "Order is sealed & tagged",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _checkItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}

/// ---------------- PROGRESS STEPPER COMPONENT ----------------
class _ProgressStepper extends StatelessWidget {
  final DeliveryStep currentStep;
  final Color activeColor;

  const _ProgressStepper({
    required this.currentStep,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(DeliveryStep.values.length, (index) {
        bool isPast = index < currentStep.index;
        bool isCurrent = index == currentStep.index;

        return Expanded(
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPast || isCurrent
                      ? activeColor
                      : Colors.grey.shade300,
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: activeColor.withOpacity(0.4),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
              ),
              if (index != DeliveryStep.values.length - 1)
                Expanded(
                  child: Container(
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isPast ? activeColor : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
