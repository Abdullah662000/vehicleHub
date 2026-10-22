import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/data/models/api_response.dart';
import 'package:vehiclehub_pakistan/data/models/expense.dart';
import 'package:vehiclehub_pakistan/features/home/home_screen.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/section_header.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final expensesAsync = ref.watch(expensesProvider);
    final categoryAsync = ref.watch(categorySpendProvider);

    return Scaffold(
      appBar: AppBar(title: Text(tr('expenseTracker', lang))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/expenses/add'),
        icon: const Icon(Icons.add),
        label: Text(tr('addExpense', lang)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: _KpiCard(
                  label: tr('thisMonth', lang),
                  value: 'PKR 28,600',
                  icon: Icons.calendar_month,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _KpiCard(
                  label: tr('thisYear', lang),
                  value: 'PKR 172,400',
                  icon: Icons.trending_up,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _KpiCard(
            label: tr('costPerKm', lang),
            value: 'PKR 5.2',
            icon: Icons.speed,
            fullWidth: true,
          ),
          const SizedBox(height: 20),
          SectionHeader(title: tr('analytics', lang)),
          const SizedBox(height: 8),
          categoryAsync.when(
            data: (cats) => _CategoryChart(categories: cats),
            loading: () => const SizedBox(
              height: 180,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) =>
                _CategoryChart(categories: MockData.categorySpend),
          ),
          const SizedBox(height: 20),
          SectionHeader(title: tr('recentExpenses', lang)),
          const SizedBox(height: 8),
          expensesAsync.when(
            data: (expenses) => Column(
              children: expenses
                  .map((e) => _ExpenseRow(expense: e, lang: lang))
                  .toList(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => Column(
              children: MockData.expenses
                  .map((e) => _ExpenseRow(expense: e, lang: lang))
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          VhButton(
            label: tr('fuelTracker', lang),
            variant: VhButtonVariant.soft,
            icon: Icons.local_gas_station,
            onPressed: () => context.push('/expenses/fuel'),
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.label,
    required this.value,
    required this.icon,
    this.fullWidth = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
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

class _CategoryChart extends StatelessWidget {
  const _CategoryChart({required this.categories});

  final List<CategorySpend> categories;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CustomPaint(
              painter: _PiePainter(categories: categories),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: categories.map((c) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: colorFromHex(c.color),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(c.label)),
                      Text('${c.value}%'),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PiePainter extends CustomPainter {
  _PiePainter({required this.categories});

  final List<CategorySpend> categories;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    var startAngle = -math.pi / 2;

    for (final cat in categories) {
      final sweep = (cat.value / 100) * 2 * math.pi;
      final paint = Paint()
        ..color = colorFromHex(cat.color)
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweep,
        true,
        paint,
      );
      startAngle += sweep;
    }

    canvas.drawCircle(
      center,
      radius * 0.5,
      Paint()..color = ThemeData.light().scaffoldBackgroundColor,
    );
  }

  @override
  bool shouldRepaint(covariant _PiePainter oldDelegate) =>
      oldDelegate.categories != categories;
}

class _ExpenseRow extends StatelessWidget {
  const _ExpenseRow({required this.expense, required this.lang});

  final Expense expense;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(expenseIcon(expense.icon), color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text('${expense.category} · ${expense.date}'),
              ],
            ),
          ),
          Text(
            '${tr('pkr', lang)} ${expense.amount}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
