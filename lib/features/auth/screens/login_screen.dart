import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

import '../../../core/constants/size_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  Color _buttonColor = AppColors.primary;

  bool _acceptTerms = false;

  String? _userRole;
  String _backgroundImage =
      'https://images.unsplash.com/photo-1558981806-ec527fa84c39';

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role');
    final colorValue = prefs.getInt('user_color');

    setState(() {
      _userRole = role;

      if (colorValue != null) {
        _buttonColor = Color(colorValue);
      }

      if (role == 'food') {
        _backgroundImage =
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836';
      } else if (role == 'porter') {
        _backgroundImage =
        'https://images.unsplash.com/photo-1563738710386-99d1ce93e755?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDJ8fGJsdWUlMjBiaWtlfGVufDB8fDB8fHww';
      } else {
        _backgroundImage =
        'https://images.unsplash.com/photo-1558981806-ec527fa84c39';
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);

    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 BACKGROUND IMAGE (NO BLUR)
          Positioned.fill(
            child: Image.network(
              _backgroundImage,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 LIGHT GRADIENT OVERLAY (NOT BLUR)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.45),
                    Colors.black.withOpacity(0.85),
                  ],
                ),
              ),
            ),
          ),

          /// 🔹 CONTENT
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.hp,
                vertical: AppSizes.vp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 TOP BAR
                  InkWell(
                    onTap: () => context.pop(),
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.headset_mic, color: Colors.white),
                          label: const Text(
                            'Help',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),


                  SizedBox(height: AppSizes.spaceXL),

                  /// 🔹 TITLE
                  Row(
                    children: [
                      CircleAvatar(
                        radius: AppSizes.avatarRadius,
                        backgroundColor: Colors.white.withOpacity(0.15),
                        child: const Icon(
                          Icons.phone,
                          color: Colors.white, // 👈 FIX
                        ),
                      ),

                      const SizedBox(width: 12),
                      Text(
                        _userRole == 'food'
                            ? 'Login as Food Partner'
                            : _userRole == 'porter'
                            ? 'Login as Porter Partner'
                            : 'Login as Rider Partner',
                        style: TextStyle(
                          fontSize: AppSizes.title,
                          fontWeight: FontWeight.w600,
                          color: Colors.white, // 👈 FIX
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: AppSizes.spaceL),

                  /// 🔹 PHONE FIELD
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text(
                          '+91',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            style: const TextStyle(
                              color: Colors.black, // 👈 typing visible
                              fontSize: 16,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              hintText: 'Enter phone number',
                              hintStyle: TextStyle(
                                color: Colors.white60, // 👈 hint visible
                              ),
                              border: InputBorder.none,
                              counterText: '',
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  /// 🔹 TERMS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        activeColor: _buttonColor,
                        checkColor: Colors.white,
                        side: const BorderSide(         // 👈 IMPORTANT
                          color: Colors.white,          // ✔ border visible
                          width: 2,
                        ),
                        onChanged: (v) =>
                            setState(() => _acceptTerms = v ?? false),
                      ),
                      const Text(
                        'I agree to the ',
                        style: TextStyle(color: Colors.white), // 👈 FIX
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            color: Colors.lightBlueAccent, // 👈 better contrast
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: AppSizes.spaceS),

                  /// 🔹 PROCEED BUTTON
                  SizedBox(
                    width: double.infinity,
                    child:ElevatedButton(
                      onPressed: _acceptTerms
                          ? () {
                        context.push(
                          '/otp',
                          extra: _phoneController.text,
                        );
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _buttonColor, // 👈 dynamic color
                        disabledBackgroundColor: _buttonColor.withOpacity(0.4),
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizes.buttonPadding,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Proceed',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
