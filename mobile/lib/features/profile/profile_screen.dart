import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/mechanic_avatar.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final auth = ref.watch(authStateProvider);
    final name = auth.user?.fullName ?? 'Vehicle Owner';

    return Scaffold(
      appBar: AppBar(title: Text(tr('profile', lang))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VhCard(
            child: Row(
              children: [
                MechanicAvatar(name: name, size: 56),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                      Text(
                        auth.user?.email ?? 'owner@vehiclehub.pk',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => context.push('/settings'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SettingsGroup(
            lang: lang,
            items: [
              _SettingsItem(
                icon: Icons.person_outline,
                label: tr('personalInfo', lang),
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.directions_car_outlined,
                label: tr('myVehicles', lang),
                onTap: () => context.go('/garage'),
              ),
              _SettingsItem(
                icon: Icons.build_outlined,
                label: tr('savedMechanics', lang),
                onTap: () => context.go('/mechanics'),
              ),
              _SettingsItem(
                icon: Icons.payment_outlined,
                label: tr('paymentMethods', lang),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          _SettingsGroup(
            lang: lang,
            items: [
              _SettingsItem(
                icon: Icons.language,
                label: tr('language', lang),
                onTap: () => context.push('/settings'),
              ),
              _SettingsItem(
                icon: Icons.dark_mode_outlined,
                label: tr('darkMode', lang),
                onTap: () => context.push('/settings'),
              ),
              _SettingsItem(
                icon: Icons.notifications_outlined,
                label: tr('notifications', lang),
                onTap: () => context.push('/notifications'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _SettingsGroup(
            lang: lang,
            items: [
              _SettingsItem(
                icon: Icons.palette_outlined,
                label: tr('designSystem', lang),
                onTap: () => context.push('/design-system'),
              ),
              _SettingsItem(
                icon: Icons.inbox_outlined,
                label: tr('noExpenses', lang),
                onTap: () => context.push('/empty-states'),
              ),
              _SettingsItem(
                icon: Icons.error_outline,
                label: tr('networkError', lang),
                onTap: () => context.push('/error-states'),
              ),
              _SettingsItem(
                icon: Icons.help_outline,
                label: tr('help', lang),
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.privacy_tip_outlined,
                label: tr('privacy', lang),
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.description_outlined,
                label: tr('terms', lang),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          _SettingsGroup(
            lang: lang,
            items: [
              _SettingsItem(
                icon: Icons.logout,
                label: tr('logout', lang),
                color: AppColors.danger,
                onTap: () async {
                  await ref.read(authStateProvider.notifier).logout();
                  if (context.mounted) context.go('/login');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.lang, required this.items});

  final String lang;
  final List<_SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: items.map((item) {
          return ListTile(
            leading: Icon(item.icon, color: item.color ?? AppColors.primary),
            title: Text(
              item.label,
              style: TextStyle(color: item.color),
            ),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: item.onTap,
          );
        }).toList(),
      ),
    );
  }
}

class _SettingsItem {
  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
}
