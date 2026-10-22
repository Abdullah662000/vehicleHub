import 'package:flutter/material.dart';

/// Pakistani-market vehicle illustrations (ported from web SVG art).
enum VehicleArtKind {
  corolla,
  civic,
  sportage,
  hilux,
  alto,
  city,
  tucson,
  mg,
}

class _VehiclePalette {
  const _VehiclePalette({
    required this.body,
    required this.accent,
    required this.glass,
  });

  final Color body;
  final Color accent;
  final Color glass;
}

const _palettes = <VehicleArtKind, _VehiclePalette>{
  VehicleArtKind.corolla: _VehiclePalette(
    body: Color(0xFF1B4DFF),
    accent: Color(0xFF0E35C9),
    glass: Color(0xFFBFDBFE),
  ),
  VehicleArtKind.civic: _VehiclePalette(
    body: Color(0xFF0F172A),
    accent: Color(0xFF334155),
    glass: Color(0xFFE2E8F0),
  ),
  VehicleArtKind.alto: _VehiclePalette(
    body: Color(0xFF10B981),
    accent: Color(0xFF059669),
    glass: Color(0xFFA7F3D0),
  ),
  VehicleArtKind.hilux: _VehiclePalette(
    body: Color(0xFF78350F),
    accent: Color(0xFF92400E),
    glass: Color(0xFFFDE68A),
  ),
  VehicleArtKind.city: _VehiclePalette(
    body: Color(0xFF64748B),
    accent: Color(0xFF475569),
    glass: Color(0xFFE2E8F0),
  ),
  VehicleArtKind.sportage: _VehiclePalette(
    body: Color(0xFFFF7A1A),
    accent: Color(0xFFEA580C),
    glass: Color(0xFFFED7AA),
  ),
  VehicleArtKind.tucson: _VehiclePalette(
    body: Color(0xFF0EA5E9),
    accent: Color(0xFF0284C7),
    glass: Color(0xFFBAE6FD),
  ),
  VehicleArtKind.mg: _VehiclePalette(
    body: Color(0xFFDC2626),
    accent: Color(0xFFB91C1C),
    glass: Color(0xFFFECACA),
  ),
};

VehicleArtKind vehicleArtFromPhoto(String photo) {
  final key = photo.toLowerCase().trim();
  return switch (key) {
    'civic' => VehicleArtKind.civic,
    'sportage' => VehicleArtKind.sportage,
    'hilux' => VehicleArtKind.hilux,
    'alto' => VehicleArtKind.alto,
    'city' => VehicleArtKind.city,
    'tucson' => VehicleArtKind.tucson,
    'mg' => VehicleArtKind.mg,
    'corolla' => VehicleArtKind.corolla,
    _ => vehicleArtFromModel(key),
  };
}

VehicleArtKind vehicleArtFromModel(String makeOrModel) {
  final m = makeOrModel.toLowerCase();
  if (m.contains('civic')) return VehicleArtKind.civic;
  if (m.contains('sportage')) return VehicleArtKind.sportage;
  if (m.contains('hilux')) return VehicleArtKind.hilux;
  if (m.contains('alto')) return VehicleArtKind.alto;
  if (m.contains('city')) return VehicleArtKind.city;
  if (m.contains('tucson')) return VehicleArtKind.tucson;
  if (m.contains('mg')) return VehicleArtKind.mg;
  if (m.contains('corolla') || m.contains('yaris')) {
    return VehicleArtKind.corolla;
  }
  return VehicleArtKind.corolla;
}

class VehicleArt extends StatelessWidget {
  const VehicleArt({
    super.key,
    required this.kind,
    this.size = 120,
    this.height,
  });

  final VehicleArtKind kind;

  /// Width of the illustration (matches web `size`). Height is ~0.62× size.
  final double size;

  /// Optional explicit height; when set, width fills the parent.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final palette = _palettes[kind] ?? _palettes[VehicleArtKind.corolla]!;
    final h = height ?? size * 0.62;

    return SizedBox(
      width: height != null ? double.infinity : size,
      height: h,
      child: CustomPaint(
        painter: _VehicleIllustrationPainter(palette: palette),
      ),
    );
  }
}

class _VehicleIllustrationPainter extends CustomPainter {
  _VehicleIllustrationPainter({required this.palette});

  final _VehiclePalette palette;

  /// Design viewBox from web SVG: 0 0 200 124
  static const double _vbW = 200;
  static const double _vbH = 124;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / _vbW;
    final fittedH = _vbH * scale;
    final dy = (size.height - fittedH) / 2;

    canvas.save();
    canvas.translate(0, dy);
    canvas.scale(scale);

    // Ground shadow
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(100, 112), width: 140, height: 12),
      Paint()..color = const Color(0xFF0F172A).withValues(alpha: 0.08),
    );

    // Body
    canvas.drawPath(
      _parseSvgPath(
        'M28 78c8-22 28-34 52-36h40c24 2 44 14 52 36l4 14H24l4-14z',
      ),
      Paint()
        ..color = palette.body
        ..style = PaintingStyle.fill,
    );

    // Glass / cabin
    canvas.drawPath(
      _parseSvgPath(
        'M52 48c10-10 22-14 38-14h20c16 0 28 4 38 14l-8 18H60l-8-18z',
      ),
      Paint()
        ..color = palette.glass
        ..style = PaintingStyle.fill,
    );

    // Window dividers (accent tint)
    final dividerPaint = Paint()
      ..color = palette.accent.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    canvas.drawPath(_parseSvgPath('M70 48h20v18H66l4-18z'), dividerPaint);
    canvas.drawPath(_parseSvgPath('M110 48h20l4 18H110V48z'), dividerPaint);

    // Lower accent strip
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(24, 88, 152, 10),
        const Radius.circular(3),
      ),
      Paint()..color = palette.accent,
    );

    // Wheels
    const wheelOuter = Color(0xFF0F172A);
    const wheelInner = Color(0xFF94A3B8);
    for (final cx in [54.0, 146.0]) {
      canvas.drawCircle(Offset(cx, 98), 14, Paint()..color = wheelOuter);
      canvas.drawCircle(Offset(cx, 98), 7, Paint()..color = wheelInner);
    }

    // Headlights / taillights
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(36, 80, 12, 5),
        const Radius.circular(2),
      ),
      Paint()..color = const Color(0xFFFBBF24),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(152, 80, 12, 5),
        const Radius.circular(2),
      ),
      Paint()..color = const Color(0xFFEF4444),
    );

    // Roof fin
    canvas.drawPath(
      _parseSvgPath('M95 42h10v4H95z'),
      Paint()..color = palette.accent,
    );

    canvas.restore();
  }

  /// Minimal SVG path parser for the illustration commands we use.
  Path _parseSvgPath(String d) {
    final path = Path();
    final tokens = RegExp(r'[MmLlHhVvCcZz]|-?\d*\.?\d+(?:e[-+]?\d+)?')
        .allMatches(d)
        .map((m) => m.group(0)!)
        .toList();

    var i = 0;
    var cx = 0.0;
    var cy = 0.0;
    String? cmd;

    double next() => double.parse(tokens[i++]);

    while (i < tokens.length) {
      final t = tokens[i];
      if (RegExp(r'^[MmLlHhVvCcZz]$').hasMatch(t)) {
        cmd = t;
        i++;
      }
      if (cmd == null) break;

      switch (cmd) {
        case 'M':
          cx = next();
          cy = next();
          path.moveTo(cx, cy);
          cmd = 'L';
        case 'm':
          cx += next();
          cy += next();
          path.moveTo(cx, cy);
          cmd = 'l';
        case 'L':
          cx = next();
          cy = next();
          path.lineTo(cx, cy);
        case 'l':
          cx += next();
          cy += next();
          path.lineTo(cx, cy);
        case 'H':
          cx = next();
          path.lineTo(cx, cy);
        case 'h':
          cx += next();
          path.lineTo(cx, cy);
        case 'V':
          cy = next();
          path.lineTo(cx, cy);
        case 'v':
          cy += next();
          path.lineTo(cx, cy);
        case 'C':
          final x1 = next(), y1 = next();
          final x2 = next(), y2 = next();
          cx = next();
          cy = next();
          path.cubicTo(x1, y1, x2, y2, cx, cy);
        case 'c':
          final x1 = cx + next(), y1 = cy + next();
          final x2 = cx + next(), y2 = cy + next();
          cx += next();
          cy += next();
          path.cubicTo(x1, y1, x2, y2, cx, cy);
        case 'Z':
        case 'z':
          path.close();
        default:
          break;
      }
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant _VehicleIllustrationPainter oldDelegate) {
    return oldDelegate.palette.body != palette.body ||
        oldDelegate.palette.accent != palette.accent ||
        oldDelegate.palette.glass != palette.glass;
  }
}
