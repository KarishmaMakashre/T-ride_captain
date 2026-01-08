import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:tryde_partner/core/constants/app_constants.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/features/customer/porter/screens/porter_sharing_screen.dart';
import 'package:tryde_partner/features/porter_partner/screens/order_detail_screen.dart';
// import 'package:tryde_partner/features/porter_partner/screens/porter_sharing_screen.dart'; // Add this import for PorterSharingScreen
import 'package:tryde_partner/providers/location_provider.dart';

import '../../rider/custom_app_bar.dart';

class PartnerDashboard extends StatefulWidget {
  const PartnerDashboard({super.key});

  @override
  State<PartnerDashboard> createState() => _PartnerDashboardState();
}

class _PartnerDashboardState extends State<PartnerDashboard>
    with SingleTickerProviderStateMixin {
  bool isOnline = false;
  Timer? _requestTimer;
  int selectedTab = 0;

  late AnimationController _chartController;

  final tabs = ['Daily', 'Weekly', 'Monthly'];

  final chartData = [
    [120, 150, 180, 140, 130, 200, 220], // Daily
    [500, 620, 580, 700, 650, 720, 800], // Weekly
    [1200, 1350, 1500, 1450, 1600, 1700, 1800], // Monthly
  ];

  bool _hasFetchedLocation = false;

  @override
  void initState() {
    super.initState();
    _chartController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
          ..forward();
  }

  void _changeTab(int index) {
    setState(() {
      selectedTab = index;
    });
    _chartController.reset();
    _chartController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationProvider(),
      child: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          // Fetch location only once if not done
          if (!_hasFetchedLocation && locationProvider.currentAddress.isEmpty) {
            _hasFetchedLocation = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              locationProvider.fetchCurrentLocation();
            });
          }

          return Scaffold(
            appBar: CustomHomeAppBar(
              onDutyChanged: (value) {
                setState(() {
                  isOnline = value;
                  var hasRideRequest = value;
                });
              },
            ),


            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _topStats(),
                  const SizedBox(height: 16),
                  _porterSharingEarnings(),
                  const SizedBox(height: 16),
                  _upcomingOrders(),
                  const SizedBox(height: 16),
                  _withdrawButton(),
                  const SizedBox(height: 24),
                  _tabBar(),
                  const SizedBox(height: 20),
                  _animatedBarChart(),
                  const SizedBox(height: 16),
                  _monthlyText(),
                  const SizedBox(height: 16),
                  _breakdownCard(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 🔹 ONLINE OFFLINE
  Widget _onlineOfflineToggle() {
    return Switch(
      value: isOnline,
      activeColor: Colors.green,
      onChanged: (value) {
        setState(() => isOnline = value);
        value ? _startListeningForRequests() : _stopListening();
      },
    );
  }

  // 🔹 BALANCE + TRIPS
  Widget _topStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('₹150.00',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Your Balance', style: TextStyle(color: Colors.grey)),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [
          Text('24',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange)),
          Text('Total Trips', style: TextStyle(color: Colors.grey)),
        ]),
      ],
    );
  }

  // 🔹 PORTER SHARING EARNINGS
  Widget _porterSharingEarnings() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: const Row(
        children: [
          Icon(Icons.share, color: Colors.green),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'You earned ₹40 extra via Porter Sharing!',
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

  // 🔹 UPCOMING ORDERS
  Widget _upcomingOrders() {
    final upcomingOrders = [
      {
        'time': 'Evening 4 PM',
        'pickup': 'Radisson',
        'drop': 'Dewas',
        'earning': '₹320',
      },
      {
        'time': 'Night 8 PM',
        'pickup': 'Indore Mall',
        'drop': 'Ujjain',
        'earning': '₹450',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Orders',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...upcomingOrders.map((order) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.schedule, color: Colors.blue),
                title: Text('${order['time']}'),
                subtitle: Text('${order['pickup']} to ${order['drop']}'),
                trailing: Text(
                  order['earning']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                onTap: () {
                  // Navigate to order details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderDetailScreen(),
                    ),
                  );
                },
              ),
            )),
      ],
    );
  }

  // 🔹 WITHDRAW
  Widget _withdrawButton() {
    return SizedBox(
      width: 160,
      height: 44,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text('WITHDRAWAL'),
      ),
    );
  }

  // 🔹 TABS
  Widget _tabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(tabs.length, (index) {
        final selected = selectedTab == index;
        return GestureDetector(
          onTap: () => _changeTab(index),
          child: Column(
            children: [
              Text(
                tabs[index],
                style: TextStyle(
                    color:
                        selected ? AppColors.primary : Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(top: 6),
                width: selected ? 40 : 0,
                height: 2,
                color: AppColors.primary,
              )
            ],
          ),
        );
      }),
    );
  }

  // 🔹 ANIMATED BAR CHART
  Widget _animatedBarChart() {
    return SizedBox(
      height: 220,
      child: AnimatedBuilder(
        animation: _chartController,
        builder: (_, __) {
          return BarChart(
            BarChartData(
              maxY: 2000,
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = ['M', 'Tu', 'W', 'Th', 'F', 'Sa', 'Su'];
                      return Text(days[value.toInt()]);
                    },
                  ),
                ),
              ),
              barGroups: List.generate(7, (index) {
                final value = chartData[selectedTab][index] *
                    _chartController.value;
                return BarChartGroupData(x: index, barRods: [
                  BarChartRodData(
                    toY: value.toDouble(),
                    width: 18,
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ]);
              }),
            ),
          );
        },
      ),
    );
  }

  Widget _monthlyText() {
    return const Text(
      'Monthly Earnings : Rs 1650.50',
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  // 🔹 BREAKDOWN
  Widget _breakdownCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _row('Trip Earnings', 'Rs 230.50'),
          _row('Toll Charges', 'Rs 40.50'),
          _row('Tips', 'Rs 76.54'),
          _row('Rewards', 'Rs 88.50'),
          _row('Other adjustments', 'Rs 6.50'),
        ],
      ),
    );
  }

  Widget _row(String t, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(t), Text(v, style: const TextStyle(color: Colors.red))],
      ),
    );
  }

  // 🔹 DRAWER UI WITH PROFILE
  Widget _drawer(LocationProvider locationProvider) {
    return Drawer(
      child: Column(
        children: [
          // Profile Header
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(AppConstants.proterProfilePath), // Replace with actual image URL
                      child: Icon(Icons.person, size: 25, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'John Doe', // Hardcoded name, replace with actual
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '+91 1234567890', // Hardcoded phone, replace with actual
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
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          locationProvider.currentAddress.isNotEmpty
                              ? locationProvider.currentAddress
                              : 'Indore, MP',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          _drawerItem(Icons.local_shipping, 'My Trips'),
          _drawerItem(Icons.account_balance_wallet, 'Wallet'),
          _drawerItem(Icons.bar_chart, 'Earnings'),
          _drawerItem(Icons.safety_check, 'Insurance'), // New item
          _drawerItem(Icons.calendar_today, 'Calendar'), // New item
          _drawerItem(Icons.share, 'Porter Sharing'), // New item
          _drawerItem(Icons.support_agent, 'Support'),
          _drawerItem(Icons.logout, 'Logout'),
        ],
      ),
    );
  }

  ListTile _drawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Close drawer
        // Add navigation logic here
        if (title == 'Porter Sharing') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PorterSharingScreen(),
            ),
          );
        }
        // Add more conditions for other items as needed
      },
    );
  }

  // 🔔 FAKE ORDER
  void _startListeningForRequests() {
    _requestTimer = Timer(const Duration(seconds: 4), () {
      if (isOnline) _showOrderRequestPopup();
    });
  }

  void _stopListening() => _requestTimer?.cancel();

  void _showOrderRequestPopup() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_shipping, size: 48, color: Colors.blue),
                const SizedBox(height: 16),
                const Text(
                  'New Order 🚚',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Pickup: Indore\nDrop: Bhopal\nEarning: ₹320',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                const OrderDetailScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            transitionDuration: const Duration(milliseconds: 300),
                          ),
                        );
                        _onOrderAccepted();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text('View Order'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      transitionBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          )),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  void _onOrderAccepted() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Order Accepted 🚀'),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        animation: CurvedAnimation(
          parent: CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeInOut,
          ),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopListening();
    _chartController.dispose();
    super.dispose();
  }
}