import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';

class ErrorStatesScreen extends ConsumerWidget {
  const ErrorStatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(tr('networkError', lang))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ErrorCard(
            icon: Icons.wifi_off,
            title: tr('networkError', lang),
            description: tr('networkErrorDesc', lang),
            lang: lang,
          ),
          const SizedBox(height: 12),
          _ErrorCard(
            icon: Icons.location_off,
            title: tr('locationDisabled', lang),
            description: tr('locationDisabledDesc', lang),
            lang: lang,
          ),
          const SizedBox(height: 12),
          _ErrorCard(
            icon: Icons.build_circle_outlined,
            title: tr('noMechanicsNearby', lang),
            description: tr('findMechanics', lang),
            lang: lang,
          ),
          const SizedBox(height: 12),
          _ErrorCard(
            icon: Icons.sms_failed_outlined,
            title: tr('otpFailed', lang),
            description: tr('resendCode', lang),
            lang: lang,
          ),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.lang,
  });

  final IconData icon;
  final String title;
  final String description;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      child: Column(
        children: [
          Icon(icon, size: 48, color: AppColors.danger),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          VhButton(
            label: tr('continue', lang),
            variant: VhButtonVariant.outline,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
