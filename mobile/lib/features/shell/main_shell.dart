import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/features/expenses/expenses_screen.dart';
import 'package:vehiclehub_pakistan/features/garage/garage_screen.dart';
import 'package:vehiclehub_pakistan/features/home/home_screen.dart';
import 'package:vehiclehub_pakistan/features/mechanics/mechanics_screen.dart';
import 'package:vehiclehub_pakistan/features/profile/profile_screen.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _icons = [
    Icons.home_outlined,
    Icons.garage_outlined,
    Icons.build_outlined,
    Icons.receipt_long_outlined,
    Icons.person_outline,
  ];
  static const _activeIcons = [
    Icons.home,
    Icons.garage,
    Icons.build,
    Icons.receipt_long,
    Icons.person,
  ];
  static const _labels = ['home', 'garage', 'mechanics', 'expenses', 'profile'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final index = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: (isDark ? AppColors.elevatedDark : AppColors.elevated)
                  .withValues(alpha: 0.85),
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.border,
                ),
              ),
            ),
            child: NavigationBar(
              selectedIndex: index,
              height: 72,
              backgroundColor: Colors.transparent,
              elevation: 0,
              indicatorColor: AppColors.primary.withValues(alpha: 0.12),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              onDestinationSelected: (i) {
                navigationShell.goBranch(
                  i,
                  initialLocation: i == navigationShell.currentIndex,
                );
              },
              destinations: List.generate(5, (i) {
                return NavigationDestination(
                  icon: Icon(_icons[i]),
                  selectedIcon: Icon(
                    _activeIcons[i],
                    color: isDark ? AppColors.primaryDark : AppColors.primary,
                  ),
                  label: tr(_labels[i], lang),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tab screens used by the shell branch navigator.
class MainShellHomeTab extends StatelessWidget {
  const MainShellHomeTab({super.key});

  @override
  Widget build(BuildContext context) => const HomeScreen();
}

class MainShellGarageTab extends StatelessWidget {
  const MainShellGarageTab({super.key});

  @override
  Widget build(BuildContext context) => const GarageScreen();
}

class MainShellMechanicsTab extends StatelessWidget {
  const MainShellMechanicsTab({super.key});

  @override
  Widget build(BuildContext context) => const MechanicsScreen();
}

class MainShellExpensesTab extends StatelessWidget {
  const MainShellExpensesTab({super.key});

  @override
  Widget build(BuildContext context) => const ExpensesScreen();
}

class MainShellProfileTab extends StatelessWidget {
  const MainShellProfileTab({super.key});

  @override
  Widget build(BuildContext context) => const ProfileScreen();
}
