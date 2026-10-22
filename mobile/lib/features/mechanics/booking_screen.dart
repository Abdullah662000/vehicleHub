import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';
import 'package:vehiclehub_pakistan/l10n/app_strings.dart';
import 'package:vehiclehub_pakistan/providers/providers.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_button.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_card.dart';
import 'package:vehiclehub_pakistan/shared/widgets/vh_text_field.dart';

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key, required this.mechanicId});

  final String mechanicId;

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _time = const TimeOfDay(hour: 10, minute: 0);
  final _problemCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _problemCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _confirm() async {
    setState(() => _loading = true);
    try {
      final date =
          '${_date.year.toString().padLeft(4, '0')}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')}';
      final time =
          '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
      await ref.read(bookingRemoteDataSourceProvider).createBooking(
            mechanicId: widget.mechanicId,
            date: date,
            time: time,
            problem: _problemCtrl.text.trim().isEmpty
                ? 'General service'
                : _problemCtrl.text.trim(),
          );
      if (mounted) context.push('/booking-success');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(tr('bookAppointment', lang))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VhCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('selectDate', lang),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today,
                      color: AppColors.primary),
                  title: Text(
                    '${_date.day}/${_date.month}/${_date.year}',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _pickDate,
                ),
                const Divider(),
                Text(
                  tr('selectTime', lang),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading:
                      const Icon(Icons.access_time, color: AppColors.primary),
                  title: Text(_time.format(context)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _pickTime,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          VhTextField(
            label: tr('problemDesc', lang),
            controller: _problemCtrl,
            maxLines: 4,
            prefixIcon: Icons.report_problem_outlined,
          ),
          const SizedBox(height: 16),
          VhCard(
            child: Row(
              children: [
                const Icon(Icons.upload_file, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(child: Text(tr('uploadImages', lang))),
                TextButton(onPressed: () {}, child: Text(tr('continue', lang))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          VhCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('estimatedCost', lang),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  'PKR 2,500 – 8,000',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  tr('paymentLater', lang),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          VhButton(
            label: tr('confirmBooking', lang),
            onPressed: _confirm,
            loading: _loading,
            fullWidth: true,
            size: VhButtonSize.lg,
          ),
        ],
      ),
    );
  }
}
