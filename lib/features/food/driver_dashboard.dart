import 'package:flutter/material.dart';
import 'package:tryde_partner/features/food/partner_profile_screen.dart';
import 'package:tryde_partner/features/food/wallet_screen.dart';
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
  bool _isOnline = true;

  final List<Widget> _screens = const [
    DashboardHome(),
    OrderListScreen(),
    WalletScreen(),
    PartnerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: _buildAppBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: PartnerBottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Good Afternoon 👋",
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text("Delivery Partner",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () => setState(() => _isOnline = !_isOnline),
          child: _OnlineStatusChip(isOnline: _isOnline),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),
      ],
    );
  }
}

/// ===================== HOME =====================
class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
class _OnlineStatusChip extends StatelessWidget {
  final bool isOnline;
  const _OnlineStatusChip({required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isOnline
            ? AppColors.success.withOpacity(0.15)
            : AppColors.error.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isOnline ? "ONLINE" : "OFFLINE",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isOnline ? AppColors.success : AppColors.error,
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
