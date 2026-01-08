import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tryde_partner/features/food/order_details.dart';
import '../../core/constants/color_constants.dart';
import 'delivery_flow_screen.dart';

class OrderRequestScreen extends StatefulWidget {
  const OrderRequestScreen({super.key});

  @override
  State<OrderRequestScreen> createState() => _OrderRequestScreenState();
}

class _OrderRequestScreenState extends State<OrderRequestScreen> {
  int _seconds = 15;
  Timer? _timer;
  bool _handled = false; // 🔥 prevent double actions

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
        _onReject(auto: true);
      } else {
        setState(() => _seconds--);
      }
    });
  }

  /// ✅ ACCEPT ORDER
  void _onAccept() {
    if (_handled) return;
    _handled = true;

    _timer?.cancel();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Order Accepted 🚀"),
        backgroundColor: AppColors.success,
      ),
    );

    /// 🔥 Navigate to Active Order screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const DeliveryFlowScreen(),
      ),
    );
  }

  /// ❌ REJECT ORDER
  void _onReject({bool auto = false}) {
    if (_handled) return;
    _handled = true;

    _timer?.cancel();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(auto
            ? "Order auto rejected ⏱"
            : "Order Rejected ❌"),
        backgroundColor: AppColors.error,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔔 HEADER
                  Row(
                    children: const [
                      Icon(Icons.notifications_active,
                          color: AppColors.foodPrimary),
                      SizedBox(width: 8),
                      Text(
                        "NEW ORDER RECEIVED!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 24),

                  /// 📦 ORDER DETAILS
                  _infoRow("Restaurant", "Biryani House (Downtown)"),
                  _infoRow("Distance", "1.2 km away"),
                  _infoRow(
                      "Drop Location", "HSR Layout, Sector 7 (4.5 km)"),
                  _infoRow(
                    "Estimated Earning",
                    "₹65.00",
                    valueColor: AppColors.success,
                  ),
                  _infoRow(
                      "Items", "2x Chicken Biryani, 1x Coke"),

                  const SizedBox(height: 20),

                  /// ⏱ TIMER
                  Center(
                    child: Text(
                      "⏱ $_seconds seconds remaining",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _seconds <= 5
                            ? AppColors.error
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ❌ ✅ ACTION BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.close,
                              color: Colors.red),
                          label: const Text(
                            "REJECT",
                            style: TextStyle(color: Colors.red),
                          ),
                          style: OutlinedButton.styleFrom(
                            side:
                            const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14),
                          ),
                          onPressed: () => _onReject(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.check),
                          label: const Text("ACCEPT"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            AppColors.success,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _onAccept,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 📄 INFO ROW
  Widget _infoRow(String title, String value,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$title:",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
