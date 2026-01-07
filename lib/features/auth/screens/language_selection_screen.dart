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

  void _showAddLanguageDialog() {
    final nameController = TextEditingController();
    final scriptController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Add Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Language Name (English)",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: scriptController,
                decoration: const InputDecoration(
                  labelText: "Language Script",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brownPrimary,
              ),
              onPressed: () {
                if (nameController.text.isEmpty ||
                    scriptController.text.isEmpty) {
                  return;
                }

                setState(() {
                  final code =
                  nameController.text.toLowerCase().substring(0, 2);

                  _languages.add({
                    'code': code,
                    'name': nameController.text,
                    'script': scriptController.text,
                  });

                  _selectedLanguage = code;
                });

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Select a language to continue',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          /// ✅ SELECTED LANGUAGE SHOW
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.brownPrimary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.brownPrimary.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.language,
                  color: AppColors.brownPrimary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Selected: ",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  "${_languages.firstWhere(
                        (e) => e['code'] == _selectedLanguage,
                  )['script']} "
                      "(${_languages.firstWhere(
                        (e) => e['code'] == _selectedLanguage,
                  )['name']})",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.brownPrimary,
                  ),
                ),
              ],
            ),
          ),

          /// 🌐 LANGUAGE GRID
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: _languages.length + 1,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  /// ➕ ADD LANGUAGE
                  if (index == _languages.length) {
                    return GestureDetector(
                      onTap: _showAddLanguageDialog,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  /// 🌐 LANGUAGE CARD
                  final lang = _languages[index];
                  final isSelected =
                      _selectedLanguage == lang['code'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLanguage = lang['code']!;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.brownPrimary
                              : Colors.grey.shade300,
                          width: isSelected ? 1.5 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          /// RADIO
                          Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.brownPrimary
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.brownPrimary,
                                ),
                              ),
                            )
                                : null,
                          ),

                          /// TEXT
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lang['script']!,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  lang['name']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (isSelected)
                            const Icon(
                              Icons.check,
                              color: AppColors.brownPrimary,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// ✅ CONFIRM BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/role-selection');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brownPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Confirm',
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
