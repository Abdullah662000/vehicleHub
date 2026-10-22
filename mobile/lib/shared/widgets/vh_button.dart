import 'package:flutter/material.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';

enum VhButtonVariant {
  primary,
  secondary,
  accent,
  outline,
  soft,
  danger,
  ghost,
}

enum VhButtonSize { sm, md, lg }

class VhButton extends StatelessWidget {
  const VhButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = VhButtonVariant.primary,
    this.size = VhButtonSize.md,
    this.fullWidth = false,
    this.loading = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final VhButtonVariant variant;
  final VhButtonSize size;
  final bool fullWidth;
  final bool loading;
  final IconData? icon;

  double get _height => switch (size) {
        VhButtonSize.sm => 40,
        VhButtonSize.md => 48,
        VhButtonSize.lg => 56,
      };

  EdgeInsets get _padding => switch (size) {
        VhButtonSize.sm =>
          const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        VhButtonSize.md =>
          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        VhButtonSize.lg =>
          const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      };

  TextStyle _textStyle(BuildContext context) {
    final base = Theme.of(context).textTheme.labelLarge!;
    return base.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: switch (size) {
        VhButtonSize.sm => 13,
        VhButtonSize.md => 14,
        VhButtonSize.lg => 16,
      },
    );
  }

  ({Color bg, Color fg, Color? border}) _colors(bool isDark) {
    return switch (variant) {
      VhButtonVariant.primary => (
          bg: isDark ? AppColors.primaryDark : AppColors.primary,
          fg: Colors.white,
          border: null,
        ),
      VhButtonVariant.secondary => (
          bg: isDark ? AppColors.secondaryDark : AppColors.secondary,
          fg: Colors.white,
          border: null,
        ),
      VhButtonVariant.accent => (
          bg: isDark ? AppColors.accentDark : AppColors.accent,
          fg: Colors.white,
          border: null,
        ),
      VhButtonVariant.outline => (
          bg: Colors.transparent,
          fg: isDark ? AppColors.textDark : AppColors.text,
          border: isDark ? AppColors.borderDark : AppColors.border,
        ),
      VhButtonVariant.soft => (
          bg: isDark ? AppColors.mutedDark : AppColors.muted,
          fg: isDark ? AppColors.primaryDark : AppColors.primary,
          border: null,
        ),
      VhButtonVariant.danger => (
          bg: AppColors.danger,
          fg: Colors.white,
          border: null,
        ),
      VhButtonVariant.ghost => (
          bg: Colors.transparent,
          fg: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          border: null,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = _colors(isDark);
    final disabled = onPressed == null || loading;

    final child = loading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colors.fg,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: colors.fg),
                const SizedBox(width: 8),
              ],
              Text(label, style: _textStyle(context).copyWith(color: colors.fg)),
            ],
          );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: _height,
      child: Material(
        color: disabled ? colors.bg.withValues(alpha: 0.5) : colors.bg,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: disabled ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: colors.border != null
                  ? Border.all(color: colors.border!)
                  : null,
            ),
            child: Padding(
              padding: _padding,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
