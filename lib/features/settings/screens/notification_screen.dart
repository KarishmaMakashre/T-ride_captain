import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/color_constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _dummyNotifications = [
    {
      'tab': 'past',
      'status': 'Dropped',
      'icon': Icons.directions_car,
      'date': '2 days ago',
      'time': 'Mar 10, 2022 - 4:45 PM',
      'price': '₹28.12',
      'origin': '22, MP-10, Indore, Madhya Pradesh',
      'destination': '16, Acotel Hub, Indore, Madhya Pradesh',
      'message': 'Ride dropped successfully!',
    },
    {
      'tab': 'upcoming',
      'status': 'Upcoming',
      'icon': Icons.schedule,
      'date': 'Tomorrow',
      'time': 'Apr 09, 2025 - 10:00 AM',
      'price': '₹50.00',
      'origin': 'Your current location',
      'destination': 'Airport, Indore',
      'message': 'Upcoming ride to airport.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildNotificationItem(Map<String, dynamic> item) {
    Color statusColor =
    item['status'] == 'Dropped' ? Colors.green : AppColors.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(item['icon'], color: statusColor, size: 22),
              const SizedBox(width: 10),
              Text(
                item['status'],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
              const Spacer(),
              Text(
                item['price'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(item['origin'], style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(item['destination'], style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            item['message'],
            style: TextStyle(fontSize: 11, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textLight,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Past'),
            Tab(text: 'Upcoming'),
          ],
        ),
      ),
      body: Stack(
        children: [
          /// 🔹 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/topHeaderImage.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 WHITE OVERLAY (for readability)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.12),
            ),
          ),

          /// 🔹 CONTENT
          TabBarView(
            controller: _tabController,
            children: [
              ListView(
                padding: const EdgeInsets.all(16),
                children: _dummyNotifications
                    .where((e) => e['tab'] == 'past')
                    .map(_buildNotificationItem)
                    .toList(),
              ),
              ListView(
                padding: const EdgeInsets.all(16),
                children: _dummyNotifications
                    .where((e) => e['tab'] == 'upcoming')
                    .map(_buildNotificationItem)
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
