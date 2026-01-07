// home_dashboard.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

import 'package:tryde_partner/l10n/app_localizations.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 5) { // 6 banners (index 0-5)
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Automatic Banner Carousel
          _bannerCarousel(context, theme),
          const SizedBox(height: 20),
          // Quick Services Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quick Services",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 15),
              _quickServicesGrid(context, theme),
            ],
          ),
          const SizedBox(height: 20),
          // Additional Services Section (like Intercity, etc.)
          _additionalServicesSection(context, theme),
          const SizedBox(height: 20),
          // Your Activity This Month Section
          _activitySection(context, theme),
          const SizedBox(height: 20),
          // Account Overview Section
          _accountOverviewSection(context, theme),
          const SizedBox(height: 20),
          // Recent Bookings Section
          _recentBookingsSection(context, theme),
          const SizedBox(height: 20),
          // Special Offers Section
          _specialOffersSection(context, theme),
          const SizedBox(height: 20),
          // Promotional Banner Section
          _promoBannerSection(context, theme),
          const SizedBox(height: 80), // Space for bottom nav
        ],
      ),
    );
  }

  // Automatic Banner Carousel with 6 image slides and overlay text
  Widget _bannerCarousel(BuildContext context, ThemeData theme) {
    final List<Map<String, dynamic>> banners = [
      {
        "imageUrl": 'assets/images/coursel1.jpg',
        "title": "Special Offer",
        "subtitle": "Save up to 30% today",
      },
      {
        "imageUrl": 'assets/images/coursel2.jpg',
        "title": "Porter Services",
        "subtitle": "Quick & Reliable Help",
      },
      {
        "imageUrl": 'assets/images/coursel3.avif',
        "title": "Quick Rider Available",
        "subtitle": "Book your ride now",
      },
      {
        "imageUrl": 'assets/images/coursel5.avif',
        "title": "Instant Food Delivery",
        "subtitle": "Hot meals in minutes",
      },
      {
        "imageUrl": 'assets/images/coursel5.jpg',
        "title": "Instant Food Delivery",
        "subtitle": "Hot meals in minutes",
      },
      {
        "imageUrl": 'assets/images/coursel6.jpg',
        "title": "All in One Place",
        "subtitle": "Rides, Food & More",
      },
    ];

    return SizedBox(
      height: 170,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.asset(
                    banner["imageUrl"],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.primary.withOpacity(0.1),
                        child: Center(
                          child: Text(
                            banner["title"],
                            style: TextStyle(
                              color: theme.colorScheme.onBackground,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Bottom gradient overlay for fade effect
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6), // Semi-transparent grayish-black at bottom
                          Colors.transparent, // Fades to transparent towards top
                        ],
                        stops: const [0.0, 0.5], // Adjust stops for fade intensity
                      ),
                    ),
                  ),
                  // Overlay text positioned on the gradient
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner["title"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          banner["subtitle"],
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Quick Services (Fixed: 2x2 grid, three main + Emergency; tappable to switch tabs)
  Widget _quickServicesGrid(BuildContext context, ThemeData theme) {
    final List<Map<String, dynamic>> services = [
      {
        "icon": Icons.local_taxi,
        "title": "Cab / Auto Ride",
        "subtitle": "15 nearby",
        "color": AppColors.primary,
        "onTap": () => context.go('/ride'), // Or switch tab logic
      },
      {
        "icon": Icons.shopping_bag,
        "title": "Porter Logistics",
        "subtitle": "8 available",
        "color": AppColors.primary,
        "onTap": () => context.go('/porter'),
      },
      {
        "icon": Icons.restaurant,
        "title": "Food Services",
        "subtitle": "Order now",
        "color": AppColors.primary,
        "onTap": () => context.go('/food'),
      },
      {
        "icon": Icons.local_hospital,
        "title": "Emergency",
        "subtitle": "24/7",
        "color": AppColors.primary,
        "onTap": () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Emergency services coming soon!")),
        ),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: service["onTap"],
          child: Container(
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     service["color"].withOpacity(0.1),
              //     theme.colorScheme.surface,
              //   ],
              // ),
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: service["color"].withOpacity(0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    service["icon"],
                    color: service["color"],
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service["title"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service["subtitle"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Additional Services Section (Inspired by Uber: Intercity, Rentals, etc.)
  Widget _additionalServicesSection(BuildContext context, ThemeData theme) {
    final List<Map<String, dynamic>> services = [
      {
        "icon": Icons.airplanemode_active,
        "title": "Intercity",
        "subtitle": "40% off",
        "color": AppColors.primary,
        "onTap": () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Intercity rides coming soon!")),
        ),
      },
      {
        "icon": Icons.directions_car,
        "title": "Rentals",
        "subtitle": "Hourly rides",
        "color": AppColors.primary,
        "onTap": () => context.go('/ride'),
      },
      {
        "icon": Icons.person,
        "title": "Seniors",
        "subtitle": "Priority service",
        "color": AppColors.primary,
        "onTap": () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Senior services coming soon!")),
        ),
      },
      {
        "icon": Icons.local_offer,
        "title": "Promo",
        "subtitle": "Deals & offers",
        "color": AppColors.primary,
        "onTap": () => _showPromoDialog(context),
      },
      {
        "icon": Icons.schedule,
        "title": "Reserve",
        "subtitle": "Schedule rides",
        "color": AppColors.primary,
        "onTap": () => context.go('/ride'),
      },
      {
        "icon": Icons.local_shipping,
        "title": "Courier",
        "subtitle": "Quick delivery",
        "color": AppColors.primary,
        "onTap": () => context.go('/porter'),
      },
      {
        "icon": Icons.child_care,
        "title": "Teens",
        "subtitle": "Safe rides",
        "color": AppColors.primary,
        "onTap": () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Teens mode coming soon!")),
        ),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "More Services",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return GestureDetector(
              onTap: service["onTap"],
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: service["color"].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      service["icon"],
                      color: service["color"],
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service["title"],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (service["subtitle"] != null)
                    Text(
                      service["subtitle"],
                      style: TextStyle(
                        fontSize: 9,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _showPromoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Promotions"),
        content: const Text("Check out our latest deals!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  // Your Activity This Month
  Widget _activitySection(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Activity This Month",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _activityMetric(
                context,
                Icons.local_taxi,
                "23",
                "Total Rides",
                AppColors.primary,
                theme,
              ),
              _activityMetric(
                context,
                Icons.shopping_bag,
                "12",
                "Porter Jobs",
                AppColors.primary,
                theme,
              ),
              _activityMetric(
                context,
                Icons.monetization_on,
                "₹3,450",
                "Total Spent",
                AppColors.primary,
                theme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _activityMetric(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color accentColor,
    ThemeData theme,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: accentColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Account Overview
  Widget _accountOverviewSection(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.outline.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account Overview",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => context.push('/payments'),
            child: Row(
            children: [
              Icon(Icons.account_balance_wallet, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wallet Balance",
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "₹1,250",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.star, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reward Points",
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "450 pts",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.badge, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Membership",
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "Gold Member",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Recent Bookings
  Widget _recentBookingsSection(BuildContext context, ThemeData theme) {
    final List<Map<String, dynamic>> bookings = [
      {
        "icon": Icons.local_taxi,
        "title": "Cab Ride",
        "subtitle": "Home → Airport",
        "amount": "₹450",
        "time": "2 hours ago",
        "status": "Completed",
        "color": AppColors.primary,
      },
      {
        "icon": Icons.shopping_bag,
        "title": "Porter Service",
        "subtitle": "Apartment → New House",
        "amount": "₹800",
        "time": "1 day ago",
        "status": "Completed",
        "color": AppColors.primary,
      },
      {
        "icon": Icons.delivery_dining,
        "title": "Delivery",
        "subtitle": "Restaurant → Office",
        "amount": "₹120",
        "time": "2 days ago",
        "status": "Delivered",
        "color": AppColors.primary,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Bookings",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onBackground,
              ),
            ),
            TextButton(
              onPressed: () => context.push('/history'),
              child: Text(
                "View All",
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...bookings.map((booking) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: booking["color"].withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: booking["color"].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(booking["icon"], color: booking["color"]),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking["title"],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: theme.colorScheme.onBackground,
                            ),
                          ),
                          Text(
                            booking["subtitle"],
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            booking["time"],
                            style: TextStyle(
                              fontSize: 11,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          booking["amount"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: booking["color"].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            booking["status"],
                            style: TextStyle(
                              fontSize: 11,
                              color: booking["color"],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  // Special Offers
  Widget _specialOffersSection(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            theme.colorScheme.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.local_offer, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                "Special Offers",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Get 20% off on your next ride",
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Use code: NITROX20",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Code applied!")),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Claim", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Promotional Banner (End of Season Sale)
  Widget _promoBannerSection(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.primary.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "50% OFF",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "End of Season BIG Sale",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Save up to 30% today",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Offers applied!")),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text("Shop Now", style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}