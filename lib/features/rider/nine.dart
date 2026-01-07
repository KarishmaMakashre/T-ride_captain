import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/ten.dart';

class RatePassengerScreen extends StatefulWidget {
  const RatePassengerScreen({super.key});

  @override
  State<RatePassengerScreen> createState() => _RatePassengerScreenState();
}

class _RatePassengerScreenState extends State<RatePassengerScreen> {
  int rating = 5;
  final TextEditingController feedbackCtrl = TextEditingController();

  @override
  void dispose() {
    feedbackCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Rate Passenger")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "How was your passenger?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    size: 36,
                    color: i < rating ? Colors.orange : Colors.grey,
                  ),
                  onPressed: () => setState(() => rating = i + 1),
                );
              }),
            ),

            TextField(
              controller: feedbackCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Optional feedback",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            /// 📢 ADS BANNER (ADDED)
            ImageAdsBanner(
              height: h * 0.18,
              adsImages: const [
                "https://images.unsplash.com/photo-1607082352121-fa243f3dde32",
                "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
                "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
              ],
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EarningsUpdatedScreen(),
                  ),
                );
              },
              child: const Text("Submit Rating"),
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
  late PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _timer = Timer.periodic(widget.autoScrollDuration, (_) {
      if (!_controller.hasClients) return;
      _index = (_index + 1) % widget.adsImages.length;
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _controller,
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
