import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/color_constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dummy data for notifications
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
      'type': 'ride',
      'message': 'Ride dropped successfully!',
    },
    {
      'tab': 'past',
      'status': 'Cancelled',
      'icon': Icons.cancel,
      'date': '2 days ago',
      'time': 'Mar 10, 2022 - 4:45 PM',
      'price': '₹38.12',
      'origin': '22, MP-10, Indore, Madhya Pradesh',
      'destination': '16, Sharda Association, Indore, Madhya Pradesh',
      'type': 'ride',
      'message': 'Your last ride was cancelled. You have to pay ₹10 extra for next ride.',
    },
    {
      'tab': 'past',
      'status': 'Paid',
      'icon': Icons.payment,
      'date': '3 days ago',
      'time': 'Mar 25, 2022 - 1:41 AM',
      'price': '₹78.12',
      'origin': '22, Tilak Nagar, Indore, Madhya Pradesh',
      'destination': '16, Shalmali Tower, Indore, Madhya Pradesh',
      'type': 'porter',
      'message': 'Porter service paid successfully!',
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
      'type': 'ride',
      'message': 'Upcoming ride to airport.',
    },
    {
      'tab': 'upcoming',
      'status': 'Available',
      'icon': Icons.directions_car,
      'date': 'Today',
      'time': 'Apr 08, 2025 - 6:30 PM',
      'price': '₹25.00',
      'origin': 'Indore Mall',
      'destination': 'Vijay Nagar',
      'type': 'ride',
      'message': '10 rides available near you.',
    },
    {
      'tab': 'past',
      'status': 'Paid',
      'icon': Icons.payment,
      'date': '1 week ago',
      'time': 'Mar 30, 2022 - 8:20 PM',
      'price': '₹45.50',
      'origin': '22, MP-9, Indore, Madhya Pradesh',
      'destination': '16, Palasia Square, Indore, Madhya Pradesh',
      'type': 'porter',
      'message': 'Porter delivery paid successfully!',
    },
    {
      'tab': 'past',
      'status': 'Cancelled',
      'icon': Icons.cancel,
      'date': '1 week ago',
      'time': 'Mar 28, 2022 - 3:15 PM',
      'price': '₹35.00',
      'origin': '22, MP-10, Indore, Madhya Pradesh',
      'destination': '16, Rajwada, Indore, Madhya Pradesh',
      'type': 'ride',
      'message': 'Ride cancelled by driver.',
    },
    {
      'tab': 'upcoming',
      'status': 'Scheduled',
      'icon': Icons.schedule,
      'date': 'Next Week',
      'time': 'Apr 15, 2025 - 2:00 PM',
      'price': '₹60.00',
      'origin': 'Home',
      'destination': 'Office, Indore',
      'type': 'porter',
      'message': 'Scheduled porter service.',
    },
    {
      'tab': 'past',
      'status': 'Dropped',
      'icon': Icons.directions_car,
      'date': '2 weeks ago',
      'time': 'Mar 20, 2022 - 11:45 AM',
      'price': '₹32.75',
      'origin': '22, MP-7, Indore, Madhya Pradesh',
      'destination': '16, Sarafa Bazaar, Indore, Madhya Pradesh',
      'type': 'ride',
      'message': 'Ride completed successfully.',
    },
    {
      'tab': 'upcoming',
      'status': 'Alert',
      'icon': Icons.notifications_active,
      'date': 'Today',
      'time': 'Apr 08, 2025 - 5:00 PM',
      'price': 'N/A',
      'origin': 'N/A',
      'destination': 'N/A',
      'type': 'alert',
      'message': 'New update: 20% off on porter services this week!',
    },
    {
      'tab': 'past',
      'status': 'Paid',
      'icon': Icons.payment,
      'date': '1 month ago',
      'time': 'Feb 15, 2022 - 7:30 PM',
      'price': '₹55.00',
      'origin': '22, MP-11, Indore, Madhya Pradesh',
      'destination': '16, Bhawarkua, Indore, Madhya Pradesh',
      'type': 'ride',
      'message': 'Payment successful for ride.',
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
    Color statusColor = item['status'] == 'Dropped' || item['status'] == 'Paid' 
        ? Colors.green 
        : item['status'] == 'Cancelled' 
            ? Colors.red 
            : AppColors.primary;

    IconData icon = item['icon'];
    String status = item['status'];
    String date = item['date'];
    String time = item['time'];
    String price = item['price'];
    String origin = item['origin'];
    String destination = item['destination'];
    String message = item['message'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
       
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: statusColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              if (price != 'N/A')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    price,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.location_on, color: Colors.green, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(origin)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.location_on, color: Colors.red, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(destination)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textLight,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.white,
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
      body: TabBarView(
        controller: _tabController,
        children: [
          // Past Tab
          ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _dummyNotifications.where((item) => item['tab'] == 'past').length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey[300], height: 1),
            itemBuilder: (context, index) {
              final item = _dummyNotifications.where((item) => item['tab'] == 'past').toList()[index];
              return _buildNotificationItem(item);
            },
          ),
          // Upcoming Tab
          ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _dummyNotifications.where((item) => item['tab'] == 'upcoming').length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey[300], height: 1),
            itemBuilder: (context, index) {
              final item = _dummyNotifications.where((item) => item['tab'] == 'upcoming').toList()[index];
              return _buildNotificationItem(item);
            },
          ),
        ],
      ),
    );
  }
}