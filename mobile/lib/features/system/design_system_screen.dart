import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_badge.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_chip.dart';

class DesignSystemScreen extends ConsumerWidget {
  const DesignSystemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(tr('designSystem', lang))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            tr('components', lang),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 16),
          Text('Buttons', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          VhButton(label: 'Primary', onPressed: () {}),
          const SizedBox(height: 8),
          VhButton(
            label: 'Secondary',
            variant: VhButtonVariant.secondary,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          VhButton(
            label: 'Accent',
            variant: VhButtonVariant.accent,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          VhButton(
            label: 'Outline',
            variant: VhButtonVariant.outline,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          VhButton(
            label: 'Soft',
            variant: VhButtonVariant.soft,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          VhButton(
            label: 'Danger',
            variant: VhButtonVariant.danger,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          VhButton(
            label: 'Ghost',
            variant: VhButtonVariant.ghost,
            onPressed: () {},
          ),
          const SizedBox(height: 24),
          Text('Badges', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              VhBadge(label: 'Primary', tone: VhBadgeTone.primary),
              VhBadge(label: 'Success', tone: VhBadgeTone.success),
              VhBadge(label: 'Warning', tone: VhBadgeTone.warning),
              VhBadge(label: 'Danger', tone: VhBadgeTone.danger),
              VhBadge(label: 'Neutral', tone: VhBadgeTone.neutral),
              VhBadge(label: 'Accent', tone: VhBadgeTone.accent),
            ],
          ),
          const SizedBox(height: 24),
          Text('Chips', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              VhChip(label: 'Selected', selected: true, onSelected: (_) {}),
              VhChip(label: 'Default', selected: false, onSelected: (_) {}),
            ],
          ),
          const SizedBox(height: 24),
          Text('Colors', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ColorSwatch('Primary', AppColors.primary),
              _ColorSwatch('Secondary', AppColors.secondary),
              _ColorSwatch('Accent', AppColors.accent),
              _ColorSwatch('Danger', AppColors.danger),
              _ColorSwatch('Warning', AppColors.warning),
              _ColorSwatch('Success', AppColors.success),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch(this.name, this.color);

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
