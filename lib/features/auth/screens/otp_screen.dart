import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/color_constants.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({
    super.key,
    required this.phone,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(6, (_) => FocusNode());

  String _backgroundImage =
      'https://images.unsplash.com/photo-1558981806-ec527fa84c39';

  Color _primaryColor = AppColors.primary;

  @override
  void initState() {
    super.initState();
    _loadUserRole();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  /// 🔹 LOAD ROLE, COLOR & BACKGROUND
  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role');
    final colorValue = prefs.getInt('user_color');

    setState(() {
      if (colorValue != null) {
        _primaryColor = Color(colorValue);
      }

      if (role == 'food') {
        _backgroundImage =
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836';
      } else if (role == 'porter') {
        _backgroundImage =
        'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2';
      } else {
        _backgroundImage =
        'https://images.unsplash.com/photo-1558981806-ec527fa84c39';
      }
    });
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Widget _otpBox(int index) {
    return SizedBox(
      width: 46,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (v) => _onOtpChanged(v, index),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _primaryColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }

  void _verifyOtp() {
    final otp = _controllers.map((e) => e.text).join();
    if (otp.length == 6) {
      context.push('/registration');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.network(
              _backgroundImage,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 DARK GRADIENT OVERLAY (WEB SAFE)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.55),
                    Color.fromRGBO(0, 0, 0, 0.9),
                  ],
                ),
              ),
            ),
          ),

          /// 🔹 CONTENT
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
                vertical: size.height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 BACK
                  InkWell(
                    onTap: () => context.pop(),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.06),

                  /// 🔹 TITLE
                  Row(
                    children: [
                      CircleAvatar(
                        radius: isSmall ? 18 : 22,
                        backgroundColor: Color.fromRGBO(
                          _primaryColor.red,
                          _primaryColor.green,
                          _primaryColor.blue,
                          0.2,
                        ),
                        child: Icon(
                          Icons.lock_outline,
                          size: 18,
                          color: _primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'OTP Verification',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Enter OTP sent to +91 ${widget.phone}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),

                  SizedBox(height: size.height * 0.05),

                  /// 🔹 OTP CARD
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          blurRadius: 14,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (i) => _otpBox(i)),
                    ),
                  ),

                  const Spacer(),

                  /// 🔹 VERIFY BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        padding: EdgeInsets.symmetric(
                          vertical: isSmall ? 14 : 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Verify OTP',
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
