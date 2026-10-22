import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_text_field.dart';

class FuelScreen extends ConsumerStatefulWidget {
  const FuelScreen({super.key});

  @override
  ConsumerState<FuelScreen> createState() => _FuelScreenState();
}

class _FuelScreenState extends ConsumerState<FuelScreen> {
  final _quantityCtrl = TextEditingController(text: '32');
  final _costCtrl = TextEditingController(text: '8960');
  final _mileageCtrl = TextEditingController(text: '48250');

  @override
  void dispose() {
    _quantityCtrl.dispose();
    _costCtrl.dispose();
    _mileageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final qty = double.tryParse(_quantityCtrl.text) ?? 0;
    final cost = double.tryParse(_costCtrl.text) ?? 0;
    final perLiter = qty > 0 ? (cost / qty).toStringAsFixed(1) : '—';

    return Scaffold(
      appBar: AppBar(title: Text(tr('fuelTracker', lang))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VhCard(
            child: Row(
              children: [
                const Icon(Icons.local_gas_station,
                    size: 40, color: AppColors.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('fuelEconomy', lang),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '12.4 km/L',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          VhTextField(
            label: tr('fuelQuantity', lang),
            controller: _quantityCtrl,
            prefixIcon: Icons.water_drop_outlined,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          VhTextField(
            label: tr('fuelCost', lang),
            controller: _costCtrl,
            prefixIcon: Icons.payments_outlined,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          VhTextField(
            label: tr('mileage', lang),
            controller: _mileageCtrl,
            prefixIcon: Icons.speed_outlined,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          VhCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tr('fuelCost', lang)),
                Text(
                  'PKR $perLiter / L',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          VhButton(
            label: tr('addFuel', lang),
            onPressed: () => context.pop(),
            fullWidth: true,
            size: VhButtonSize.lg,
          ),
        ],
      ),
    );
  }
}
