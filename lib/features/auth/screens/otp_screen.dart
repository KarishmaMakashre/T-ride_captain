import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  int _timer = 30;
  late Timer _countdownTimer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 6; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }

    _startTimer();
  }

  void _startTimer() {
    _timer = 30;
    _canResend = false;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_timer > 0) {
          _timer--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendOTP() {
    if (_canResend) {
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _onOTPChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }

    if (_controllers.every((c) => c.text.isNotEmpty)) {
      _verifyOTP();
    }
  }

  void _verifyOTP() {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length == 6) {
      context.push('/role-selection');
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// ================= TOP BANNER =================
              Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.65, 1.0],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      'assets/images/top-banner.png',
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: -50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 250,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        const Text(
                          'Enter Verification Code',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            children: [
                              const TextSpan(
                                text:
                                'We\'ve sent a 6-digit verification code to\n',
                              ),
                              TextSpan(
                                text: '+91 ${widget.phoneNumber}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// ================= OTP INPUT =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 45,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,

                        // ✅ FIXED COLORS
                        cursorColor: AppColors.brownPrimary,
                        selectionControls:
                        MaterialTextSelectionControls(),

                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.brownPrimary,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (v) => _onOTPChanged(index, v),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 40),

              /// ================= VERIFY BUTTON =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _verifyOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brownPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// ================= RESEND =================
              Column(
                children: [
                  Text(
                    _canResend
                        ? 'Didn\'t receive code?'
                        : 'Resend code in $_timer seconds',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                      _canResend ? Colors.black : Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: _canResend ? _resendOTP : null,
                    child: Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _canResend
                            ? AppColors.brownPrimary
                            : Colors.grey,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.phone_iphone,
                            size: 16, color: Colors.grey),
                        SizedBox(width: 6),
                        Text(
                          'Wrong number? Change number',
                          style:
                          TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// ================= BOTTOM BANNER =================
              ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                    stops: [0.0, 0.35],
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/images/bottom-banner.png',
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
