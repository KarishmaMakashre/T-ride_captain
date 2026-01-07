import 'dart:async';
import 'package:flutter/material.dart';
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

  final List<String> promoBanners = [
    "🎁 Complete 5 trips & earn ₹200 bonus",
    "🏆 Weekly Rewards unlocked!",
  ];

  /// 🔥 ADS IMAGE URLS
  final List<String> adsImages = [
    "https://images.unsplash.com/photo-1607082352121-fa243f3dde32",
    "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
    "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomHomeAppBar(
        onDutyChanged: (value) {
          setState(() {
            isOnline = value;
            hasRideRequest = value;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              if (isOnline && hasRideRequest) _incomingRideCard(),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      title: "Today Earnings",
                      value: "₹1,250",
                      icon: Icons.account_balance_wallet,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _statCard(
                      title: "Trips",
                      value: "8",
                      icon: Icons.route,
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _promoSection(),
              const SizedBox(height: 12),

              /// 📢 IMAGE ADS BANNER
              ImageAdsBanner(
                adsImages: adsImages,
              ),

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
    );
  }

  /// 🚕 RIDE CARD
  Widget _incomingRideCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "New Ride Request",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text("Pickup Location",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          _locationRow(
            icon: Icons.radio_button_checked,
            value: "Bhopal Railway Station",
            color: AppColors.success,
          ),
          const SizedBox(height: 10),
          const Text("Drop Location",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          _locationRow(
            icon: Icons.location_on,
            value: "MP Nagar Zone 2",
            color: AppColors.error,
          ),
          const Divider(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _InfoTile(title: "Distance", value: "6.2 km"),
              _InfoTile(title: "Fare", value: "₹320"),
              _InfoTile(title: "Payment", value: "Cash"),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => hasRideRequest = false),
                  child: const Text("Reject"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DriverRideAcceptedScreen(),
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

  Widget _promoSection() {
    return SizedBox(
      height: 90,
      child: PageView.builder(
        itemCount: promoBanners.length,
        itemBuilder: (_, i) => _promoCard(promoBanners[i]),
      ),
    );
  }

  Widget _promoCard(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
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
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),
          Text(value,
              style:
              const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(title,
              style: TextStyle(fontSize: 13, color: AppColors.greyText)),
        ],
      ),
    );
  }
}

/// ================= IMAGE ADS BANNER =================

class ImageAdsBanner extends StatefulWidget {
  final List<String> adsImages;
  final double height;
  final Duration autoScrollDuration;

  const ImageAdsBanner({
    super.key,
    required this.adsImages,
    this.height = 170,
    this.autoScrollDuration = const Duration(seconds: 2),
  });

  @override
  State<ImageAdsBanner> createState() => _ImageAdsBannerState();
}

class _ImageAdsBannerState extends State<ImageAdsBanner> {
  late PageController _pageController;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(widget.autoScrollDuration, (_) {
      if (!_pageController.hasClients || widget.adsImages.isEmpty) return;

      _index = (_index + 1) % widget.adsImages.length;
      _pageController.animateToPage(
        _index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.adsImages.length,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                widget.adsImages[i],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
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
