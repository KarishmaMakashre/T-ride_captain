import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tryde_partner/core/constants/app_constants.dart';
import 'package:tryde_partner/features/auth/screens/language_selection_screen.dart';
import 'package:tryde_partner/features/auth/screens/login_screen.dart';
import 'package:tryde_partner/features/auth/screens/otp_screen.dart';
import 'package:tryde_partner/features/auth/screens/registration_screen.dart';
import 'package:tryde_partner/features/auth/screens/role_selection_screen.dart';
import 'package:tryde_partner/features/auth/screens/splash_screen.dart';
import 'package:tryde_partner/features/customer/porter/screens/porter_search_screen.dart';
import 'package:tryde_partner/features/customer/porter/screens/porter_sharing_screen.dart';
import 'package:tryde_partner/features/customer/porter/screens/porter_submit_screen.dart';
import 'package:tryde_partner/features/customer/ride/search/map_search_screen.dart';
import 'package:tryde_partner/features/customer/ride/search/payment_sucess_screen.dart';
import 'package:tryde_partner/features/customer/ride/search/ride_feedback_screen.dart';
import 'package:tryde_partner/features/customer/ride/search/ride_search_result_screen.dart';
import 'package:tryde_partner/features/customer/ride/search/ride_search_screen.dart';
import 'package:tryde_partner/features/customer/ride/search/track_ride_screen.dart';
import 'package:tryde_partner/features/customer/screens/history_screen.dart';
import 'package:tryde_partner/features/customer/screens/overview_screen.dart';
import 'package:tryde_partner/features/customer/screens/account_screen.dart';
import 'package:tryde_partner/features/settings/screens/language_screen.dart';
import 'package:tryde_partner/features/settings/screens/notification_screen.dart';
import 'package:tryde_partner/features/settings/screens/payment_screen.dart';
import 'package:tryde_partner/features/settings/screens/ride_sharing_screen.dart';
import 'package:tryde_partner/features/settings/screens/settings_screen.dart';
import 'package:tryde_partner/features/settings/screens/profile_screen.dart';
import 'package:tryde_partner/features/settings/screens/theme_screen.dart';
import '../features/customer/porter/screens/porter-dashboard_screen.dart';
import '../features/food/driver_dashboard.dart';
import '../features/porter_partner/screens/porter_dashboard_screen.dart';
import '../features/rider/first.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'on-bording',
      builder: (context, state) => const OnboardingScreen(),
    ),
        GoRoute(
      path: '/language-selection',
      name: 'language-selection',
      builder: (context, state) => const LanguageSelectionScreen(),
    ),
            GoRoute(
      path: '/role-selection',
      name: 'role-selection',
      builder: (context, state) => const PartnerTypeSelectionScreen(),
    ),

    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),

        GoRoute(
      path: '/registration',
      name: 'registration',
      builder: (context, state) => const RegistrationScreen(),
    ),



    // GoRoute(
    //   path: '/otp',
    //   name: 'otp',
    //   builder: (context, state) {
    //     final phone = state.extra as String?;
    //     return OTPVerificationScreen(phoneNumber: phone!,);
    //   },
    // ),

    GoRoute(
  path: '/verify-otp/:phone',
  builder: (context, state) {
    final phone = state.pathParameters['phone'] ?? '';
    return OTPVerificationScreen(phoneNumber: phone);
  },
),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
        GoRoute(
      path: '/porter-dashboard',
      name: 'porter-dashboard',
      builder: (context, state) => const PartnerDashboard(),
    ),

            GoRoute(
      path: '/porter-sharing',
      name: 'porter-sharing',
      builder: (context, state) => const PorterSharingScreen(),
    ),
    GoRoute(
      path: '/account',
      name: 'account',
      builder: (context, state) => const AccountScreen(),
    ),

    GoRoute(
      path: '/history',
      name: 'history',
      builder: (context, state) => const HistoryScreen(),
    ),
    GoRoute(
      path: '/overview',
      name: 'overview',
      builder: (context, state) => const OverviewScreen(rideId: '1'),
    ),
    GoRoute(
      path: '/ride',
      name: 'ride',
      builder: (context, state) => const RideSearchScreen(),
    ),
    GoRoute(
      path: AppConstants.routePorter,
      name: 'porter',
      builder: (context, state) => const PorterDashboardScreen(),
    ),
    GoRoute(
      path: AppConstants.routeFood,
      name: 'food',
      builder: (context, state) => const PartnerDashboardScreen(),
    ),
    GoRoute(
      path: '${AppConstants.routePorterSearch}/:vehicle',
      name: 'porter-search',
      builder: (context, state) {
        final vehicle = state.pathParameters['vehicle']!;
        final String vehicleType;
        if (vehicle == 'truck') {
          vehicleType = 'Truck';
        } else if (vehicle == 'bike') {
          vehicleType = 'Bike';
        } else {
          vehicleType = 'Car';
        }
        return PorterNewOrderScreen(vehicleType: vehicleType);
      },
    ),

    GoRoute(
      path: AppConstants.routePorterSubmit,
      name: 'porter-submit-order',
      builder: (context, state) => const PorterSubmitOrderScreen(),
    ),

    GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (context, state) => const NotificationScreen(),
    ),

    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/languages',
      name: 'languages',
      builder: (context, state) => const LanguageScreen(),
    ),

    GoRoute(
      path: '/theme',
      name: 'theme',
      builder: (context, state) => const ThemeScreen(),
    ),

    GoRoute(
      path: '/map-selection/:mode',
      name: 'map-selection',
      builder: (context, state) {
        final mode = state.pathParameters['mode']!;
        final extra = state.extra as Map<String, dynamic>? ?? {};
        final currentLatLng = extra['currentLatLng'] as LatLng?;
        return MapSelectionScreen(
          mode: mode,
          currentLatLng: currentLatLng,
          onSelected:
              extra['onSelected'] as Function(LatLng, String)? ??
              (latLng, address) {},
        );
      },
    ),
    GoRoute(
      path: '/ride-sharing',
      name: 'ride-sharing',
      builder: (context, state) => const RideSharingScreen(),
    ),

    GoRoute(
      path: '/ride-search-result',
      name: 'ride-search-result',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return RideSearchResultScreen(
          currentLatLng: extra['currentLatLng'] as LatLng,
          destinationLatLng: extra['destinationLatLng'] as LatLng,
          originAddress: extra['originAddress'] as String,
          destinationAddress: extra['destinationAddress'] as String,
          selectedRideType: extra['selectedRideType'] as String,
          selectedPrice: extra['selectedPrice'] as String,
          selectedRideOption:
              extra['selectedRideOption'] as Map<String, dynamic>,
        );
      },
    ),

    GoRoute(
      path: '/track-ride',
      name: 'track-ride',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        return TrackRideScreen(
          pickupLatLng: extra['currentLatLng'] as LatLng,
          destinationLatLng: extra['destinationLatLng'] as LatLng,
          pickupAddress: extra['originAddress'] as String,
          destinationAddress: extra['destinationAddress'] as String,
        );
      },
    ),

    GoRoute(
      path: '/payment-success',
      builder: (context, state) => const PaymentSuccessScreen(),
    ),
    GoRoute(
      path: '/ride-feedback',
      builder: (context, state) => const RideFeedbackScreen(),
    ),
    GoRoute(
      path: '/payments',
      builder: (context, state) => const PaymentScreen(),
    ),
  ],
);
