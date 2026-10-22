import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF1B4DFF);
  static const Color primaryDark = Color(0xFF4C7DFF);
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryDark = Color(0xFF34D399);
  static const Color accent = Color(0xFFFF7A1A);
  static const Color accentDark = Color(0xFFFF9A4D);

  // Surfaces
  static const Color background = Color(0xFFF4F6FA);
  static const Color backgroundDark = Color(0xFF0B1220);
  static const Color elevated = Color(0xFFFFFFFF);
  static const Color elevatedDark = Color(0xFF121A2B);
  static const Color muted = Color(0xFFEEF1F7);
  static const Color mutedDark = Color(0xFF1A2336);

  // Text
  static const Color text = Color(0xFF0F172A);
  static const Color textDark = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  // Semantic
  static const Color danger = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color success = Color(0xFF16A34A);

  // Border
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF243044);

  static ColorScheme get lightScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: Colors.white,
        secondary: secondary,
        onSecondary: Colors.white,
        tertiary: accent,
        onTertiary: Colors.white,
        error: danger,
        onError: Colors.white,
        surface: elevated,
        onSurface: text,
        surfaceContainerHighest: muted,
        onSurfaceVariant: textSecondary,
        outline: border,
      );

  static ColorScheme get darkScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: primaryDark,
        onPrimary: Colors.white,
        secondary: secondaryDark,
        onSecondary: Colors.white,
        tertiary: accentDark,
        onTertiary: Colors.white,
        error: danger,
        onError: Colors.white,
        surface: elevatedDark,
        onSurface: textDark,
        surfaceContainerHighest: mutedDark,
        onSurfaceVariant: textSecondaryDark,
        outline: borderDark,
      );
}
