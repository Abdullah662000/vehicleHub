import 'package:flutter/material.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';

class VhChip extends StatelessWidget {
  const VhChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      avatar: icon != null ? Icon(icon, size: 16) : null,
      showCheckmark: false,
      selectedColor: AppColors.primary.withValues(alpha: 0.15),
      backgroundColor: isDark ? AppColors.mutedDark : AppColors.muted,
      labelStyle: TextStyle(
        color: selected
            ? (isDark ? AppColors.primaryDark : AppColors.primary)
            : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected
              ? (isDark ? AppColors.primaryDark : AppColors.primary)
              : (isDark ? AppColors.borderDark : AppColors.border),
        ),
      ),
    );
  }
}
