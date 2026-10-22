import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/features/auth/login_screen.dart';
import 'package:vehiclehub_pakistan/features/auth/otp_screen.dart';
import 'package:vehiclehub_pakistan/features/auth/signup_screen.dart';
import 'package:vehiclehub_pakistan/features/auth/vehicle_register_screen.dart';
import 'package:vehiclehub_pakistan/features/documents/documents_screen.dart';
import 'package:vehiclehub_pakistan/features/emergency/emergency_screen.dart';
import 'package:vehiclehub_pakistan/features/expenses/add_expense_screen.dart';
import 'package:vehiclehub_pakistan/features/expenses/fuel_screen.dart';
import 'package:vehiclehub_pakistan/features/garage/service_history_screen.dart';
import 'package:vehiclehub_pakistan/features/garage/vehicle_details_screen.dart';
import 'package:vehiclehub_pakistan/features/mechanics/booking_screen.dart';
import 'package:vehiclehub_pakistan/features/mechanics/booking_success_screen.dart';
import 'package:vehiclehub_pakistan/features/mechanics/mechanic_profile_screen.dart';
import 'package:vehiclehub_pakistan/features/notifications/notifications_screen.dart';
import 'package:vehiclehub_pakistan/features/onboarding/language_screen.dart';
import 'package:vehiclehub_pakistan/features/onboarding/onboarding_screen.dart';
import 'package:vehiclehub_pakistan/features/search/search_screen.dart';
import 'package:vehiclehub_pakistan/features/settings/settings_screen.dart';
import 'package:vehiclehub_pakistan/features/shell/main_shell.dart';
import 'package:vehiclehub_pakistan/features/splash/splash_screen.dart';
import 'package:vehiclehub_pakistan/features/system/design_system_screen.dart';
import 'package:vehiclehub_pakistan/features/system/empty_states_screen.dart';
import 'package:vehiclehub_pakistan/features/system/error_states_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/language',
        builder: (_, __) => const LanguageScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (_, __) => const SignupScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (_, state) => OtpScreen(
          phone: state.extra as String?,
        ),
      ),
      GoRoute(
        path: '/vehicle-register',
        builder: (_, __) => const VehicleRegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (_, __) => const MainShellHomeTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/garage',
                builder: (_, __) => const MainShellGarageTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/mechanics',
                builder: (_, __) => const MainShellMechanicsTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/expenses',
                builder: (_, __) => const MainShellExpensesTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (_, __) => const MainShellProfileTab(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/garage/:id',
        builder: (_, state) => VehicleDetailsScreen(
          vehicleId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/garage/:id/history',
        builder: (_, state) => ServiceHistoryScreen(
          vehicleId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/mechanics/:id',
        builder: (_, state) => MechanicProfileScreen(
          mechanicId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/mechanics/:id/book',
        builder: (_, state) => BookingScreen(
          mechanicId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/booking-success',
        builder: (_, __) => const BookingSuccessScreen(),
      ),
      GoRoute(
        path: '/expenses/add',
        builder: (_, __) => const AddExpenseScreen(),
      ),
      GoRoute(
        path: '/expenses/fuel',
        builder: (_, __) => const FuelScreen(),
      ),
      GoRoute(
        path: '/emergency',
        builder: (_, __) => const EmergencyScreen(),
      ),
      GoRoute(
        path: '/documents',
        builder: (_, __) => const DocumentsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (_, __) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (_, __) => const SearchScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/design-system',
        builder: (_, __) => const DesignSystemScreen(),
      ),
      GoRoute(
        path: '/empty-states',
        builder: (_, __) => const EmptyStatesScreen(),
      ),
      GoRoute(
        path: '/error-states',
        builder: (_, __) => const ErrorStatesScreen(),
      ),
    ],
  );
});
