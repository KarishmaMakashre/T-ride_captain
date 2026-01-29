import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'en';

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'script': 'English'},
    {'code': 'te', 'name': 'Telugu', 'script': 'తెలుగు'},
    {'code': 'hi', 'name': 'Hindi', 'script': 'हिंदी'},
    {'code': 'ta', 'name': 'Tamil', 'script': 'தமிழ்'},
    {'code': 'kn', 'name': 'Kannada', 'script': 'ಕನ್ನಡ'},
    {'code': 'ml', 'name': 'Malayalam', 'script': 'മലയാളം'},
    {'code': 'pa', 'name': 'Punjabi', 'script': 'ਪੰਜਾਬੀ'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// ================= MAIN CONTENT =================
          Column(
            children: [
              /// 🔝 FIXED HEADER with Selected Language Container
              Stack(
                children: [
                  /// BACKGROUND IMAGE WITH SHADER
                  ShaderMask(
                    shaderCallback: (Rect rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [0.65, 1.0],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      'assets/images/top-banner.png',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// LOGO
                  Positioned(
                    top: -40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 260,
                      ),
                    ),
                  ),

                  /// TITLE & SUBTITLE
                  Positioned(
                    bottom: 90, // Adjust this to move text up/down
                    left: 0,
                    right: 0,
                    child: Column(
                      children: const [
                        Text(
                          'Select Your Language',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // SizedBox(height: 6),
                        Text(
                          'Please choose your preferred language',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// SELECTED LANGUAGE CONTAINER (IMAGE KE UPAR)
                  Positioned(
                    bottom: 20, // Adjust this position
                    left: 16,
                    right: 16,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.brownPrimary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.brownPrimary.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.language,
                              color: AppColors.brownPrimary),
                          const SizedBox(width: 8),
                          const Text(
                            "Selected: ",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            "${_languages.firstWhere((e) => e['code'] == _selectedLanguage)['script']} "
                            "(${_languages.firstWhere((e) => e['code'] == _selectedLanguage)['name']})",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.brownPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              /// 🌐 LANGUAGE GRID (ONLY THIS SCROLLS)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: _languages.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.0,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      /// ➕ ADD LANGUAGE CARD
                      if (index == _languages.length) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.brownPrimary,
                                  size: 32,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Add Language",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final lang = _languages[index];
                      final isSelected = _selectedLanguage == lang['code'];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedLanguage = lang['code']!;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.brownPrimary
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                            color: isSelected
                                ? AppColors.brownPrimary.withOpacity(0.05)
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              /// ✅ TICK MARK FOR SELECTED LANGUAGE
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? AppColors.brownPrimary
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.brownPrimary
                                        : Colors.grey.shade400,
                                  ),
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lang['script']!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      lang['name']!,
                                      style: const TextStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              /// 🚚 BOTTOM BANNER (TOP FADE)
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                      stops: [0.0, 0.35],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/images/bottom-banner-2.png',
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),

          /// ✅ CONFIRM BUTTON (FIXED)
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brownPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}