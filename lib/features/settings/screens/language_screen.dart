import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tryde_partner/core/constants/app_constants.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/providers/local_provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primary,  // Screen color primary
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Language',  // Yeh localize kar sakte ho baad mein
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 50),
            // English Button
            ElevatedButton(
              onPressed: () {
                localeProvider.setLocale(const Locale('en'));
                // Optional: Home screen par navigate karo
                context.push(AppConstants.routeHome);
              },
              child: Text('English'),
            ),
            SizedBox(height: 20),
            // Hindi Button
            ElevatedButton(
              onPressed: () {
                localeProvider.setLocale(const Locale('hi'));
                context.push(AppConstants.routeHome);
              },
              child: Text('हिंदी'),  // Hindi text
            ),
          ],
        ),
      ),
    );
  }
}