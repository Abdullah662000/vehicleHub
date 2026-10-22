import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/data/models/service_record.dart';
import 'package:vehiclehub_pakistan/features/garage/vehicle_details_screen.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_badge.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_empty_state.dart';

class ServiceHistoryScreen extends ConsumerWidget {
  const ServiceHistoryScreen({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final timelineAsync = ref.watch(serviceTimelineProvider(vehicleId));

    return Scaffold(
      appBar: AppBar(title: Text(tr('serviceHistory', lang))),
      body: timelineAsync.when(
        data: (records) {
          if (records.isEmpty) {
            return VhEmptyState(
              icon: Icons.history,
              title: tr('noServiceHistory', lang),
              description: tr('bookService', lang),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: records.length,
            itemBuilder: (context, i) =>
                _ServiceRecordCard(record: records[i], lang: lang),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: MockData.serviceTimeline.length,
          itemBuilder: (context, i) => _ServiceRecordCard(
            record: MockData.serviceTimeline[i],
            lang: lang,
          ),
        ),
      ),
    );
  }
}

class _ServiceRecordCard extends StatelessWidget {
  const _ServiceRecordCard({required this.record, required this.lang});

  final ServiceRecord record;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  record.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    Icons.star,
                    size: 14,
                    color: i < record.rating
                        ? AppColors.warning
                        : AppColors.border,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('${record.workshop} · ${record.mechanic}'),
          Text(record.date, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: record.parts
                .map((p) => VhBadge(label: p, tone: VhBadgeTone.neutral))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tr('pkr', lang)} ${record.cost}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
              ),
              VhBadge(
                label: '${tr('warranty', lang)}: ${record.warranty}',
                tone: VhBadgeTone.success,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
