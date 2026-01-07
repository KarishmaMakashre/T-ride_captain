import 'package:flutter/material.dart';

import 'driver_dashboard.dart';

enum PostDeliveryStep { delivered, earningsAdded, ratingReceived, backOnline }

class DeliveryCompletedFlowScreen extends StatefulWidget {
  const DeliveryCompletedFlowScreen({super.key});

  @override
  State<DeliveryCompletedFlowScreen> createState() =>
      _DeliveryCompletedFlowScreenState();
}

class _DeliveryCompletedFlowScreenState
    extends State<DeliveryCompletedFlowScreen> {
  PostDeliveryStep currentStep = PostDeliveryStep.delivered;

  // Modern Success Palette
  final Color successColor = const Color(0xFF10B981); // Emerald Green
  final Color goldColor = const Color(0xFFF59E0B); // Amber/Gold
  final Color primaryColor = const Color(0xFF6366F1); // Indigo
  final Color backgroundColor = const Color(0xFFF8FAFC);

  void _nextStep() {
    setState(() {
      if (currentStep.index < PostDeliveryStep.values.length - 1) {
        currentStep = PostDeliveryStep.values[currentStep.index + 1];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                key: ValueKey(currentStep),
                child: _stepContent(),
              ),
            ),
          ),
          _buildBottomAction(),
        ],
      ),
    );
  }

  /// ---------------- MODERN HEADER ----------------
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 24,
        right: 24,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const Text(
            "DELIVERY STATUS",
            style: TextStyle(
              letterSpacing: 1.2,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentStep == PostDeliveryStep.delivered
                ? "Great Job!"
                : "Summary",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 25),
          _PostProgressIndicator(
            currentStep: currentStep,
            activeColor: successColor,
          ),
        ],
      ),
    );
  }

  /// ---------------- STEP CONTENT ----------------
  Widget _stepContent() {
    switch (currentStep) {
      case PostDeliveryStep.delivered:
        return _statusCard(
          icon: Icons.celebration_rounded,
          iconColor: successColor,
          title: "Order Delivered!",
          subtitle: "You've successfully completed order #FD-2847.",
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _miniStat("Distance", "3.4 km"),
                _miniStat("Time Taken", "18 min"),
              ],
            ),
          ),
        );

      case PostDeliveryStep.earningsAdded:
        return _statusCard(
          icon: Icons.account_balance_wallet_rounded,
          iconColor: goldColor,
          title: "Earnings Credited",
          subtitle: "₹120.00 has been added to your balance.",
          child: Column(
            children: [
              _infoRow("Base Pay", "₹80.00"),
              _infoRow("Incentive", "₹20.00"),
              _infoRow("Rain Fee", "₹20.00"),
              const Divider(height: 30),
              _infoRow("Total Earned", "₹120.00", isBold: true),
            ],
          ),
        );

      case PostDeliveryStep.ratingReceived:
        return _statusCard(
          icon: Icons.stars_rounded,
          iconColor: primaryColor,
          title: "5.0 Rating Received",
          subtitle: "Alex Johnson left you a new review",
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryColor.withOpacity(0.1)),
            ),
            child: const Column(
              children: [
                _RatingStars(count: 5),
                SizedBox(height: 12),
                Text(
                  "“Very polite and reached before time. Package was handled with care!”",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF475569),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        );

      case PostDeliveryStep.backOnline:
        return _statusCard(
          icon: Icons.sensors_rounded,
          iconColor: Colors.blue,
          title: "You're Back Online",
          subtitle:
              "Ready for the next delivery? Orders are high in your area!",
          child: Column(
            children: [
              const Text(
                "Today's Progress",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.7,
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(successColor),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "7/10 Deliveries to Goal",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        );
    }
  }

  /// ---------------- UI UTILS ----------------

  Widget _statusCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 48, color: iconColor),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _miniStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isBold ? Colors.black : Colors.grey,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    bool isLast = currentStep == PostDeliveryStep.backOnline;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: isLast
              ? () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PartnerDashboardScreen(),
                  ),
                )
              : _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: isLast ? Colors.black : successColor,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
          ),
          child: Text(
            isLast ? "GO TO DASHBOARD" : "CONTINUE",
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
}

/// ---------------- PROGRESS INDICATOR ----------------
class _PostProgressIndicator extends StatelessWidget {
  final PostDeliveryStep currentStep;
  final Color activeColor;

  const _PostProgressIndicator({
    required this.currentStep,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: PostDeliveryStep.values.map((step) {
        final isActive = step.index <= currentStep.index;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            decoration: BoxDecoration(
              color: isActive ? activeColor : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: activeColor.withOpacity(0.3),
                        blurRadius: 4,
                      ),
                    ]
                  : [],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _RatingStars extends StatelessWidget {
  final int count;

  const _RatingStars({required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star_rounded,
          color: index < count ? const Color(0xFFF59E0B) : Colors.grey.shade300,
          size: 28,
        ),
      ),
    );
  }
}
