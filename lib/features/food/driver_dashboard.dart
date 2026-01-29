import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryde_partner/features/food/partner_profile_screen.dart';
import 'package:tryde_partner/features/food/wallet_screen.dart';
import 'package:tryde_partner/features/food/widgets/top_header.dart';
import 'package:tryde_partner/providers/location_provider.dart';
import '../../core/constants/color_constants.dart';
import 'order_req_screen.dart';

double sw(BuildContext context) => MediaQuery.of(context).size.width;
double sh(BuildContext context) => MediaQuery.of(context).size.height;

/// ===================== MAIN DASHBOARD =====================

class PartnerDashboardScreen extends StatefulWidget {
  const PartnerDashboardScreen({super.key});

  @override
  State<PartnerDashboardScreen> createState() =>
      _PartnerDashboardScreenState();
}

class _PartnerDashboardScreenState extends State<PartnerDashboardScreen> {
  int _currentIndex = 0;
  bool _isOnline = false;

  static const String onlineSoundUrl =
      "https://actions.google.com/sounds/v1/cartoon/wood_plank_flicks.ogg";

  static const String offlineSoundUrl =
      "https://actions.google.com/sounds/v1/cartoon/clang_and_wobble.ogg";

  final List<Widget> _screens = const [
    DashboardHome(),
    OrderListScreen(),
    WalletScreen(),
    PartnerProfileScreen(),
  ];

  void onStatusChanged(bool value) {
    setState(() {
      _isOnline = value;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<LocationProvider>().fetchCurrentLocation();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: TopHeader(
        isOnline: _isOnline,
        onStatusChanged: onStatusChanged,
      ),

      body: Stack(
        children: [
          /// 🌄 GLOBAL BACKGROUND IMAGE
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/topHeaderImage.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🌑 GLOBAL OVERLAY
          Container(
            color: Colors.black.withOpacity(0.18),
          ),

          /// 🚀 PAGE CONTENT
          _screens[_currentIndex],
        ],
      ),

      bottomNavigationBar: PartnerBottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }

  /// ================= APP BAR =================
  // AppBar _buildAppBar() {
  //   return AppBar(
  //     backgroundColor: AppColors.white,
  //     elevation: 0,
  //     toolbarHeight: 90,
  //     titleSpacing: 0,
  //
  //     title: Consumer<LocationProvider>(
  //       builder: (context, locationProvider, _) {
  //         return Row(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(left: 16, right: 12),
  //               child: CircleAvatar(
  //                 radius: 22,
  //                 backgroundColor:
  //                 AppColors.foodPrimary.withOpacity(0.1),
  //                 child: const Icon(
  //                   Icons.person,
  //                   color: AppColors.foodPrimary,
  //                 ),
  //               ),
  //             ),
  //
  //             Expanded(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     "Welcome 👋",
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: AppColors.textSecondary,
  //                     ),
  //                   ),
  //                   const Text(
  //                     "Delivery Partner",
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 2),
  //
  //                   locationProvider.isLoading
  //                       ? const Text(
  //                     "Fetching location...",
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: AppColors.textSecondary,
  //                     ),
  //                   )
  //                       : Row(
  //                     children: [
  //                       const Icon(
  //                         Icons.location_on,
  //                         size: 14,
  //                         color: AppColors.foodPrimary,
  //                       ),
  //                       const SizedBox(width: 4),
  //                       Expanded(
  //                         child: Text(
  //                           locationProvider
  //                               .currentAddress.isNotEmpty
  //                               ? locationProvider.currentAddress
  //                               : "Location not available",
  //                           maxLines: 1,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: const TextStyle(
  //                             fontSize: 12,
  //                             color: AppColors.textSecondary,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //
  //     actions: [
  //       OnlineStatusToggle(
  //         initialStatus: _isOnline,
  //         onChanged: (value) {
  //           setState(() {
  //             _isOnline = value;
  //             if (value) _currentIndex = 0;
  //           });
  //
  //           if (value) {
  //             showModalBottomSheet(
  //               context: context,
  //               isScrollControlled: true,
  //               backgroundColor: Colors.transparent,
  //               builder: (_) => const OrderRequestBottomSheet(),
  //             );
  //           }
  //         },
  //       ),
  //       const SizedBox(width: 8),
  //       IconButton(
  //         icon: const Icon(Icons.notifications_none),
  //         onPressed: () {},
  //       ),
  //     ],
  //   );
  // }
}

/// ===================== HOME =====================
class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 🔥 BACKGROUND IMAGE
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/topHeaderImage.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        /// 🔥 OPTIONAL DARK OVERLAY (remove if not needed)
        Container(
          color: Colors.black.withOpacity(0.12),
        ),

        /// 🔥 MAIN CONTENT
        SingleChildScrollView(
          padding: EdgeInsets.all(sw(context) * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              EarningsHeroCard(),
              SizedBox(height: 20),

              SectionTitle("Earnings Summary"),
              SizedBox(height: 10),
              EarningsSummary(),

              SizedBox(height: 30),
              SectionTitle("Order History"),
              OrderHistory(),

              SizedBox(height: 20),
              SectionTitle("Wallet Balance"),
              WalletBalanceCard(),

              SizedBox(height: 20),
              SectionTitle("Ratings & Reviews"),
              RatingsCard(),
            ],
          ),
        ),
      ],
    );
  }
}

/// ===================== SECTION TITLE =====================
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: sw(context) * 0.045,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// ===================== ONLINE CHIP =====================

class OnlineStatusToggle extends StatefulWidget {
  final bool initialStatus;
  final ValueChanged<bool>? onChanged;

  const OnlineStatusToggle({
    super.key,
    required this.initialStatus,
    this.onChanged,
  });

  @override
  State<OnlineStatusToggle> createState() => _OnlineStatusToggleState();
}

class _OnlineStatusToggleState extends State<OnlineStatusToggle> {
  late bool isOnline;

  @override
  void initState() {
    super.initState();
    isOnline = widget.initialStatus;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isOnline = !isOnline);
        widget.onChanged?.call(isOnline);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 90,
        height: 36,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isOnline
              ? AppColors.success
              : AppColors.error,
        ),
        child: Stack(
          children: [
            // ON / OFF TEXT
            Align(
              alignment:
              isOnline ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  isOnline ? "ON" : "OFF",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            // THUMB
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment:
              isOnline ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===================== EARNINGS HERO =====================
class EarningsHeroCard extends StatelessWidget {
  const EarningsHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          debugPrint("Today's Earnings tapped");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const WalletScreen()),
          );
        },
        child: Container(
          width: double.infinity, // 🔥 FULL WIDTH
          padding: EdgeInsets.all(sw(context) * 0.06),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [
                AppColors.foodPrimary,
                AppColors.foodPrimaryDark,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TODAY'S EARNINGS",
                style: TextStyle(
                  color: AppColors.white70,
                  fontSize: sw(context) * 0.03,
                ),
              ),
              SizedBox(height: sw(context) * 0.02),
              Text(
                "₹1,240",
                style: TextStyle(
                  fontSize: sw(context) * 0.1,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

/// ===================== EARNINGS SUMMARY =====================
class EarningsSummary extends StatelessWidget {
  const EarningsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _SummaryTile("Today", "₹1,240", Icons.today, AppColors.success),
        _SummaryTile("Week", "₹6,520", Icons.date_range, AppColors.foodPrimary),
        _SummaryTile("Month", "₹24,300", Icons.calendar_month, AppColors.warning),
      ],
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;

  const _SummaryTile(this.title, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    final w = sw(context);

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(
          vertical: w * 0.03,
          horizontal: w * 0.02,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.04),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: w * 0.045, // smaller icon
            ),
            SizedBox(height: w * 0.01),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: w * 0.035, // smaller text
              ),
            ),
            SizedBox(height: w * 0.005),
            Text(
              title,
              style: TextStyle(
                fontSize: w * 0.028,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===================== ORDER HISTORY =====================
class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _OrderRow("Domino's Pizza", "#ORD1023", "Completed", AppColors.success),
        _OrderRow("KFC", "#ORD1021", "Cancelled", AppColors.error),
        _OrderRow("Burger King", "#ORD1019", "Completed", AppColors.success),
      ],
    );
  }
}

class _OrderRow extends StatelessWidget {
  final String name, orderId, status;
  final Color color;

  const _OrderRow(this.name, this.orderId, this.status, this.color);

  @override
  Widget build(BuildContext context) {
    return _PremiumCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            debugPrint("Order tapped: $orderId");

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrderListScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4), // tap area better
            child: Row(
              children: [
                const Icon(Icons.restaurant,
                    color: AppColors.foodPrimary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        orderId,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(status),
                  backgroundColor: color.withOpacity(0.15),
                  labelStyle: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ===================== WALLET =====================
class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _PremiumCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => WalletScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: const [
                Icon(
                  Icons.account_balance_wallet,
                  color: AppColors.foodPrimary,
                  size: 30,
                ),
                SizedBox(width: 8),
                Text(
                  "₹3,480",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ===================== RATINGS =====================
class RatingsCard extends StatelessWidget {
  const RatingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _PremiumCard(
      child: Row(
        children: const [
          Icon(Icons.star, color: AppColors.warning, size: 30),
          SizedBox(width: 10),
          Text("4.7 / 5",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

/// ===================== COMMON CARD =====================
class _PremiumCard extends StatelessWidget {
  final Widget child;
  const _PremiumCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(sw(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// ===================== BOTTOM NAV =====================
class PartnerBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PartnerBottomNav(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.foodPrimary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "Orders"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
