import 'package:flutter/material.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';

enum VhBadgeTone {
  primary,
  success,
  warning,
  danger,
  neutral,
  accent,
}

class VhBadge extends StatelessWidget {
  const VhBadge({
    super.key,
    required this.label,
    this.tone = VhBadgeTone.primary,
    this.icon,
  });

  final String label;
  final VhBadgeTone tone;
  final IconData? icon;

  ({Color bg, Color fg}) _colors(bool isDark) {
    return switch (tone) {
      VhBadgeTone.primary => (
          bg: AppColors.primary.withValues(alpha: 0.12),
          fg: isDark ? AppColors.primaryDark : AppColors.primary,
        ),
      VhBadgeTone.success => (
          bg: AppColors.success.withValues(alpha: 0.12),
          fg: AppColors.success,
        ),
      VhBadgeTone.warning => (
          bg: AppColors.warning.withValues(alpha: 0.12),
          fg: AppColors.warning,
        ),
      VhBadgeTone.danger => (
          bg: AppColors.danger.withValues(alpha: 0.12),
          fg: AppColors.danger,
        ),
      VhBadgeTone.neutral => (
          bg: isDark ? AppColors.mutedDark : AppColors.muted,
          fg: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      VhBadgeTone.accent => (
          bg: AppColors.accent.withValues(alpha: 0.12),
          fg: isDark ? AppColors.accentDark : AppColors.accent,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = _colors(isDark);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: colors.fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.fg,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
