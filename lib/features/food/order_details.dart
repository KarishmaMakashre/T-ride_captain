import 'package:flutter/material.dart';
import '../../core/constants/color_constants.dart';
import 'driver_dashboard.dart';
import 'oder_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool pickedUp = false;
  bool showOtp = false;

  final TextEditingController otpCtrl = TextEditingController();
  final String correctOtp = "1234";

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.grey100,

        appBar: AppBar(
          title: const Text("Active Order"),
          backgroundColor: AppColors.white,
          elevation: 0.8,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// 🔽 FIXED BOTTOM BUTTON
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: _actionButton(),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _statusCard(),
              const SizedBox(height: 16),
              _restaurantCard(),
              const SizedBox(height: 16),
              _customerCard(),
              const SizedBox(height: 16),
              if (showOtp) _otpSection(),
              SizedBox(height: h * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  /// 🚦 STATUS
  Widget _statusCard() {
    return _card(
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.foodPrimary.withOpacity(0.15),
            child: Icon(
              pickedUp ? Icons.delivery_dining : Icons.store,
              color: AppColors.foodPrimary,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              !pickedUp
                  ? "Pickup order from restaurant"
                  : showOtp
                  ? "Ask customer for delivery OTP"
                  : "Reached customer location",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🏪 RESTAURANT
  Widget _restaurantCard() {
    return _infoRowCard(
      icon: Icons.restaurant,
      title: "Biryani House",
      subtitle: "Downtown, Bangalore",
    );
  }

  /// 👤 CUSTOMER
  Widget _customerCard() {
    return _infoRowCard(
      icon: Icons.person,
      title: "Amit Verma",
      subtitle: "HSR Layout, Sector 7",
    );
  }


  /// 🔐 OTP
  Widget _otpSection() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter Delivery OTP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: otpCtrl,
            keyboardType: TextInputType.number,
            maxLength: 4,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              letterSpacing: 10,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: "",
              hintText: "• • • •",
              filled: true,
              fillColor: AppColors.grey100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ BUTTON
  Widget _actionButton() {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.foodPrimary,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: _handleAction,
        child: Text(
          !pickedUp
              ? "MARK AS PICKED UP"
              : showOtp
              ? "VERIFY OTP & COMPLETE"
              : "REACHED CUSTOMER",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  void _handleAction() {
    if (!pickedUp) {
      setState(() => pickedUp = true);
    } else if (!showOtp) {
      setState(() => showOtp = true);
    } else {
      _verifyOtp();
    }
  }

  /// 🎉 OTP VERIFY
  void _verifyOtp() {
    if (otpCtrl.text == correctOtp) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const PaymentProcessingScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP ❌"),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }


  /// 🎨 COMMON CARD
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  /// ℹ️ INFO ROW CARD
  Widget _infoRowCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return _card(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.foodPrimary,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.call, color: Colors.green),
        ],
      ),
    );
  }
}


class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  bool showQr = false;
  bool showRating = false;
  int rating = 0;
  final TextEditingController feedbackCtrl = TextEditingController();

  void goToDashboard() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const PartnerDashboardScreen(),
      ),
          (route) => false,
    );
  }

  /// CASH DIALOG
  void showCashDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Cash Payment"),
        content: const Text("Please collect cash from customer."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                showRating = true;
              });
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.foodPrimary,
        iconTheme: const IconThemeData(
          color: Colors.white, // back icon color
        ),
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.white, // title text color
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: showRating
            ? _ratingView()
            : showQr
            ? _qrView()
            : _paymentOptions(),
      ),
    );
  }

  /// PAYMENT OPTIONS
  Widget _paymentOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Choose Payment Method",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),

        _paymentButton(
          icon: Icons.qr_code_2,
          title: "Online Payment",
          subtitle: "UPI / QR Scan",
          color: AppColors.foodPrimary,
          onTap: () {
            setState(() {
              showQr = true;
            });
          },
        ),

        const SizedBox(height: 16),

        _paymentButton(
          icon: Icons.payments_outlined,
          title: "Cash Payment",
          subtitle: "Pay by cash",
          color: Colors.green,
          onTap: showCashDialog,
        ),
      ],
    );
  }

  /// QR VIEW
  Widget _qrView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Scan QR to Pay",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),

        Container(
          height: 220,
          width: 220,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.qr_code, size: 120),
        ),

        const SizedBox(height: 30),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.foodPrimary,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            setState(() {
              showQr = false;
              showRating = true;
            });
          },
          child: const Text("Payment Successful"),
        ),
      ],
    );
  }

  /// ⭐ RATING VIEW
  Widget _ratingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle,
            color: Colors.green, size: 80),

        const SizedBox(height: 16),

        const Text(
          "Payment Successful",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        const Text("Rate your experience"),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  rating = index + 1;
                });
              },
              icon: Icon(
                Icons.star,
                color: index < rating ? Colors.orange : Colors.grey,
                size: 32,
              ),
            );
          }),
        ),


        TextField(
          controller: feedbackCtrl,
          decoration: InputDecoration(
            hintText: "Write feedback (optional)",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 20),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: rating > 0
                ? AppColors.foodPrimary
                : Colors.grey.shade400,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: rating > 0 ? goToDashboard : null,
          child: const Text("Submit & Continue"),
        ),

      ],
    );
  }

  /// COMMON BUTTON
  Widget _paymentButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  Text(subtitle,
                      style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
