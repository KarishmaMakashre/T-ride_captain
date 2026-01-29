import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/features/rider/custom_app_bar.dart';
import 'package:tryde_partner/features/rider/second.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnline = true;
  bool hasRideRequest = true;

  /// 🔥 ADS IMAGE URLS
  final List<String> adsImages = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS32zMxm2aMKQQ3gfObn2_70nDZtn6SBw93Yw&s",
  ];

  @override
  void initState() {
    super.initState();
    _showFirstTimePopup();
  }

  Future<void> _showFirstTimePopup() async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool('caution_shown') ?? false;

    if (!shown) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text("⚠️ Important Instructions"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("• Location access is required"),
                Text("• Background tracking used during trips"),
                Text("• Follow pickup & drop rules"),
                SizedBox(height: 10),
                Text(
                  "🔗 Terms & Conditions",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await prefs.setBool('caution_shown', true);
                  Navigator.pop(context);
                },
                child: const Text("Agree & Continue"),
              )
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // 👈 status bar background
        statusBarIconBrightness: Brightness.dark, // Android icons
        statusBarBrightness: Brightness.dark, // iOS icons
      ),
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomHomeAppBar(
        onDutyChanged: (value) {
          setState(() {
            isOnline = value;
            hasRideRequest = value;
          });
        },
      ),
      body: Stack(
        children: [
          /// 🖼️ FULL BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/topHeaderImage.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🔲 Optional overlay (readability)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.12),
            ),
          ),

          /// 🔝 PAGE CONTENT
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 📊 TODAY PERFORMANCE
                  const Text(
                    "Today's performance",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: _infoCard(
                          icon: Icons.account_balance_wallet,
                          iconColor: AppColors.success,
                          title: "Today Earnings",
                          value: "₹ 1,250",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _infoCard(
                          icon: Icons.route,
                          iconColor: AppColors.info,
                          title: "Trips",
                          value: "8",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  if (isOnline && hasRideRequest) _incomingRideCard(),

                  const SizedBox(height: 20),

                  const Text(
                    "Offers & Rewards",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),

                  ImageAdsBanner(adsImages: adsImages),

                  const SizedBox(height: 12),

                  Text(
                    "Porter Driver Mode",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.greyText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🚕 RIDE CARD
  Widget _incomingRideCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔔 HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Incoming Ride",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "00:25",
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// 🚕 NEW RIDE
          Row(
            children: const [
              Icon(Icons.notifications_active,
                  color: AppColors.success, size: 18),
              SizedBox(width: 8),
              Text(
                "New Ride Request",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// 📍 PICKUP
          _locationRow(
            icon: Icons.radio_button_checked,
            value: "Bhopal Railway Station",
            color: AppColors.success,
          ),

          const SizedBox(height: 10),

          /// 📍 DROP
          _locationRow(
            icon: Icons.location_on,
            value: "MP Nagar Zone 2",
            color: AppColors.error,
          ),

          const Divider(height: 28),

          /// 📊 INFO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _InfoTile(title: "Distance", value: "6.2 km"),
              _InfoTile(title: "Fare", value: "₹320"),
              _InfoTile(title: "Payment", value: "Cash"),
            ],
          ),

          const SizedBox(height: 20),

          /// 🔘 ACTION BUTTONS
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () =>
                      setState(() => hasRideRequest = false),
                  child: const Text("Reject"),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const DriverRideAcceptedScreen(),
                      ),
                    );
                  },
                  child: const Text("Accept Ride"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _locationRow({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),

          /// VALUE
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 4),

          /// TITLE (Styled)
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
              color: AppColors.greyText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(10), // ⬅️ 16 → 10
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14), // ⬅️ 18 → 14
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // ⬅️ IMPORTANT
        children: [
          Icon(icon, color: iconColor, size: 20), // ⬅️ icon size kam
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 11),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18, // ⬅️ 22 → 18
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


}

/// ================= IMAGE ADS BANNER =================

class ImageAdsBanner extends StatelessWidget {
  final List<String> adsImages;
  final double height;

  const ImageAdsBanner({
    super.key,
    required this.adsImages,
    this.height = 170,
  });

  @override
  Widget build(BuildContext context) {
    if (adsImages.isEmpty) return const SizedBox();

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [

              /// 🖼 IMAGE
              Image.network(
                adsImages.first,
                fit: BoxFit.cover,
              ),

              /// 🌫 DARK GRADIENT (for text readability)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.65),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              /// 📝 TEXT
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Complete more trips & earn bonus 🚀",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(fontSize: 12, color: AppColors.greyText)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
