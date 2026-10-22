import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  static const _items = [
    (Icons.shield_outlined, 'insuranceReminder', 'Insurance expires in 12 days', '2h'),
    (Icons.build_outlined, 'upcomingService', 'Oil change due at 50,000 km', '1d'),
    (Icons.local_gas_station, 'fuelExpenses', 'Fuel expense logged: PKR 8,960', '2d'),
    (Icons.check_circle_outline, 'bookingSuccess', 'Booking confirmed at Ali Auto Care', '3d'),
    (Icons.description_outlined, 'registrationReminder', 'Registration renewal in 45 days', '5d'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(tr('notifications', lang))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        itemBuilder: (context, i) {
          final item = _items[i];
          return VhCard(
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.$1, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr(item.$2, lang),
                        style:
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.$3,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  item.$4,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
