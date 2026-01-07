import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/seven_eight.dart';

class DriverReachDropScreen extends StatelessWidget {
  const DriverReachDropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Drop Location")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.flag, size: 80, color: Colors.green),
            const SizedBox(height: 20),

            const Text(
              "You have reached the drop location",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            /// 📢 IMAGE ADS BANNER
            ImageAdsBanner(
              height: h * 0.22,
              adsImages: const [
                "https://images.unsplash.com/photo-1607082352121-fa243f3dde32",
                "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
                "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
              ],
            ),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DriverCollectPaymentScreen(
                      amount: 250.0,
                      bookingId: "BK10245",
                      customerName: "Rahul Sharma",
                    ),
                  ),
                );
              },
              child: const Text("Complete Trip"),
            ),
          ],
        ),
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
    required this.height,
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
      if (!_pageController.hasClients) return;
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
          return ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              widget.adsImages[i],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
