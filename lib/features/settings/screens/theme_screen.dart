// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tryde_partner/core/constants/color_constants.dart';
// import 'package:tryde_partner/providers/theme_provider.dart';

// class ThemeScreen extends StatefulWidget {
//   const ThemeScreen({super.key});

//   @override
//   State<ThemeScreen> createState() => _ThemeScreenState();
// }

// class _ThemeScreenState extends State<ThemeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,  // Dynamic bg
//       appBar: AppBar(
//         title: const Text('Theme'),  // Localize kar sakte ho
//         backgroundColor: AppColors.white,  // Ya dynamic
//         elevation: 0,
//         foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Choose Theme Mode', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             // Light Option
//             RadioListTile<ThemeMode>(
//               title: const Text('Light'),
//               subtitle: const Text('Always light theme'),
//               value: ThemeMode.light,
//               groupValue: context.watch<ThemeProvider>().themeMode,
//               onChanged: (ThemeMode? mode) {
//                 context.read<ThemeProvider>().setTheme(ThemeMode.light);
//               },
//               activeColor: AppColors.primary,
//             ),
//             // Dark Option
//             RadioListTile<ThemeMode>(
//               title: const Text('Dark'),
//               subtitle: const Text('Always dark theme'),
//               value: ThemeMode.dark,
//               groupValue: context.watch<ThemeProvider>().themeMode,
//               onChanged: (ThemeMode? mode) {
//                 context.read<ThemeProvider>().setTheme(ThemeMode.dark);
//               },
//               activeColor: AppColors.primary,
//             ),
//             // System Option
//             RadioListTile<ThemeMode>(
//               title: const Text('System'),
//               subtitle: const Text('Follow device settings'),
//               value: ThemeMode.system,
//               groupValue: context.watch<ThemeProvider>().themeMode,
//               onChanged: (ThemeMode? mode) {
//                 context.read<ThemeProvider>().setTheme(ThemeMode.system);
//               },
//               activeColor: AppColors.primary,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/providers/theme_provider.dart';
class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});
  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}
class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Dynamic bg
      appBar: AppBar(
        title: const Text('Theme'), // Localize kar sakte ho
        backgroundColor: theme.colorScheme.surface, // Dynamic
        elevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose Theme Mode', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onBackground)),
            const SizedBox(height: 20),
            // Light Option
            RadioListTile<ThemeMode>(
              title: const Text('Light'),
              subtitle: const Text('Always light theme'),
              value: ThemeMode.light,
              groupValue: context.watch<ThemeProvider>().themeMode,
              onChanged: (ThemeMode? mode) {
                context.read<ThemeProvider>().setTheme(ThemeMode.light);
              },
              activeColor: theme.colorScheme.primary,
            ),
            // Dark Option
            RadioListTile<ThemeMode>(
              title: const Text('Dark'),
              subtitle: const Text('Always dark theme'),
              value: ThemeMode.dark,
              groupValue: context.watch<ThemeProvider>().themeMode,
              onChanged: (ThemeMode? mode) {
                context.read<ThemeProvider>().setTheme(ThemeMode.dark);
              },
              activeColor: theme.colorScheme.primary,
            ),
            // System Option
            RadioListTile<ThemeMode>(
              title: const Text('System'),
              subtitle: const Text('Follow device settings'),
              value: ThemeMode.system,
              groupValue: context.watch<ThemeProvider>().themeMode,
              onChanged: (ThemeMode? mode) {
                context.read<ThemeProvider>().setTheme(ThemeMode.system);
              },
              activeColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}