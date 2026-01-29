import 'package:flutter/material.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/features/food/partner_live_order_screen.dart';
import 'delivery_completed_flow.dart';

const primaryColor = Colors.orange;
const bgColor = Color(0xFFF9F9F9);


class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/topHeaderImage.png",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔥 OVERLAY (optional but recommended)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.08),
            ),
          ),

          /// 🔥 ORDER LIST
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 3,
            itemBuilder: (_, __) => const OrderCard(),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            clipBehavior: Clip.antiAlias, // 🔥 important for bg image
            child: Stack(
              children: [
                /// 🔥 BACKGROUND IMAGE
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/topHeaderImage.png",
                    fit: BoxFit.cover,
                  ),
                ),
        
                /// 🔥 DARK OVERLAY (for readability)
                Positioned.fill(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
        
                /// 🔥 CONTENT
                ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const CircleAvatar(
                    radius: 26,
                    backgroundColor: primaryColor,
                    child: Icon(Icons.fastfood, color: Colors.black45),
                  ),
                  title: const Text(
                    "Domino's Pizza",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: const Text(
                    "Pickup 2.5 km • Drop 5 km",
                    style: TextStyle(color: Colors.black45),
                  ),
                  trailing: const Text(
                    "₹120",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.black45,
                      builder: (_) => const OrderRequestBottomSheet(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ================= ORDER REQUEST BOTTOM SHEET =================
class OrderRequestBottomSheet extends StatelessWidget {
  const OrderRequestBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Stack(
        children: [
          /// 🔥 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/topHeaderImage.png",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔥 GRADIENT OVERLAY (better readability)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black54,
                    Colors.black38,
                    Colors.black26,
                  ],
                ),
              ),
            ),
          ),

          /// 🔥 CONTENT CARD
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Order Request 🚀",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Chip(
                        label: Text("NEW"),
                        backgroundColor: Color(0xFFE8F5E9),
                        labelStyle: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  const OrderDetailTile(
                    icon: Icons.restaurant,
                    title: "Restaurant",
                    value: "Domino's Pizza",
                  ),
                  const OrderDetailTile(
                    icon: Icons.store,
                    title: "Pickup",
                    value: "MG Road, Indore",
                  ),
                  const OrderDetailTile(
                    icon: Icons.location_on,
                    title: "Drop",
                    value: "Vijay Nagar",
                  ),
                  const OrderDetailTile(
                    icon: Icons.route,
                    title: "Distance",
                    value: "5 km",
                  ),
                  const OrderDetailTile(
                    icon: Icons.currency_rupee,
                    title: "Earnings",
                    value: "₹120",
                    highlight: true,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text("Reject"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DeliveryFlowScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            "Accept Order",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= ORDER DETAIL TILE =================
class OrderDetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool highlight;

  const OrderDetailTile({
    required this.icon,
    required this.title,
    required this.value,
    this.highlight = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlight
            ? const Color(0xFFFFF3E0)
            : Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// ICON
          CircleAvatar(
            radius: 22,
            backgroundColor:
            highlight ? Colors.orange : Colors.grey.shade200,
            child: Icon(
              icon,
              size: 20,
              color: highlight ? Colors.white : Colors.black87,
            ),
          ),

          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                    highlight ? FontWeight.bold : FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          /// OPTIONAL HIGHLIGHT ICON
          if (highlight)
            const Icon(
              Icons.trending_up,
              color: Colors.orange,
              size: 20,
            ),
        ],
      ),
    );
  }
}


/// ================= NAVIGATION SCREEN =================
class NavigateToRestaurantScreen extends StatelessWidget {
  const NavigateToRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 BACKGROUND IMAGE
          // Positioned.fill(
          //   child: Image.asset(
          //     "assets/images/topHeaderImage.png", // or network image
          //     fit: BoxFit.cover,
          //   ),
          // ),

          /// 🔥 DARK OVERLAY
          // Positioned.fill(
          //   child: Container(
          //     color: Colors.black.withOpacity(0.45),
          //   ),
          // ),

          /// 🔥 CONTENT
          SafeArea(
            child: Column(
              children: [
                /// APP BAR
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "Navigate to Restaurant",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                /// CENTER CARD
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.navigation,
                        size: 80,
                        color: Colors.orange,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Navigation Started 🚗",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Proceed to restaurant pickup location",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



enum DeliveryStep {
  navigateToRestaurant,
  reachedRestaurant,
  pickupConfirmed,
  outForDelivery,
  reachedCustomer,
  deliveryOtp,
}


/// ---------------- DELIVERY FLOW SCREEN ----------------
class DeliveryFlowScreen extends StatefulWidget {
  const DeliveryFlowScreen({super.key});

  @override
  State<DeliveryFlowScreen> createState() => _DeliveryFlowScreenState();
}

class _DeliveryFlowScreenState extends State<DeliveryFlowScreen> {
  DeliveryStep currentStep = DeliveryStep.navigateToRestaurant;
  final TextEditingController otpController = TextEditingController();

  final Color primaryColor = const Color(0xFF6366F1);

  void _nextStep() {
    if (currentStep == DeliveryStep.deliveryOtp) {
      _handleOtpVerification();
      return;
    }

    setState(() {
      currentStep =
      DeliveryStep.values[(currentStep.index + 1).clamp(0, 5)];
    });
  }

  void _handleOtpVerification() {
    if (otpController.text.length == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DeliveryCompletedFlowScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid 4-digit OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 BACKGROUND IMAGE
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/topHeaderImage.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🔥 DARK OVERLAY
          Container(color: Colors.black.withOpacity(0.45)),

          /// 🔥 MAIN CONTENT
          Column(
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
        ],
      ),
    );
  }

  /// ---------------- HEADER ----------------
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ACTIVE DELIVERY",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Order #FD-2847",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Chip(
            label: Text("ON TIME"),
            backgroundColor: Color(0xFFE8F5E9),
            labelStyle: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }

  /// ---------------- BOTTOM BUTTON ----------------
  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: ElevatedButton(
        onPressed: _nextStep,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 55),
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
    );
  }

  /// ---------------- STEP CONTENT ----------------
  Widget _stepContent(DeliveryStep step) {
    switch (step) {
      case DeliveryStep.navigateToRestaurant:
        return _infoCard("Navigate to Restaurant", Icons.restaurant);
      case DeliveryStep.reachedRestaurant:
        return _infoCard("Reached Restaurant", Icons.store);
      case DeliveryStep.pickupConfirmed:
        return _infoCard("Pickup Confirmed", Icons.check_circle);
      case DeliveryStep.outForDelivery:
        return _infoCard("Out for Delivery", Icons.delivery_dining);
      case DeliveryStep.reachedCustomer:
        return _infoCard("Reached Customer", Icons.location_on);
      case DeliveryStep.deliveryOtp:
        return _otpCard();
    }
  }

  Widget _infoCard(String title, IconData icon) {
    return Container(
      key: ValueKey(title),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(icon, size: 60, color: primaryColor),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _otpCard() {
    return Container(
      key: const ValueKey("otp"),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text(
            "Enter Delivery OTP",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: otpController,
            maxLength: 4,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 28,
              letterSpacing: 10,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(counterText: ""),
          ),
        ],
      ),
    );
  }
}

/// ---------------- DELIVERY COMPLETED SCREEN ----------------
class DeliveryCompletedFlowScreen extends StatelessWidget {
  const DeliveryCompletedFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "Delivery Completed 🎉",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Thank you for completing the order",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}



