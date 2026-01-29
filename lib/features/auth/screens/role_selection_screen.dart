import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryde_partner/features/auth/screens/registration_screen.dart';

class PartnerTypeSelectionScreen extends StatefulWidget {
  const PartnerTypeSelectionScreen({super.key});

  @override
  State<PartnerTypeSelectionScreen> createState() =>
      _PartnerTypeSelectionScreenState();
}

class _PartnerTypeSelectionScreenState extends State<PartnerTypeSelectionScreen> {
  String? _selected = 'rider';

  final List<Map<String, dynamic>> _partners = [
    {
      'id': 'rider',
      'title': 'Rider Partner',
      'subtitle': 'Drive with TRYDE',
      'icon': Icons.directions_car_filled_rounded,
      'color': const Color(0xff3177D0),
      'iconBg': const Color(0xffE8F2FF),
    },
    {
      'id': 'porter',
      'title': 'Porter Partner',
      'subtitle': 'Deliver with TRYDE',
      'icon': Icons.local_shipping_rounded,
      'color': const Color(0xff6339A6),
      'iconBg': const Color(0xffF0E8FF),
    },
    {
      'id': 'food',
      'title': 'Food Delivery',
      'subtitle': 'Deliver with TRYDE',
      'icon': Icons.moped_rounded,
      'color': const Color(0xffD66D26),
      'iconBg': const Color(0xffFFF0E8),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xffF8F9FB),
        elevation: 0,
        leadingWidth: 90,
        leading: _backButton(context),
      ),

      body: Stack(
        children: [
          /// 🔥 ANIMATED GRADIENT BACKGROUND
          Animate(
            onPlay: (c) => c.repeat(reverse: true),
            effects: [
              ScaleEffect(
                begin: const Offset(1, 1),
                end: const Offset(1.05, 1.05),
                duration: 12.seconds,
              ),
            ],
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffF8F9FB), Color(0xffEEF2FA)],
                ),
              ),
            ),
          ),


          /// 🚗 FLOATING VEHICLES (CLEARLY VISIBLE)
          _floatingVehicles(size),

          /// 🧩 GRID (SLOW FADE)
          Positioned.fill(
            child: Animate(
              onPlay: (c) => c.repeat(reverse: true),
              effects: [
                FadeEffect(begin: 0.06, end: 0.12, duration: 8.seconds),
              ],
              child: CustomPaint(painter: _GridPainter()),
            ),
          ),

          /// MAIN CONTENT
          _content(),
        ],
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(begin: 0, end: 1, duration: 300.ms),
        MoveEffect(begin: const Offset(-20, 0), end: Offset.zero),
      ],
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.arrow_back, color: Colors.black),
              SizedBox(width: 6),
              Text(
                'Back',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  /// ANIMATED BLOB
  Widget _animatedBlob({
    required Color color,
    required double size,
    required Offset begin,
    required Offset end,
  }) {
    return Positioned.fill(
      child: Animate(
        onPlay: (c) => c.repeat(reverse: true),
        effects: [
          MoveEffect(begin: begin, end: end, duration: 18.seconds),
        ],
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  /// FLOATING VEHICLES
  Widget _floatingVehicles(Size size) => Positioned.fill(
    child: IgnorePointer(
      child: Stack(
        children: [

          // 🚗 Car
          FloatingIcon(
            icon: Icons.directions_car_rounded,
            color: const Color(0xff3177D0).withOpacity(0.6),
            size: 30, // ⬇ 36 → 30
            begin: Offset(-100, size.height * 0.6),
            end: Offset(size.width + 120, -200),
            duration: 3.seconds,
          ),

          // 🚚 Truck
          FloatingIcon(
            icon: Icons.local_shipping_rounded,
            color: const Color(0xff6339A6).withOpacity(0.55),
            size: 32, // ⬇ 40 → 32
            begin: Offset(size.width + 120, size.height),
            end: const Offset(-200, -300),
            duration: 3.seconds,
          ),

          // 🛵 Moped
          FloatingIcon(
            icon: Icons.moped_rounded,
            color: const Color(0xffD66D26).withOpacity(0.6),
            size: 26, // ⬇ 32 → 26
            begin: const Offset(-200, 900),
            end: const Offset(600, -400),
            duration: 8.seconds,
          ),

          // 🚲 Bike (depth)
          FloatingIcon(
            icon: Icons.pedal_bike_rounded,
            color: Colors.grey.withOpacity(0.12),
            size: 22, // ⬇ 26 → 22
            begin: Offset(size.width * 0.2, size.height + 200),
            end: Offset(-300, -300),
            duration: 4.seconds,
          ),

          // 📦 Parcel
          FloatingIcon(
            icon: Icons.inventory_2_rounded,
            color: const Color(0xff6339A6).withOpacity(0.15),
            size: 24, // ⬇ 30 → 24
            begin: const Offset(600, 800),
            end: const Offset(-400, -200),
            duration: 16.seconds,
          ),

          // 🛒 Shopping bag
          FloatingIcon(
            icon: Icons.shopping_bag_rounded,
            color: Colors.black.withOpacity(0.08),
            size: 18, // ⬇ 22 → 18
            begin: const Offset(-150, 500),
            end: const Offset(500, -250),
            duration: 10.seconds,
          ),

          // 🛵 Delivery dining
          FloatingIcon(
            icon: Icons.delivery_dining_rounded,
            color: const Color(0xffD66D26).withOpacity(0.45),
            size: 28, // ⬇ 34 → 28
            begin: Offset(size.width * 0.8, size.height + 150),
            end: const Offset(-250, -350),
            duration: 8.seconds,
          ),

          // 🚚 Fire truck (logistics)
          FloatingIcon(
            icon: Icons.fire_truck_rounded,
            color: const Color(0xff6339A6).withOpacity(0.35),
            size: 34, // ⬇ 42 → 34
            begin: const Offset(-300, 700),
            end: const Offset(700, -300),
            duration: 4.seconds,
          ),

          // 📍 Location pin
          FloatingIcon(
            icon: Icons.location_on_rounded,
            color: Colors.redAccent.withOpacity(0.35),
            size: 22, // ⬇ 26 → 22
            begin: Offset(size.width * 0.5, size.height + 300),
            end: const Offset(200, -400),
            duration: 10.seconds,
          ),

          // ⏱ Time
          FloatingIcon(
            icon: Icons.access_time_filled_rounded,
            color: Colors.black.withOpacity(0.18),
            size: 20, // ⬇ 24 → 20
            begin: const Offset(50, 600),
            end: const Offset(500, -300),
            duration: 5.seconds,
          ),

          // 📱 Phone
          FloatingIcon(
            icon: Icons.phone_android_rounded,
            color: Colors.grey.withOpacity(0.2),
            size: 18, // ⬇ 22 → 18
            begin: const Offset(400, 900),
            end: const Offset(-200, -250),
            duration: 10.seconds,
          ),
        ],

      ),
    ),
  );

  /// CONTENT
  Widget _content() => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _title(),
          const SizedBox(height: 40),
          _partnerCards(),
          const SizedBox(height: 180),
          _continueButton(),
          const SizedBox(height: 40),
        ],
      ),
    ),
  );

  Widget _title() => Column(
    children: [
      Text(
        'Select your Partner Type',
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: Colors.black
        ),
      ).animate().fadeIn().moveY(begin: 20),
      const SizedBox(height: 8),
      Text(
        'Choose how you want to earn with TRYDE',
        style: TextStyle(color: Colors.grey.shade600),
      ).animate().fadeIn(delay: 200.ms),
    ],
  );

  Widget _partnerCards() => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: _partners.length,
    separatorBuilder: (_, __) => const SizedBox(height: 16),
    itemBuilder: (_, index) {
      final item = _partners[index];
      final isSelected = _selected == item['id'];
      final color = item['color'] as Color;

      return GestureDetector(
        onTap: () => setState(() => _selected = item['id']),
        child: Animate(
          effects: [
            ScaleEffect(
              begin: const Offset(1, 1),
              end: const Offset(0.97, 0.97),
              duration: 120.ms,
            ),
          ],
          child: AnimatedContainer(
            duration: 300.ms,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: color.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
              ],
              border: Border.all(
                color: isSelected
                    ? color.withOpacity(0.6)
                    : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item['iconBg'],
                child: Icon(item['icon'], color: color),
              ),
              title: Text(
                item['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              subtitle: Text(item['subtitle']),
              trailing: isSelected
                  ? Icon(Icons.check_circle, color: color)
                  : const Icon(Icons.circle_outlined),
            ),
          ),
        ),
      );
    },
  );

  Widget _continueButton() => Animate(
    effects: [
      FadeEffect(begin: 0, end: 1, duration: 300.ms),
      MoveEffect(begin: const Offset(0, 20), end: Offset.zero),
    ],
    child: ElevatedButton(
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_role', _selected!);

        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: 600.ms,
            pageBuilder: (_, __, ___) => const RegistrationScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutExpo,
                    ),
                  ),
                  child: child,
                ),
              );
            },
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        backgroundColor: _getSelectedColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: const Text(
        'Continue',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    ),
  );

  Color _getSelectedColor() =>
      _partners.firstWhere((e) => e['id'] == _selected)['color'];

}

/// FLOATING ICON
class FloatingIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final Offset begin;
  final Offset end;
  final Duration duration;

  const FloatingIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
    required this.begin,
    required this.end,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      onPlay: (c) => c.repeat(),
      effects: [
        MoveEffect(
          begin: begin,
          end: end,
          duration: duration,
          curve: Curves.linear,
        ),
        RotateEffect(
          begin: -0.02,
          end: 0.02,
          duration: 12.seconds,
        ),
        FadeEffect(
          begin: 0.4,
          end: 0.85,
          duration: duration ~/ 3,
        ),
      ],
      child: Icon(
        icon,
        size: size,
        color: color,
        shadows: [
          Shadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}



/// GRID
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 0.5
      ..color = Colors.black.withOpacity(0.08);

    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}




// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tryde_partner/core/constants/color_constants.dart';

// class PartnerTypeSelectionScreen extends StatelessWidget {
//   const PartnerTypeSelectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             /// ================= TOP BANNER =================
//             Stack(
//               children: [
//                 ShaderMask(
//                   shaderCallback: (rect) {
//                     return const LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [Colors.black, Colors.transparent],
//                       stops: [0.6, 1.0],
//                     ).createShader(rect);
//                   },
//                   blendMode: BlendMode.dstIn,
//                   child: Image.asset(
//                     'assets/images/top-banner.png',
//                     height: 260,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),

//                 Positioned(
//                   bottom: 30,
//                   left: 16,
//                   right: 16,
//                   child: Column(
//                     children: const [
//                       Text(
//                         'Select Your Role',
//                         style: TextStyle(
//                           fontSize: 26,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       Text(
//                         'Choose how you want to work with us',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             /// ================= ROLES =================
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   _roleCard(
//                     context,
//                     title: "Rider",
//                     image: 'assets/images/rider-role.png',
//                     onTap: () {
//                       context.push('/login?r= rider');
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   _roleCard(
//                     context,
//                     title: "Porter",
//                     image: 'assets/images/porter-role.png',
//                     onTap: () {
//                       context.push('/login?r=porter');
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   _roleCard(
//                     context,
//                     title: "Food Delivery",
//                     image: 'assets/images/.png',
//                     onTap: () {
//                       context.push('/login?r=food');
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             const Spacer(),

//             /// ================= BOTTOM BANNER =================
//             ShaderMask(
//               shaderCallback: (rect) {
//                 return const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Colors.transparent, Colors.black],
//                   stops: [0.0, 0.35],
//                 ).createShader(rect);
//               },
//               blendMode: BlendMode.dstIn,
//               child: Image.asset(
//                 'assets/images/bottom-banner.png',
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ================= ROLE CARD =================
//   Widget _roleCard(
//     BuildContext context, {
//     required String title,
//     required String image,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(16),
//       onTap: onTap,
//       child: Container(
//         height: 90,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 10,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Image.asset(
//               image,
//               height: 60,
//             ),
//             const SizedBox(width: 16),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const Spacer(),
//             const Icon(Icons.arrow_forward_ios, size: 18),
//           ],
//         ),
//       ),
//     );
//   }
// }

