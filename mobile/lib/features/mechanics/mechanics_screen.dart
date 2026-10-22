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
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_chip.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_text_field.dart';

class MechanicsScreen extends ConsumerStatefulWidget {
  const MechanicsScreen({super.key});

  @override
  ConsumerState<MechanicsScreen> createState() => _MechanicsScreenState();
}

class _MechanicsScreenState extends ConsumerState<MechanicsScreen> {
  final _searchCtrl = TextEditingController();
  bool _verifiedOnly = false;
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Mechanic> _filter(List<Mechanic> list) {
    return list.where((m) {
      if (_verifiedOnly && !m.verified) return false;
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return m.name.toLowerCase().contains(q) ||
          m.workshop.toLowerCase().contains(q) ||
          m.specialty.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final mechanicsAsync = ref.watch(mechanicsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(tr('findMechanics', lang))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: VhTextField(
              hint: tr('search', lang),
              controller: _searchCtrl,
              prefixIcon: Icons.search,
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                VhChip(
                  label: tr('verifiedOnly', lang),
                  selected: _verifiedOnly,
                  onSelected: (v) => setState(() => _verifiedOnly = v),
                  icon: Icons.verified_outlined,
                ),
                const SizedBox(width: 8),
                VhChip(
                  label: tr('distance', lang),
                  selected: false,
                  onSelected: (_) {},
                ),
                const SizedBox(width: 8),
                VhChip(
                  label: tr('ratings', lang),
                  selected: false,
                  onSelected: (_) {},
                ),
              ],
            ),
          ),
          Expanded(
            child: mechanicsAsync.when(
              data: (mechanics) {
                final filtered = _filter(mechanics);
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, i) =>
                      _MechanicCard(mechanic: filtered[i], lang: lang),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) {
                final filtered = _filter(MockData.mechanics);
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, i) =>
                      _MechanicCard(mechanic: filtered[i], lang: lang),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MechanicCard extends StatelessWidget {
  const _MechanicCard({required this.mechanic, required this.lang});

  final Mechanic mechanic;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      margin: const EdgeInsets.only(bottom: 12),
      onTap: () => context.push('/mechanics/${mechanic.id}'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MechanicAvatar(name: mechanic.name, size: 52),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        mechanic.name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    if (mechanic.verified)
                      VhBadge(
                        label: tr('verified', lang),
                        tone: VhBadgeTone.primary,
                        icon: Icons.verified,
                      ),
                  ],
                ),
                Text(mechanic.workshop),
                Text(
                  mechanic.location,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: AppColors.warning),
                    Text(' ${mechanic.rating} (${mechanic.reviews})'),
                    const Spacer(),
                    Text(
                      '${mechanic.distance} ${tr('kmAway', lang)}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: mechanic.services
                      .take(3)
                      .map((s) => VhBadge(label: s, tone: VhBadgeTone.neutral))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
