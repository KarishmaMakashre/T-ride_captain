import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/location_provider.dart';
import '../../rider/driver_menu_screen.dart';
import '../../settings/screens/notification_screen.dart';
import '../../settings/screens/profile_screen.dart';
import '../driver_dashboard.dart';
import '../order_req_screen.dart';

class TopHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool isOnline;
  final ValueChanged<bool> onStatusChanged;

  const TopHeader({
    super.key,
    required this.isOnline,
    required this.onStatusChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(90); // 🔽 height reduced

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 90, // 🔽 same as preferredSize
      titleSpacing: 0,

      title: Consumer<LocationProvider>(
        builder: (context, locationProvider, _) {
          return Padding(
            padding: const EdgeInsets.only(top: 6), // 🔽 reduced
            child: Row(
              children: [
                const SizedBox(width: 16),

                /// 👤 PROFILE IMAGE
                InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (_) => DriverMenuScreen()));
                    print("Profile tapped");
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1619895862022-09114b41f16f?w=600',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return const Icon(
                            Icons.person,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                /// 📝 TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center, // ✅ center align
                    children: [
                      const Text(
                        "Welcome 👋",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black45,
                        ),
                      ),
                      const Text(
                        "Rahul Sharma",
                        style: TextStyle(
                          fontSize: 16, // 🔽 slightly reduced
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),

                      locationProvider.isLoading
                          ? const Text(
                        "Fetching location...",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black45,
                        ),
                      )
                          : Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 13,
                            color: Colors.black45,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              locationProvider.currentAddress.isNotEmpty
                                  ? locationProvider.currentAddress
                                  : "Location not available",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 6), // 🔽 reduced
          child: OnlineStatusToggle(
            initialStatus: isOnline,
            onChanged: (value) {
              onStatusChanged(value);
              if (value) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const OrderRequestBottomSheet(),
                );
              }
            },
          ),
        ),
        const SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(top: 6), // 🔽 reduced
          child: IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black45,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationScreen()));
            },
          ),
        ),
      ],
    );
  }
}
