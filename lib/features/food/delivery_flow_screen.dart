// import 'package:flutter/material.dart';
//
// import 'delivery_completed_flow.dart';
//
// enum DeliveryStep {
//   navigateToRestaurant,
//   reachedRestaurant,
//   pickupConfirmed,
//   reachedCustomer,
//   deliveryOtp,
// }
//
// class DeliveryFlowScreen extends StatefulWidget {
//   const DeliveryFlowScreen({super.key});
//
//   @override
//   State<DeliveryFlowScreen> createState() => _DeliveryFlowScreenState();
// }
//
// class _DeliveryFlowScreenState extends State<DeliveryFlowScreen> {
//   DeliveryStep currentStep = DeliveryStep.navigateToRestaurant;
//   final TextEditingController otpController = TextEditingController();
//
//   // Modern Theme Colors
//   final Color primaryColor = const Color(0xFFFF6B6B); // Indigo
//   static const Color accentColor = Color.fromARGB(255, 255, 175, 175);
//   final Color backgroundColor = const Color(0xFFF8FAFC);
//
//   // Update the _nextStep function
//   void _nextStep() {
//     if (currentStep == DeliveryStep.deliveryOtp) {
//       _handleOtpVerification();
//       return;
//     }
//
//     setState(() {
//       if (currentStep.index < DeliveryStep.values.length - 1) {
//         currentStep = DeliveryStep.values[currentStep.index + 1];
//       }
//     });
//   }
//
//   // New function to handle OTP and Navigation
//   void _handleOtpVerification() {
//     if (otpController.text.length == 4) {
//       // Success Haptic/Feedback could be added here
//       Navigator.push(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) =>
//               const DeliveryCompletedFlowScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(
//               opacity: animation,
//               child: SlideTransition(
//                 position: animation.drive(
//                   Tween(
//                     begin: const Offset(0, 0.1),
//                     end: Offset.zero,
//                   ).chain(CurveTween(curve: Curves.easeOutQuart)),
//                 ),
//                 child: child,
//               ),
//             );
//           },
//           transitionDuration: const Duration(milliseconds: 600),
//         ),
//       );
//     } else {
//       // Basic validation feedback
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text("Please enter a valid 4-digit OTP"),
//           backgroundColor: Colors.redAccent,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//     }
//   }
//
//   // Ensure the button text updates correctly in _buildBottomAction
//   Widget _buildBottomAction() {
//     return Container(
//       padding: const EdgeInsets.all(25),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
//       ),
//       child: SafeArea(
//         top: false,
//         child: ElevatedButton(
//           onPressed: _nextStep,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: currentStep == DeliveryStep.deliveryOtp
//                 ? Colors
//                       .green // Change color for the final action
//                 : primaryColor,
//             minimumSize: const Size(double.infinity, 60),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             elevation: 0,
//           ),
//           child: Text(
//             currentStep == DeliveryStep.deliveryOtp
//                 ? "VERIFY & COMPLETE"
//                 : "CONTINUE",
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 1.1,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Column(
//         children: [
//           _buildHeader(context),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 400),
//                 // child: _stepContent(currentStep),
//               ),
//             ),
//           ),
//           _buildBottomAction(),
//         ],
//       ),
//     );
//   }
//
//   /// ---------------- MODERN HEADER ----------------
//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).padding.top + 10,
//         left: 20,
//         right: 20,
//         bottom: 30,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "ACTIVE DELIVERY",
//                     style: TextStyle(
//                       letterSpacing: 1.2,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Text(
//                     "Order #FD-2847",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w900,
//                       color: Color(0xFF1E293B),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 8,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text(
//                   "ON TIME",
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 25),
//           _ProgressStepper(currentStep: currentStep, activeColor: primaryColor),
//         ],
//       ),
//     );
//   }
//
//   /// ---------------- CONTENT LOGIC ----------------
//   // Widget _stepContent(DeliveryStep step) {
//   //   switch (step) {
//   //     case DeliveryStep.navigateToRestaurant:
//   //       return _buildLocationCard(
//   //         title: "Pickup Point",
//   //         name: "Burger King - MG Road",
//   //         address: "Sector 4, Near Metro Station",
//   //         distance: "1.2 km",
//   //         eta: "5 mins",
//   //         icon: Icons.restaurant,
//   //       );
//   //     case DeliveryStep.reachedRestaurant:
//   //       return _buildInfoCard(
//   //         "Waiting for Kitchen",
//   //         "Order is being prepared. Please wait at the designated pickup counter.",
//   //         Icons.hourglass_bottom_rounded,
//   //         accentColor,
//   //       );
//   //     case DeliveryStep.pickupConfirmed:
//   //       return _buildChecklistCard();
//   //
//   //     case DeliveryStep.reachedCustomer:
//   //       return _buildLocationCard(
//   //         title: "Delivery Point",
//   //         name: "Alex Johnson",
//   //         address: "Apt 4B, Sunset Boulevard",
//   //         distance: "0.2 km",
//   //         eta: "Now",
//   //         icon: Icons.person_pin_circle,
//   //       );
//   //     case DeliveryStep.deliveryOtp:
//   //       return _buildOtpEntry();
//   //   }
//   // }
//
//   /// ---------------- STYLISH COMPONENTS ----------------
//
//   Widget _buildLocationCard({
//     required String title,
//     required String name,
//     required String address,
//     required String distance,
//     required String eta,
//     required IconData icon,
//   }) {
//     return Column(
//       children: [
//         Container(
//           height: 180,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(24),
//             image: const DecorationImage(
//               image: NetworkImage(
//                 'https://media.istockphoto.com/id/1189064346/photo/city-map-with-pin-pointers-3d-rendering-image.webp?a=1&b=1&s=612x612&w=0&k=20&c=ATkI2VsMyZ2K4zk-Qq12g6cRpO2VJvt6UPPDb_sshSg='
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const SizedBox(height: 80),
//         _detailTile(title, name, address),
//       ],
//     );
//   }
//
//   Widget _buildCustomerCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         children: [
//           const CircleAvatar(
//             radius: 40,
//             backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a'),
//           ),
//           const SizedBox(height: 15),
//           const Text(
//             "Alex Johnson",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const Text(
//             "Regular Customer • 4.9 ★",
//             style: TextStyle(color: Colors.grey),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(child: _actionBtn(Icons.call, "Call", Colors.green)),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _actionBtn(Icons.chat_bubble, "Message", primaryColor),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOtpEntry() {
//     return Column(
//       children: [
//         const Text(
//           "Verify Delivery",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         const Text(
//           "Enter the 4-digit code provided by the customer",
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.grey),
//         ),
//         const SizedBox(height: 30),
//         TextField(
//           controller: otpController,
//           textAlign: TextAlign.center,
//           keyboardType: TextInputType.number,
//           maxLength: 4,
//           style: const TextStyle(
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 20,
//           ),
//           decoration: InputDecoration(
//             counterText: "",
//             filled: true,
//             fillColor: Colors.white,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: BorderSide(color: Colors.grey.shade200),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: BorderSide(color: primaryColor, width: 2),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _detailTile(String label, String main, String sub) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: primaryColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Image.network(
//               "https://cdn-icons-png.flaticon.com/512/684/684908.png",
//               width: 28,
//               height: 28,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label,
//                     style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold)),
//                 Text(main,
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//                 Text(sub,
//                     style:
//                     TextStyle(fontSize: 14, color: Colors.grey.shade600)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _actionBtn(IconData icon, String label, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       decoration: BoxDecoration(
//         border: Border.all(color: color.withOpacity(0.2)),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 18, color: color),
//           const SizedBox(width: 8),
//           Text(
//             label,
//             style: TextStyle(color: color, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoCard(String title, String desc, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(30),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, size: 60, color: color),
//           const SizedBox(height: 20),
//           Text(
//             title,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             desc,
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: Colors.grey, height: 1.5),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildChecklistCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Verify Items",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 15),
//           _checkItem("1x Whopper Burger"),
//           _checkItem("1x Large Fries"),
//           _checkItem("1x Coke Zero"),
//           const Divider(height: 30),
//           const Row(
//             children: [
//               Icon(Icons.verified_user, color: Colors.blue, size: 20),
//               SizedBox(width: 8),
//               Text(
//                 "Order is sealed & tagged",
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _checkItem(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           const Icon(Icons.check_circle, color: Colors.green, size: 20),
//           const SizedBox(width: 10),
//           Text(text),
//         ],
//       ),
//     );
//   }
// }
//
// /// ---------------- PROGRESS STEPPER COMPONENT ----------------
// class _ProgressStepper extends StatelessWidget {
//   final DeliveryStep currentStep;
//   final Color activeColor;
//
//   const _ProgressStepper({
//     required this.currentStep,
//     required this.activeColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(DeliveryStep.values.length, (index) {
//         bool isPast = index < currentStep.index;
//         bool isCurrent = index == currentStep.index;
//
//         return Expanded(
//           child: Row(
//             children: [
//               Container(
//                 width: 12,
//                 height: 12,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: isPast || isCurrent
//                       ? activeColor
//                       : Colors.grey.shade300,
//                   boxShadow: isCurrent
//                       ? [
//                           BoxShadow(
//                             color: activeColor.withOpacity(0.4),
//                             blurRadius: 8,
//                             spreadRadius: 2,
//                           ),
//                         ]
//                       : [],
//                 ),
//               ),
//               if (index != DeliveryStep.values.length - 1)
//                 Expanded(
//                   child: Container(
//                     height: 3,
//                     margin: const EdgeInsets.symmetric(horizontal: 4),
//                     decoration: BoxDecoration(
//                       color: isPast ? activeColor : Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'delivery_completed_flow.dart';
import 'order_req_screen.dart' as AppTheme;

enum DeliveryStep {
  navigateToRestaurant,
  reachedRestaurant,
  pickupConfirmed,
  navigateToCustomer,
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

  // Colors (Swiggy-inspired orange-red theme)
  final Color primaryColor = const Color(0xFFFC8019); // Swiggy Orange
  final Color accentColor = const Color(0xFFFF6B6B);
  final Color backgroundColor = Colors.white;

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

  void _handleOtpVerification() {
    if (otpController.text.length == 4) {
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
                  Tween(begin: const Offset(0, 0.1), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeOutQuart)),
                ),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 4-digit OTP")),
      );
    }
  }

  // Bottom persistent button (like Swiggy/Zomato)
  Widget _buildBottomButton() {
    String buttonText;
    Color buttonColor = primaryColor;

    if (currentStep == DeliveryStep.reachedRestaurant ||
        currentStep == DeliveryStep.reachedCustomer) {
      buttonText = "I HAVE ARRIVED";
    } else if (currentStep == DeliveryStep.pickupConfirmed) {
      buttonText = "CONFIRM PICKUP";
    } else if (currentStep == DeliveryStep.deliveryOtp) {
      buttonText = "VERIFY & COMPLETE";
      buttonColor = Colors.green;
    } else {
      buttonText = "NAVIGATE";
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Content based on step (shown in draggable bottom sheet)
  Widget _buildSheetContent() {
    switch (currentStep) {
      case DeliveryStep.navigateToRestaurant:
      case DeliveryStep.reachedRestaurant:
        return _buildRestaurantDetails();
      case DeliveryStep.pickupConfirmed:
        return _buildChecklistCard();
      case DeliveryStep.navigateToCustomer:
      case DeliveryStep.reachedCustomer:
        return _buildCustomerDetails();
      case DeliveryStep.deliveryOtp:
        return _buildOtpEntry();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen Map Image (placeholder for actual Google Maps)
          Image.network(
            'https://media.istockphoto.com/id/1189064346/photo/city-map-with-pin-pointers-3d-rendering-image.webp?a=1&b=1&s=612x612&w=0&k=20&c=ATkI2VsMyZ2K4zk-Qq12g6cRpO2VJvt6UPPDb_sshSg=',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          ),

          // Top status info (Order ID, Earnings, etc. - minimal like Swiggy)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order #FD-2847", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text("₹180 • 2.4 km", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("ON TIME", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Draggable Bottom Sheet (like Swiggy/Zomato)
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.25,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 100), // Extra bottom for button
                    child: _buildSheetContent(),
                  ),
                ),
              );
            },
          ),

          // Persistent Bottom Button
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomButton(),
          ),
        ],
      ),
    );
  }

  // Restaurant Details (with contact & call button)
  Widget _buildRestaurantDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pickup from", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Burger King - MG Road", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text("Sector 4, Near Metro Station", style: TextStyle(color: Colors.grey.shade700)),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.phone, color: AppTheme.primaryColor),
                  const SizedBox(width: 8),
                  const Text("+91 98765 43210", style: TextStyle(fontWeight: FontWeight.w600)),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {}, // Add actual call logic
                    icon: const Icon(Icons.call, size: 18),
                    label: const Text("CALL RESTAURANT"),
                    style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text("Estimated arrival: 5 mins • 1.2 km away"),
      ],
    );
  }

  // Customer Details
  Widget _buildCustomerDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Deliver to", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a')),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Alex Johnson", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("Apt 4B, Sunset Boulevard"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.call), label: const Text("CALL"))),
                  const SizedBox(width: 12),
                  Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.message), label: const Text("MESSAGE"))),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text("0.2 km away • Arriving now"),
      ],
    );
  }

  // OTP Entry
  Widget _buildOtpEntry() {
    return Column(
      children: [
        const Text("Enter Customer OTP", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text("Ask the customer for the 4-digit code", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 30),
        TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 32, letterSpacing: 20, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  // Checklist for Pickup Confirmation
  Widget _buildChecklistCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Verify Items Before Pickup", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              _checkItem("1x Whopper Burger"),
              _checkItem("1x Large Fries"),
              _checkItem("1x Coke Zero"),
              const Divider(),
              const Row(
                children: [
                  Icon(Icons.verified, color: Colors.green),
                  SizedBox(width: 8),
                  Text("Package sealed & tagged", style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _checkItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 12),
          Text(text),
        ],
      ),
    );
  }
}