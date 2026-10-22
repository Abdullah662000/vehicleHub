import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/data/models/vehicle.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_badge.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_empty_state.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vehicle_art.dart';

class GarageScreen extends ConsumerWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final vehiclesAsync = ref.watch(vehiclesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('myGarage', lang)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => context.push('/vehicle-register'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/vehicle-register'),
        icon: const Icon(Icons.add),
        label: Text(tr('addVehicle', lang)),
      ),
      body: vehiclesAsync.when(
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return VhEmptyState(
              icon: Icons.garage_outlined,
              title: tr('addFirstVehicle', lang),
              description: tr('addFirstVehicleDesc', lang),
              actionLabel: tr('addVehicle', lang),
              onAction: () => context.push('/vehicle-register'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vehicles.length,
            itemBuilder: (context, i) =>
                _VehicleListTile(vehicle: vehicles[i], lang: lang),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: MockData.vehicles.length,
          itemBuilder: (context, i) =>
              _VehicleListTile(vehicle: MockData.vehicles[i], lang: lang),
        ),
      ),
    );
  }
}

class _VehicleListTile extends StatelessWidget {
  const _VehicleListTile({required this.vehicle, required this.lang});

  final Vehicle vehicle;
  final String lang;

  VhBadgeTone _insuranceTone() {
    return switch (vehicle.insurance) {
      InsuranceStatus.active => VhBadgeTone.success,
      InsuranceStatus.expiring => VhBadgeTone.warning,
      InsuranceStatus.expired => VhBadgeTone.danger,
    };
  }

  String _insuranceLabel() {
    return switch (vehicle.insurance) {
      InsuranceStatus.active => tr('active', lang),
      InsuranceStatus.expiring => tr('expiring', lang),
      InsuranceStatus.expired => tr('expired', lang),
    };
  }

  @override
  Widget build(BuildContext context) {
    return VhCard(
      margin: const EdgeInsets.only(bottom: 12),
      onTap: () => context.push('/garage/${vehicle.id}'),
      child: Row(
        children: [
          VehicleArt(
            kind: vehicleArtFromPhoto(vehicle.photo),
            size: 96,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${vehicle.make} ${vehicle.model}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text('${vehicle.year} · ${vehicle.reg}'),
                const SizedBox(height: 6),
                Row(
                  children: [
                    VhBadge(
                      label: _insuranceLabel(),
                      tone: _insuranceTone(),
                    ),
                    const SizedBox(width: 8),
                    VhBadge(
                      label: '${vehicle.health}%',
                      tone: VhBadgeTone.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
