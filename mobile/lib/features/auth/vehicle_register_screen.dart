import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_chip.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_text_field.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vehicle_art.dart';

class VehicleRegisterScreen extends ConsumerStatefulWidget {
  const VehicleRegisterScreen({super.key});

  @override
  ConsumerState<VehicleRegisterScreen> createState() =>
      _VehicleRegisterScreenState();
}

class _VehicleRegisterScreenState extends ConsumerState<VehicleRegisterScreen> {
  String _make = 'Toyota';
  String _model = 'Corolla';
  final _yearCtrl = TextEditingController(text: '2021');
  final _regCtrl = TextEditingController(text: 'LES-2041');
  final _mileageCtrl = TextEditingController(text: '45000');
  bool _loading = false;

  static const _makes = ['Toyota', 'Honda', 'Kia', 'Suzuki'];
  static const _models = {
    'Toyota': ['Corolla', 'Hilux', 'Yaris'],
    'Honda': ['Civic', 'City'],
    'Kia': ['Sportage', 'Stonic'],
    'Suzuki': ['Alto', 'Cultus'],
  };

  @override
  void dispose() {
    _yearCtrl.dispose();
    _regCtrl.dispose();
    _mileageCtrl.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    setState(() => _loading = true);
    await ref.read(vehicleRepositoryProvider).createVehicle(
          make: _make,
          model: _model,
          year: int.tryParse(_yearCtrl.text) ?? 2021,
          reg: _regCtrl.text,
          fuelType: 'Petrol',
          transmission: 'Automatic',
          mileage: int.tryParse(_mileageCtrl.text) ?? 0,
        );
    await ref.read(appPreferencesProvider).setLoggedIn(true);
    ref.invalidate(vehiclesProvider);
    if (mounted) {
      setState(() => _loading = false);
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final models = _models[_make] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(tr('registerVehicle', lang))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: VehicleArt(
                kind: vehicleArtFromModel(_model),
                size: 160,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              tr('registerVehicle', lang),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              tr('registerVehicleDesc', lang),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 24),
            Text(
              tr('make', lang),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _makes.map((m) {
                return VhChip(
                  label: m,
                  selected: _make == m,
                  onSelected: (_) => setState(() {
                    _make = m;
                    _model = _models[m]!.first;
                  }),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              tr('model', lang),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: models.map((m) {
                return VhChip(
                  label: m,
                  selected: _model == m,
                  onSelected: (_) => setState(() => _model = m),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            VhTextField(
              label: tr('year', lang),
              controller: _yearCtrl,
              prefixIcon: Icons.calendar_today_outlined,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            VhTextField(
              label: tr('registrationNo', lang),
              controller: _regCtrl,
              prefixIcon: Icons.confirmation_number_outlined,
            ),
            const SizedBox(height: 16),
            VhTextField(
              label: tr('mileage', lang),
              controller: _mileageCtrl,
              prefixIcon: Icons.speed_outlined,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            VhButton(
              label: tr('finishSetup', lang),
              onPressed: _finish,
              loading: _loading,
              fullWidth: true,
              size: VhButtonSize.lg,
            ),
          ],
        ),
      ),
    );
  }
}
