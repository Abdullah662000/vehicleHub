import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_empty_state.dart';

class EmptyStatesScreen extends ConsumerWidget {
  const EmptyStatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(tr('noExpenses', lang))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VhEmptyState(
            icon: Icons.receipt_long_outlined,
            title: tr('noExpenses', lang),
            description: tr('noExpensesDesc', lang),
            actionLabel: tr('addExpense', lang),
            onAction: () {},
          ),
          const SizedBox(height: 32),
          VhEmptyState(
            icon: Icons.garage_outlined,
            title: tr('addFirstVehicle', lang),
            description: tr('addFirstVehicleDesc', lang),
            actionLabel: tr('addVehicle', lang),
            onAction: () {},
          ),
          const SizedBox(height: 32),
          VhEmptyState(
            icon: Icons.build_outlined,
            title: tr('noSavedMechanics', lang),
            description: tr('findMechanics', lang),
          ),
        ],
      ),
    );
  }
}
