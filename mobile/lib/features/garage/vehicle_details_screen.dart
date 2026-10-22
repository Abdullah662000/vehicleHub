import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/data/models/service_record.dart';
import 'package:vehiclehub_pakistan/data/models/vehicle.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/section_header.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_badge.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vehicle_art.dart';

final vehicleDetailProvider =
    FutureProvider.autoDispose.family<Vehicle, String>((ref, id) {
  return ref.watch(vehicleRepositoryProvider).getVehicle(id);
});

final serviceTimelineProvider =
    FutureProvider.autoDispose.family<List<ServiceRecord>, String>((ref, id) {
  return ref.watch(vehicleRepositoryProvider).getServiceTimeline(id);
});

class VehicleDetailsScreen extends ConsumerWidget {
  const VehicleDetailsScreen({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final vehicleAsync = ref.watch(vehicleDetailProvider(vehicleId));
    final timelineAsync = ref.watch(serviceTimelineProvider(vehicleId));

    return Scaffold(
      appBar: AppBar(title: Text(tr('vehicleDetails', lang))),
      body: vehicleAsync.when(
        data: (vehicle) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            VhCard(
              child: Column(
                children: [
                  VehicleArt(
                    kind: vehicleArtFromPhoto(vehicle.photo),
                    size: 180,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${vehicle.make} ${vehicle.model}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Text('${vehicle.year} · ${vehicle.reg}'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _DetailStat(
                        label: tr('mileage', lang),
                        value: '${vehicle.mileage} km',
                      ),
                      _DetailStat(
                        label: tr('fuelType', lang),
                        value: vehicle.fuelType,
                      ),
                      _DetailStat(
                        label: tr('healthScore', lang),
                        value: '${vehicle.health}%',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _InfoRow(
              label: tr('transmission', lang),
              value: vehicle.transmission,
            ),
            _InfoRow(
              label: tr('insuranceStatus', lang),
              value: vehicle.insurance.name,
            ),
            const SizedBox(height: 20),
            SectionHeader(
              title: tr('timeline', lang),
              actionLabel: tr('seeAll', lang),
              onAction: () =>
                  context.push('/garage/$vehicleId/history'),
            ),
            const SizedBox(height: 8),
            timelineAsync.when(
              data: (records) => Column(
                children: records
                    .take(3)
                    .map((r) => _TimelineTile(record: r, lang: lang))
                    .toList(),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => Column(
                children: MockData.serviceTimeline
                    .take(3)
                    .map((r) => _TimelineTile(record: r, lang: lang))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            VhButton(
              label: tr('serviceHistory', lang),
              onPressed: () => context.push('/garage/$vehicleId/history'),
              fullWidth: true,
            ),
            const SizedBox(height: 12),
            VhButton(
              label: tr('bookService', lang),
              variant: VhButtonVariant.outline,
              onPressed: () => context.go('/mechanics'),
              fullWidth: true,
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text(tr('networkError', lang))),
      ),
    );
  }
}

class _DetailStat extends StatelessWidget {
  const _DetailStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({required this.record, required this.lang});

  final ServiceRecord record;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text('${record.workshop} · ${record.date}'),
                const SizedBox(height: 4),
                Text(
                  '${tr('pkr', lang)} ${record.cost}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          VhBadge(label: record.warranty, tone: VhBadgeTone.neutral),
        ],
      ),
    );
  }
}
