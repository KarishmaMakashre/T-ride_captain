import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Makes the screen scrollable when keyboard opens
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// ================= TOP BANNER =================
                      Stack(
                        children: [
                          /// BACKGROUND IMAGE WITH SHADER
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

                          /// LOGO
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

                          /// TITLE & SUBTITLE
                          Positioned(
                            bottom: 40,
                            left: 16,
                            right: 16,
                            child: Column(
                              children: const [
                                Text(
                                  'Enter Your Phone Number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Please enter your mobile number to get started',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// ================= FORM =================
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            /// PHONE FIELD
                            TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              decoration: InputDecoration(
                                labelText: '+91 ----- -----',
                                counterText: '',
                                prefixIcon: const Icon(Icons.phone),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// TERMS & CONDITIONS CHECKBOX
                            Row(
                              children: [
                                Checkbox(
                                  value: _agreeTerms,
                                  onChanged: (val) {
                                    setState(() {
                                      _agreeTerms = val ?? false;
                                    });
                                  },
                                ),
                                const Expanded(
                                  child: Text(
                                    'I agree to the Terms of Services and Privacy Policy ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            /// LOGIN BUTTON
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  final phone = _phoneController.text.trim();
                                  if (phone.isEmpty || !_agreeTerms) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          phone.isEmpty
                                              ? 'Please enter phone number'
                                              : 'Please agree to terms & services',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final phoneNumber = _phoneController.text
                                      .trim();
                                  if (phoneNumber.isEmpty || !_agreeTerms) {
                                    // Show error
                                    return;
                                  }

                                  // Option 1: Path parameters ke saath
                                  context.push('/verify-otp/$phoneNumber');

                                  // Navigate to next screen
                                  // context.push('/otp');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.brownPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      /// ================= BOTTOM BANNER =================
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ShaderMask(
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
