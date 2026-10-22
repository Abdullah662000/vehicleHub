import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/data/models/mechanic.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/mechanic_avatar.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_badge.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_chip.dart';

final mechanicDetailProvider =
    FutureProvider.autoDispose.family<Mechanic, String>((ref, id) {
  return ref.watch(mechanicRepositoryProvider).getMechanic(id);
});

class MechanicProfileScreen extends ConsumerWidget {
  const MechanicProfileScreen({super.key, required this.mechanicId});

  final String mechanicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final mechanicAsync = ref.watch(mechanicDetailProvider(mechanicId));

    return Scaffold(
      body: mechanicAsync.when(
        data: (m) => _ProfileBody(mechanic: m, lang: lang),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) {
          final m = MockData.mechanics.firstWhere(
            (x) => x.id == mechanicId,
            orElse: () => MockData.mechanics.first,
          );
          return _ProfileBody(mechanic: m, lang: lang);
        },
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.mechanic, required this.lang});

  final Mechanic mechanic;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(mechanic.workshop),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.7),
                  ],
                ),
              ),
              child: Center(
                child: MechanicAvatar(name: mechanic.name, size: 80),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        mechanic.name,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                    ),
                    if (mechanic.verified)
                      VhBadge(
                        label: tr('verified', lang),
                        tone: VhBadgeTone.primary,
                      ),
                  ],
                ),
                Text(mechanic.specialty),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.warning),
                    Text(
                      ' ${mechanic.rating} · ${mechanic.reviews} ${tr('reviews', lang)}',
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${mechanic.experience} ${tr('yearsExp', lang)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                VhCard(
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.location_on_outlined,
                        label: tr('location', lang),
                        value: mechanic.location,
                      ),
                      _InfoRow(
                        icon: Icons.access_time,
                        label: tr('workingHours', lang),
                        value: mechanic.hours,
                      ),
                      _InfoRow(
                        icon: Icons.payments_outlined,
                        label: tr('priceEstimate', lang),
                        value: mechanic.estimate,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  tr('gallery', lang),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, i) => Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColors.muted,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.image_outlined,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  tr('filters', lang),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...mechanic.brands.map(
                      (b) => VhChip(
                        label: b,
                        selected: true,
                        onSelected: (_) {},
                      ),
                    ),
                    ...mechanic.services.map(
                      (s) => VhChip(
                        label: s,
                        selected: false,
                        onSelected: (_) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: VhButton(
                        label: tr('call', lang),
                        variant: VhButtonVariant.outline,
                        icon: Icons.phone,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: VhButton(
                        label: tr('whatsapp', lang),
                        variant: VhButtonVariant.secondary,
                        icon: Icons.chat,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                VhButton(
                  label: tr('bookAppointment', lang),
                  onPressed: () =>
                      context.push('/mechanics/${mechanic.id}/book'),
                  fullWidth: true,
                  size: VhButtonSize.lg,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
