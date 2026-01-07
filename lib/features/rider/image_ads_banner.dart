import 'dart:async';
import 'package:flutter/material.dart';

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
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(widget.autoScrollDuration, (_) {
      if (!_pageController.hasClients || widget.adsImages.isEmpty) return;

      _currentIndex++;
      if (_currentIndex >= widget.adsImages.length) {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
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
    return MouseRegion(
      opaque: false,
      onEnter: (_) {},
      onHover: (_) {},
      onExit: (_) {},
      child: SizedBox(
        height: widget.height,
        child: PageView.builder(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.adsImages.length,
          onPageChanged: (index) {
            _currentIndex = index;
          },
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.adsImages[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
