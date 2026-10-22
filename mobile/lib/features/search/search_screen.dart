import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_text_field.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _ctrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final q = _query.toLowerCase();

    final mechanics = MockData.mechanics.where((m) {
      if (q.isEmpty) return true;
      return m.name.toLowerCase().contains(q) ||
          m.workshop.toLowerCase().contains(q);
    }).toList();

    final vehicles = MockData.vehicles.where((v) {
      if (q.isEmpty) return true;
      return v.make.toLowerCase().contains(q) ||
          v.model.toLowerCase().contains(q) ||
          v.reg.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(tr('search', lang))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: VhTextField(
              hint: tr('search', lang),
              controller: _ctrl,
              prefixIcon: Icons.search,
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                if (vehicles.isNotEmpty) ...[
                  Text(
                    tr('myGarage', lang),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ...vehicles.map(
                    (v) => ListTile(
                      leading: const Icon(Icons.directions_car,
                          color: AppColors.primary),
                      title: Text('${v.make} ${v.model}'),
                      subtitle: Text(v.reg),
                      onTap: () => context.push('/garage/${v.id}'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  tr('mechanics', lang),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                ...mechanics.map(
                  (m) => ListTile(
                    leading:
                        const Icon(Icons.build, color: AppColors.secondary),
                    title: Text(m.name),
                    subtitle: Text(m.workshop),
                    onTap: () => context.push('/mechanics/${m.id}'),
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
