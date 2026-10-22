import 'package:flutter/material.dart';
import 'package:vehiclehub_pakistan/core/theme/app_colors.dart';

class MechanicAvatar extends StatelessWidget {
  const MechanicAvatar({
    super.key,
    required this.name,
    this.size = 48,
    this.color,
  });

  final String name;
  final double size;
  final Color? color;

  static const _palette = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.accent,
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
    Color(0xFF06B6D4),
  ];

  String get _initial {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed[0].toUpperCase();
  }

  Color _resolveColor() {
    if (color != null) return color!;
    final index = name.hashCode.abs() % _palette.length;
    return _palette[index];
  }

  @override
  Widget build(BuildContext context) {
    final bg = _resolveColor();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(size * 0.28),
        border: Border.all(color: bg.withValues(alpha: 0.35)),
      ),
      alignment: Alignment.center,
      child: Text(
        _initial,
        style: TextStyle(
          color: bg,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.38,
        ),
      ),
    );
  }
}
