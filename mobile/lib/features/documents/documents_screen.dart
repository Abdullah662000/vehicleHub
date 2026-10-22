import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_badge.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  static const _docs = [
    ('registration', Icons.confirmation_number_outlined, '45 days'),
    ('insurance', Icons.shield_outlined, '12 days'),
    ('taxToken', Icons.receipt_long_outlined, '90 days'),
    ('drivingLicense', Icons.badge_outlined, '365 days'),
    ('invoices', Icons.description_outlined, null),
    ('warrantyCards', Icons.card_membership_outlined, null),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(tr('vehicleDocuments', lang))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.upload_file),
        label: Text(tr('uploadPdf', lang)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _docs.length,
        itemBuilder: (context, i) {
          final doc = _docs[i];
          return VhCard(
            margin: const EdgeInsets.only(bottom: 12),
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(doc.$2, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr(doc.$1, lang),
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      if (doc.$3 != null)
                        Text(
                          '${tr('expiryReminder', lang)}: ${doc.$3}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
                if (doc.$3 != null && doc.$3!.contains('12'))
                  VhBadge(
                    label: tr('expiring', lang),
                    tone: VhBadgeTone.warning,
                  )
                else if (doc.$3 != null)
                  VhBadge(label: tr('active', lang), tone: VhBadgeTone.success),
                const Icon(Icons.chevron_right),
              ],
            ),
          );
        },
      ),
    );
  }
}
