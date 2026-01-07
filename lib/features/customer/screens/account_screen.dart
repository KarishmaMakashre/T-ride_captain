import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/color_constants.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              context.push('/notifications'); // Navigate to Notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // -------------------- USER PROFILE TOP --------------------
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: 26,
                        color: AppColors.primary,
                      ), // Assume placeholder
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Handle profile photo edit (e.g., image picker)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Edit Profile Photo')),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Amrita Sharma',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '22 MP - Indore, Madhya Pradesh',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // -------------------- MENU ITEMS --------------------
            _menuItem(Icons.person, 'Account', () {
              // Navigate to Account Details sub-screen
              context.push('/profile');
            }),
            _menuItem(Icons.payment, 'Payment', () {
              // Navigate to Payment screen
              context.push('/payment');
            }),
            _menuItem(Icons.history, 'My Rides', () {
              // Navigate to History screen (already exists)
              context.push('/history');
            }),
            _menuItem(Icons.notifications, 'Ride Sharing', () {
              // Navigate to Ride Sharing Settings (from earlier)
              context.push('/ride-sharing');
            }),
            _menuItem(Icons.security, 'Safety', () {
              // Navigate to Safety screen
              context.push('/safety');
            }),
            _menuItem(Icons.share, 'Refer & Earn', () {
              // Navigate to Refer & Earn screen
              context.push('/refer-earn');
            }),
            _menuItem(Icons.help, 'Help', () {
              // Navigate to Help screen
              context.push('/help');
            }),
            _menuItem(Icons.card_giftcard, 'My Rewards', () {
              // Navigate to Rewards screen
              context.push('/rewards');
            }),
            _menuItem(Icons.description, 'Claims', () {
              // Navigate to Claims screen
              context.push('/claims');
            }),
            _menuItem(Icons.notifications, 'Notifications', () {
              // Navigate to Notifications screen
              context.push('/notifications');
            }),
            _menuItem(Icons.settings, 'Settings', () {
              // Navigate to Settings screen
              context.push('/settings');
            }),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: AppColors.textLight,
            ),
          ],
        ),
      ),
    );
  }
}
