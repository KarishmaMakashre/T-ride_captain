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
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [

            /// ☰ MENU + WELCOME (LEFT)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DriverMenuScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: const NetworkImage(
                      "https://images.unsplash.com/photo-1619895862022-09114b41f16f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8fDA%3D",
                    ),
                  ),
                  const SizedBox(width: 12),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome 👋",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Ratanlok Colony,Indore",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// SPACE BETWEEN LEFT & RIGHT
            const Spacer(),

            /// 🔄 DUTY SWITCH (RIGHT)
            DutySwitch(
              initialValue: true,
              onChanged: onDutyChanged,
            ),

            const SizedBox(width: 8),

            /// 🔔 NOTIFICATION
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
                    size: 32,
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
        width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isOnDuty ? Colors.green : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Stack(
          children: [

            /// ✅ ON / OFF TEXT (ALWAYS VISIBLE)
            AnimatedAlign(
              alignment: isOnDuty
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              duration: const Duration(milliseconds: 250),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  isOnDuty ? "ON" : "OFF",
                  style: TextStyle(
                    color: isOnDuty ? Colors.white : Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            /// ⚪ SLIDING THUMB
            AnimatedAlign(
              alignment: isOnDuty
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              duration: const Duration(milliseconds: 250),
              child: Container(
                height: 24,
                width: 24,
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
