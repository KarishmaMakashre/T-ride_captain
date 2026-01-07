import 'package:flutter/material.dart';
import 'package:tryde_partner/features/settings/screens/notification_screen.dart';

import 'driver_menu_screen.dart';

/// ================= CUSTOM HOME APP BAR =================

class CustomHomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(bool)? onDutyChanged;

  const CustomHomeAppBar({super.key, this.onDutyChanged});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// ☰ MENU
            IconButton(
              icon: const Icon(Icons.menu, size: 28, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DriverMenuScreen(),
                  ),
                );
              },
            ),

            /// 🔄 DUTY SWITCH
            DutySwitch(
              initialValue: true,
              onChanged: onDutyChanged,
            ),

            /// 🔔 RIGHT ICONS
            Row(
              children: [
                const Icon(Icons.favorite_outline,
                    size: 25, color: Colors.black87),
                const SizedBox(width: 18),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.notifications_active_rounded,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        height: 18,
                        width: 18,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            "1",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= DUTY SWITCH =================

class DutySwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final bool initialValue;

  const DutySwitch({
    super.key,
    this.onChanged,
    this.initialValue = true,
  });

  @override
  State<DutySwitch> createState() => _DutySwitchState();
}

class _DutySwitchState extends State<DutySwitch> {
  late bool isOnDuty;

  @override
  void initState() {
    super.initState();
    isOnDuty = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isOnDuty = !isOnDuty);
        widget.onChanged?.call(isOnDuty);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 38,
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isOnDuty ? Colors.green : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Center(
              child: Text(
                isOnDuty ? "ON" : "OFF",
                style: TextStyle(
                  color: isOnDuty ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            AnimatedAlign(
              alignment: isOnDuty
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              duration: const Duration(milliseconds: 250),
              child: Container(
                height: 26,
                width: 26,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
