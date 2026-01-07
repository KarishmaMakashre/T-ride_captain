import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/app_constants.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/features/customer/screens/home/food_dashboard.dart';
import 'package:tryde_partner/features/customer/screens/home/home_dashboard_screen.dart';
import 'package:tryde_partner/features/customer/screens/home/porter_dashboard.dart';
import 'package:tryde_partner/features/customer/screens/home/ride_dashboard.screen.dart';
import 'package:tryde_partner/l10n/app_localizations.dart';
import 'package:tryde_partner/providers/location_provider.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  final List<Widget> _dashboards = const [
    HomeDashboard(),
    RideDashboard(),
    PorterDashboard(),
    FoodDashboard(),
  ];
  final List<Map<String, dynamic>> tabs = [
    {"icon": Icons.home_filled, "title": "Home"},
    {"icon": Icons.local_taxi, "title": "Ride"},
    {"icon": Icons.shopping_bag, "title": "Porter"},
    {"icon": Icons.food_bank, "title": "Food"},
  ];

  @override
  void initState() {
    super.initState();
    // Location fetch on first load
    Future.microtask(() {
      final locationProv = Provider.of<LocationProvider>(context, listen: false);
      if (locationProv.currentAddress.isEmpty && !locationProv.isLoading) {
        locationProv.fetchCurrentLocation();
      }
    });
  }

  void _switchTab(int index) {
    if (_selectedTab != index) {
      setState(() => _selectedTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final bool isDark = theme.brightness == Brightness.dark;
    final List<Color> tabAccentsLight = [
      AppColors.primary,
      AppColors.ridePrimary,
      AppColors.porterPrimary,
      AppColors.foodPrimary,
    ];
    final List<Color> tabAccentsDark = [
      AppColors.primaryDark,
      AppColors.ridePrimaryDark,
      AppColors.porterPrimaryDark,
      AppColors.foodPrimaryDark,
    ];
    final Color currentAccent = isDark ? tabAccentsDark[_selectedTab] : tabAccentsLight[_selectedTab];
    final Color blendedBg = Color.lerp(theme.scaffoldBackgroundColor, currentAccent, isDark ? 0.05 : 0.02)!;

    return Scaffold(
      backgroundColor: blendedBg,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Location
            Container(
              color: currentAccent.withOpacity(0.03),
              padding: const EdgeInsets.all(16),
              child: Consumer<LocationProvider>(
                builder: (context, locationProv, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: currentAccent.withOpacity(0.1),
                            child: Icon(Icons.person, size: 26, color: currentAccent),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localizations.welcome, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.colorScheme.onBackground)),
                              Row(
                                children: [
                                  Icon(Icons.location_on_rounded, size: 15, color: currentAccent),
                                  const SizedBox(width: 4),
                                  Text(
                                    locationProv.isLoading ? "Fetching..." : locationProv.currentAddress,
                                    style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurfaceVariant),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => context.push('/notifications'),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(color: theme.colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(12)),
                            child: Icon(Icons.notifications_none, color: currentAccent),
                          ),
                        ),
                      ),
                    ],
                  ); 
                },
              ),
            ),
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  bool isActive = _selectedTab == index;
                  return GestureDetector(
                    onTap: () => _switchTab(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: 75,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isActive ? currentAccent : theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(tabs[index]["icon"], 
                            color: isActive ? Colors.white : theme.colorScheme.onSurfaceVariant,
                            size: 24
                          ),
                          const SizedBox(height: 5),
                          Text(
                            tabs[index]["title"],
                            style: TextStyle(
                              color: isActive ? Colors.white : theme.colorScheme.onSurfaceVariant,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            // Dynamic Dashboard Content with Smooth Transition and Animation
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.1),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    )),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: _dashboards[_selectedTab],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation - Increased height, larger icons, added labels
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20), // Increased vertical padding for height
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [BoxShadow(color: theme.colorScheme.outline.withOpacity(0.1), blurRadius: 8)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Changed to spaceEvenly for better distribution
          children: [
            _navItem(Icons.home_filled, 0, "Home", context, currentAccent, isActive: true),
            _navItem(Icons.description, 1, "History", context, currentAccent, route: AppConstants.routeHistory),
            _navItem(Icons.history, 2, "Orders", context, currentAccent, route: AppConstants.routeHistory),
            _navItem(Icons.person, 3, "Account", context, currentAccent, route: AppConstants.routeAccount),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index, String label, BuildContext context, Color currentAccent, {String? route, bool isActive = false}) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        if (route != null) context.push(route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isActive ? 30 : 26, color: isActive ? currentAccent : theme.colorScheme.onSurfaceVariant), // Slightly larger icons
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? currentAccent : theme.colorScheme.onSurfaceVariant,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 3),
              height: 3,
              width: 20,
              decoration: BoxDecoration(color: currentAccent, borderRadius: BorderRadius.circular(20)),
            ),
        ],
      ),
    );
  }
}