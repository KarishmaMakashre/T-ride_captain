// // payment_success_screen.dart banao

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:go_router/go_router.dart';

// class PaymentSuccessScreen extends StatefulWidget {
//   const PaymentSuccessScreen({super.key});

//   @override
//   State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
// }

// class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> with TickerProviderStateMixin {
//   late final AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//     // 3 seconds baad auto navigate to feedback
//     Future.delayed(const Duration(seconds: 4), () {
//       if (mounted) context.push('/ride-feedback');
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.asset(
//               'assets/animations/payment_success.json', // ya koi green tick animation
//               controller: _controller,
//               onLoaded: (composition) {
//                 _controller.duration = composition.duration;
//                 _controller.forward();
//               },
//               width: 200,
//               height: 200,
//             ),
//             const SizedBox(height: 32),
//             const Text(
//               "Payment Successful!",
//               style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
//             ),
//             const SizedBox(height: 16),
//             const Text("₹29 paid successfully", style: TextStyle(fontSize: 18)),
//             const SizedBox(height: 40),
//             const Text("Redirecting to ride feedback...", style: TextStyle(color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
// }


// payment_success_screen.dart (Improved with better animation and auto-redirect)
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // Auto navigate to feedback after 3 seconds (dummy success)
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.push('/ride-feedback');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/payment_success.json', // Assume you have a success animation
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
              width: 250,
              height: 250,
              repeat: false, // Play once
            ),
            const SizedBox(height: 32),
            const Text(
              "Payment Successful!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 16),
            const Text("₹39 paid successfully", style: TextStyle(fontSize: 18, color: Colors.black87)),
            const SizedBox(height: 40),
            const CircularProgressIndicator(), // Show loading for redirect
            const SizedBox(height: 16),
            const Text("Redirecting to feedback...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}