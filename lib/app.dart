import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tryde_partner/core/constants/app_theme.dart';
import 'package:tryde_partner/l10n/app_localizations.dart';
import 'package:tryde_partner/providers/local_provider.dart';
import 'package:tryde_partner/routes/app_routes.dart';

import '../providers/theme_provider.dart';  // ThemeProvider import


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocaleProvider, ThemeProvider>(  // MultiConsumer ki jagah Consumer2
      builder: (context, localeProvider, themeProvider, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: "Tryde",
          locale: localeProvider.locale,  // Dynamic locale
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          themeMode: themeProvider.themeMode,  // Dynamic theme mode
          theme: lightTheme,  // Light theme define
          darkTheme: darkTheme,  // Dark theme define
          routerConfig: appRouter,
        );
      },
    );
  }
}