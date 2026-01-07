import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tryde_partner/core/constants/app_constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _controller = PageController();
  int _current = 0;

  late List<AnimationController> _animC;
  late List<Animation<double>> _fade;
  late List<Animation<Offset>> _slide;

  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Start Earning with Tryde',
      'desc':
          'Join our partner network and start earning. Flexible hours, good pay, and easy booking management.',
      'image': AppConstants.splashOnePath,
      'primary': Color(0xFFFF6B6B),
      'badgeBg': Color(0xFFFFF1F0),
      'badgeText': Color(0xFFFF6B6B),
      'badges': [
        "Flexible Hours",
        "High Earnings",
      ]
    },
    {
      'title': 'Manage Your Services',
      'desc':
          'Easily manage ride bookings and porter services. Accept/reject requests, track earnings, and set availability.',
      'image': AppConstants.splashTwoPath,
      'primary': Color(0xFF9B59B6),
      'badgeBg': Color(0xFFF3EEFF),
      'badgeText': Color(0xFF8E58D8),
      'badges': [
        "Easy Management",
        "Real-time Updates",
      ]
    },
    {
      'title': 'Grow Your Business',
      'desc':
          'Access analytics, ratings, and reviews. Get more customers and increase your earnings with our support.',
      'image': AppConstants.splashThreePath,
      'primary': Color(0xFF00BCD4),
      'badgeBg': Color(0xFFF0FCFF),
      'badgeText': Color(0xFF00ACC1),
      'badges': [
        "Performance Insights",
        "Customer Ratings",
      ]
    }
  ];

  @override
  void initState() {
    super.initState();

    _animC = List.generate(
      pages.length,
      (_) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      ),
    );

    _fade = _animC
        .map((c) => Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: c, curve: Curves.easeOut),
            ))
        .toList();

    _slide = _animC
        .map((c) => Tween(begin: Offset(0, .25), end: Offset.zero).animate(
              CurvedAnimation(parent: c, curve: Curves.easeOut),
            ))
        .toList();

    _animC[0].forward();

    _controller.addListener(() {
      final p = _controller.page?.round() ?? 0;
      if (p != _current) {
        setState(() => _current = p);
        _animC[p].forward(from: 0);
      }
    });
  }

  @override
  void dispose() {
    for (var c in _animC) {
      c.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  // Floating Icons
  Widget floatingIcon(IconData icon, double size, Color color, int seconds) {
    final anim = AnimationController(
      vsync: this,
      duration: Duration(seconds: seconds),
    )..repeat();

    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        final dx = sin(anim.value * 2 * pi) * 18;
        final dy = cos(anim.value * 2 * pi) * 18;

        return Transform.translate(
          offset: Offset(dx, dy),
          child: Icon(icon, size: size, color: color.withOpacity(.35)),
        );
      },
    );
  }

  // Grid Background
  Widget faintGrid() {
    return CustomPaint(
      painter: _GridPainter(),
      child: Container(),
    );
  }

  // Badge Box
  Widget badge(String text, Color bg, Color txt) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: txt,
        ),
      ),
    );
  }

  // Card UI
  Widget card(Map p, int index) {
    double h = MediaQuery.of(context).size.height * .46;
    double w = MediaQuery.of(context).size.width * .83;

    return Transform.scale(
      scale: 0.95,
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 25,
              offset: Offset(0, 14),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              faintGrid(),

              // Floating icons
              Positioned(
                  top: 20,
                  left: 20,
                  child: floatingIcon(Icons.circle, 16, p['primary'], 5)),
              Positioned(
                  top: 28,
                  right: 28,
                  child: floatingIcon(Icons.star, 20, p['primary'], 4)),
              Positioned(
                  bottom: 20,
                  right: 20,
                  child:
                      floatingIcon(Icons.circle_outlined, 18, p['primary'], 6)),

              Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    // Square Image
                    ScaleTransition(
                      scale: Tween(begin: .88, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animC[index],
                          curve: Interval(0, .6, curve: Curves.easeOut),
                        ),
                      ),
                      child: Container(
                        height: w * 0.78,
                        width: w * 0.78,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            p['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 14),

                    // Badges
                    FadeTransition(
                      opacity: _fade[index],
                      child: SlideTransition(
                        position: _slide[index],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: p['badges']
                              .map<Widget>((b) =>
                                  badge(b, p['badgeBg'], p['badgeText']))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = pages[_current];

    return Scaffold(
      backgroundColor: Color(0xFFF7F9FC),
      body: Stack(
        children: [
          // Floating icons
          Positioned(
              top: 90,
              left: 20,
              child: floatingIcon(Icons.star, 22, p['primary'], 6)),
          Positioned(
              bottom: 160,
              right: 30,
              child: floatingIcon(Icons.circle, 22, p['primary'], 7)),
          Positioned(
              bottom: 80,
              left: 60,
              child:
                  floatingIcon(Icons.star_border, 26, p['primary'], 5)),
          Positioned(
              top: 160,
              right: 80,
              child:
                  floatingIcon(Icons.circle_outlined, 20, p['primary'], 8)),

          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 50),

                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: pages.length,
                    itemBuilder: (_, i) => card(pages[i], i),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        p['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10),

                      Text(
                        p['desc'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black54,
                        ),
                      ),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _current > 0
                              ? TextButton(
                                  onPressed: () => _controller.previousPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeOut,
                                  ),
                                  child: Text(
                                    "Previous",
                                    style: TextStyle(
                                        color: p['primary'], fontSize: 16),
                                  ),
                                )
                              : SizedBox(width: 80),

                          SmoothPageIndicator(
                            controller: _controller,
                            count: pages.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: p['primary'],
                              dotColor: Colors.grey.shade300,
                              expansionFactor: 3,
                              dotHeight: 8,
                              dotWidth: 8,
                            ),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              if (_current < pages.length - 1) {
                                _controller.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeOut,
                                );
                              } else if (_current == pages.length - 1) {
                                context.push('/language-selection');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: p['primary'],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: StadiumBorder(),
                            ),
                            child: Text(
                              _current == pages.length - 1
                                  ? "Join Now"
                                  : "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 18),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Color(0xFFF2F5F7)
      ..strokeWidth = 1;

    const s = 36.0;

    for (double x = 0; x < size.width; x += s) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += s) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}