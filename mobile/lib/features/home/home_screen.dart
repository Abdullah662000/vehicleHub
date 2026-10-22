import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/data/mock/mock_data.dart';
import 'package:vehiclehub_pakistan/data/models/api_response.dart';
import 'package:vehiclehub_pakistan/data/models/expense.dart';
import 'package:vehiclehub_pakistan/data/models/mechanic.dart';
import 'package:vehiclehub_pakistan/data/models/vehicle.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/mechanic_avatar.dart';
import 'package:vehiclehub_pakistan/shared/widgets/section_header.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_badge.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vehicle_art.dart';

Color colorFromHex(String hex) {
  final h = hex.replaceFirst('#', '');
  return Color(int.parse('FF$h', radix: 16));
}

String greetingKey() {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'goodMorning';
  if (hour < 17) return 'goodAfternoon';
  return 'goodEvening';
}

IconData expenseIcon(String icon) {
  return switch (icon) {
    'fuel' => Icons.local_gas_station_outlined,
    'wrench' => Icons.build_outlined,
    'road' => Icons.route_outlined,
    'droplets' => Icons.water_drop_outlined,
    'parking' => Icons.local_parking_outlined,
    _ => Icons.receipt_outlined,
  };
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(vehiclesProvider);
    ref.invalidate(mechanicsProvider);
    ref.invalidate(expensesProvider);
    ref.invalidate(monthlySpendProvider);
    await ref.read(vehiclesProvider.future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);
    final vehiclesAsync = ref.watch(vehiclesProvider);
    final mechanicsAsync = ref.watch(mechanicsProvider);
    final expensesAsync = ref.watch(expensesProvider);
    final monthlyAsync = ref.watch(monthlySpendProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('dashboard', lang)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              tr(greetingKey(), lang),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              tr('tagline', lang),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 20),
            vehiclesAsync.when(
              data: (vehicles) => _VehicleHeroCard(
                vehicle: vehicles.isNotEmpty ? vehicles.first : MockData.vehicles.first,
                lang: lang,
                onTap: () => context.push(
                  '/garage/${vehicles.isNotEmpty ? vehicles.first.id : 'v1'}',
                ),
              ),
              loading: () => const _LoadingCard(height: 180),
              error: (_, __) => _VehicleHeroCard(
                vehicle: MockData.vehicles.first,
                lang: lang,
                onTap: () => context.push('/garage/v1'),
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(title: tr('upcomingService', lang)),
            const SizedBox(height: 8),
            _ReminderRow(lang: lang),
            const SizedBox(height: 20),
            SectionHeader(title: tr('quickActions', lang)),
            const SizedBox(height: 8),
            _QuickActionsGrid(lang: lang),
            const SizedBox(height: 20),
            SectionHeader(
              title: tr('nearbyMechanics', lang),
              actionLabel: tr('seeAll', lang),
              onAction: () => context.go('/mechanics'),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 140,
              child: mechanicsAsync.when(
                data: (mechanics) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mechanics.length,
                  itemBuilder: (context, i) =>
                      _MechanicTile(mechanic: mechanics[i], lang: lang),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: MockData.mechanics.length,
                  itemBuilder: (context, i) => _MechanicTile(
                    mechanic: MockData.mechanics[i],
                    lang: lang,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(title: tr('monthlySpending', lang)),
            const SizedBox(height: 8),
            monthlyAsync.when(
              data: (points) => _MonthlyBarChart(points: points),
              loading: () => const _LoadingCard(height: 160),
              error: (_, __) =>
                  _MonthlyBarChart(points: MockData.monthlySpend),
            ),
            const SizedBox(height: 20),
            SectionHeader(
              title: tr('recentExpenses', lang),
              actionLabel: tr('seeAll', lang),
              onAction: () => context.go('/expenses'),
            ),
            const SizedBox(height: 8),
            expensesAsync.when(
              data: (expenses) => Column(
                children: expenses
                    .take(3)
                    .map((e) => _ExpenseTile(expense: e, lang: lang))
                    .toList(),
              ),
              loading: () => const _LoadingCard(height: 80),
              error: (_, __) => Column(
                children: MockData.expenses
                    .take(3)
                    .map((e) => _ExpenseTile(expense: e, lang: lang))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            _TipCard(lang: lang),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _VehicleHeroCard extends StatelessWidget {
  const _VehicleHeroCard({
    required this.vehicle,
    required this.lang,
    required this.onTap,
  });

  final Vehicle vehicle;
  final String lang;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vehicle.make} ${vehicle.model}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    Text(
                      vehicle.reg,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              VhBadge(
                label: '${vehicle.health}% ${tr('healthScore', lang)}',
                tone: VhBadgeTone.success,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: VehicleArt(
              kind: vehicleArtFromPhoto(vehicle.photo),
              size: 160,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _StatChip(
                icon: Icons.speed,
                label:
                    '${vehicle.mileage.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} km',
              ),
              const SizedBox(width: 12),
              _StatChip(icon: Icons.local_gas_station, label: vehicle.fuelType),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

class _ReminderRow extends StatelessWidget {
  const _ReminderRow({required this.lang});

  final String lang;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: VhCard(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.shield_outlined, color: AppColors.warning),
                const SizedBox(height: 8),
                Text(
                  tr('insuranceReminder', lang),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text('${tr('expiresIn', lang)} 12 ${tr('days', lang)}'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: VhCard(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.description_outlined, color: AppColors.primary),
                const SizedBox(height: 8),
                Text(
                  tr('registrationReminder', lang),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text('${tr('expiresIn', lang)} 45 ${tr('days', lang)}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid({required this.lang});

  final String lang;

  @override
  Widget build(BuildContext context) {
    final actions = [
      (Icons.build_circle_outlined, tr('bookMechanic', lang), '/mechanics'),
      (Icons.search, tr('findWorkshop', lang), '/mechanics'),
      (Icons.receipt_long, tr('trackExpense', lang), '/expenses/add'),
      (Icons.folder_outlined, tr('documents', lang), '/documents'),
      (Icons.local_gas_station, tr('fuel', lang), '/expenses/fuel'),
      (Icons.emergency_outlined, tr('emergency', lang), '/emergency'),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: actions.map((a) {
        return VhCard(
          onTap: () => context.push(a.$3),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(a.$1, color: AppColors.primary, size: 28),
              const SizedBox(height: 8),
              Text(
                a.$2,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _MechanicTile extends StatelessWidget {
  const _MechanicTile({required this.mechanic, required this.lang});

  final Mechanic mechanic;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MechanicAvatar(name: mechanic.name, size: 36),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    mechanic.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              mechanic.workshop,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: AppColors.warning),
                Text(' ${mechanic.rating}'),
                const Spacer(),
                Text(
                  '${mechanic.distance} ${tr('kmAway', lang)}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthlyBarChart extends StatelessWidget {
  const _MonthlyBarChart({required this.points});

  final List<ChartPoint> points;

  @override
  Widget build(BuildContext context) {
    final maxVal = points.map((p) => p.value).reduce((a, b) => a > b ? a : b);

    return VhCard(
      child: SizedBox(
        height: 140,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: points.map((p) {
            final ratio = p.value / maxVal;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: ratio.toDouble(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      p.label,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  const _ExpenseTile({required this.expense, required this.lang});

  final Expense expense;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(expenseIcon(expense.icon), color: AppColors.primary),
          ),
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
                Text(expense.date, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Text(
            '${tr('pkr', lang)} ${expense.amount}',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.lang});

  final String lang;

  @override
  Widget build(BuildContext context) {
    final tip = MockData.tips.first;
    return VhCard(
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: AppColors.accent, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('todaysTips', lang),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                ),
                const SizedBox(height: 4),
                Text(tip[lang] ?? tip['en']!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return VhCard(
      child: SizedBox(
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
