import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(tr('settings', lang))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VhCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('language', lang),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 12),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'en', label: Text('English')),
                    ButtonSegment(value: 'ur', label: Text('اردو')),
                  ],
                  selected: {lang},
                  onSelectionChanged: (s) {
                    ref.read(localeProvider.notifier).setLocale(s.first);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          VhCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('theme', lang),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 12),
                ...ThemeMode.values.map((mode) {
                  final label = switch (mode) {
                    ThemeMode.light => tr('light', lang),
                    ThemeMode.dark => tr('dark', lang),
                    ThemeMode.system => tr('system', lang),
                  };
                  return RadioListTile<ThemeMode>(
                    value: mode,
                    groupValue: themeMode,
                    title: Text(label),
                    activeColor: AppColors.primary,
                    onChanged: (v) {
                      if (v != null) {
                        ref.read(themeModeProvider.notifier).setThemeMode(v);
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
