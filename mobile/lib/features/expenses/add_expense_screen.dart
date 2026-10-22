import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_chip.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_text_field.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String _category = 'Fuel';
  bool _loading = false;

  static const _categories = [
    'Fuel',
    'Service',
    'Repairs',
    'Insurance',
    'Parking',
    'Toll Tax',
    'Car Wash',
    'Accessories',
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _loading = true);
    await ref.read(expenseRepositoryProvider).createExpense(
          category: _category,
          title: _titleCtrl.text,
          amount: int.tryParse(_amountCtrl.text) ?? 0,
          date: 'Today',
          icon: 'fuel',
        );
    ref.invalidate(expensesProvider);
    if (mounted) {
      setState(() => _loading = false);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(tr('addExpense', lang))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VhTextField(
            label: tr('notes', lang),
            controller: _titleCtrl,
            prefixIcon: Icons.receipt_outlined,
          ),
          const SizedBox(height: 16),
          VhTextField(
            label: tr('pkr', lang),
            controller: _amountCtrl,
            prefixIcon: Icons.attach_money,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          Text(
            tr('analytics', lang),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((c) {
              return VhChip(
                label: c,
                selected: _category == c,
                onSelected: (_) => setState(() => _category = c),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          VhButton(
            label: tr('save', lang),
            onPressed: _save,
            loading: _loading,
            fullWidth: true,
            size: VhButtonSize.lg,
          ),
        ],
      ),
    );
  }
}
