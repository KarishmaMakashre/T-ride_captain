import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tryde_partner/features/rider/nine.dart';

class DriverTripCompletedScreen extends StatelessWidget {
  const DriverTripCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double baseFare = 80;
    final double distanceFare = 220;
    final double timeFare = 40;
    final double total = baseFare + distanceFare + timeFare;
    final h = MediaQuery.of(context).size.height;

    {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Trip Completed"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,

        body: Stack(
          children: [
            /// 🖼️ BACKGROUND IMAGE
            Positioned.fill(
              child: Image.asset(
                'assets/images/topHeaderImage.png',
                fit: BoxFit.cover,
              ),
            ),

            /// 🔲 OVERLAY (optional but recommended)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.10),
              ),
            ),

            /// 🧱 CONTENT
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 80,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Trip Successfully Completed",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 30),

                    _fareRow("Base Fare", baseFare),
                    _fareRow("Distance Fare", distanceFare),
                    _fareRow("Time Fare", timeFare),
                    const Divider(color: Colors.white54),
                    _fareRow("TOTAL", total, bold: true),

                    const SizedBox(height: 30),

                    _paymentStatusCard(),

                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Offers & Rewards",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// 📢 ADS BANNER
                    ImageAdsBanner(
                      height: h * 0.18,
                      adsImages: const [
                        "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
                      ],
                    ),

                    const Spacer(),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RatePassengerScreen(),
                          ),
                        );
                      },
                      child: const Text("Rate User"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _fareRow(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: bold ? 16 : 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "₹${value.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: bold ? 16 : 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: const [
          Icon(Icons.payments, color: Colors.green),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Payment Received (Cash)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
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
