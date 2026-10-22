import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/mechanic_avatar.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_badge.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';

class EmergencyScreen extends ConsumerWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final emergencyMechanics = MockData.mechanics
        .where((m) => m.services.contains('Emergency'))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(tr('emergency', lang))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VhCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.danger,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.sos, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 16),
                Text(
                  tr('roadside', lang),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                VhBadge(
                  label: tr('liveLocation', lang),
                  tone: VhBadgeTone.danger,
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 20),
                VhButton(
                  label: tr('callDirectly', lang),
                  variant: VhButtonVariant.danger,
                  icon: Icons.phone,
                  onPressed: () {},
                  fullWidth: true,
                  size: VhButtonSize.lg,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            tr('quickActions', lang),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              _EmergencyTile(
                icon: Icons.local_shipping_outlined,
                label: tr('towTruck', lang),
              ),
              _EmergencyTile(
                icon: Icons.battery_charging_full,
                label: tr('jumpStart', lang),
              ),
              _EmergencyTile(
                icon: Icons.tire_repair_outlined,
                label: tr('flatTyre', lang),
              ),
              _EmergencyTile(
                icon: Icons.car_crash_outlined,
                label: tr('engineFailure', lang),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            tr('nearbyMechanics', lang),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          ...emergencyMechanics.map(
            (m) => VhCard(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  MechanicAvatar(name: m.name),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.name,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(m.workshop),
                        Text(
                          '${m.distance} ${tr('kmAway', lang)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  VhButton(
                    label: tr('call', lang),
                    size: VhButtonSize.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmergencyTile extends StatelessWidget {
  const _EmergencyTile({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: AppColors.danger),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
