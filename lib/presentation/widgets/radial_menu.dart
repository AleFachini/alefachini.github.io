import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Un ítem del menú radial: icono opcional, texto y callback al seleccionarlo.
class RadialMenuItem {
  final FaIconData? icon;
  final String label;
  final Color? color;
  final VoidCallback? onSelected;
  final bool isActive;

  const RadialMenuItem({
    this.icon,
    required this.label,
    this.color,
    this.onSelected,
    this.isActive = false,
  });
}

/// Menú radial estilo "porciones de pizza" que nace de una esquina
/// (por defecto la inferior izquierda) y se expande al pasar el mouse
/// o al tocar cada porción.
///
/// Configuraciones disponibles:
/// - [baseRadius] / [activeRadius]: largo de cada porción en reposo y activa.
/// - [gapDegrees]: separación angular entre porciones.
/// - [totalSpanDeg] / [startAngleDeg]: abanico total y ángulo inicial.
/// - [cornerRadius]: qué tan redondeadas son las puntas (centro y exteriores).
/// - [baseColor] / [activeColor]: colores en reposo y al activarse.
/// - [icon] y [label] van dentro de cada [RadialMenuItem].
/// - [rotateLabels]: si el texto se rota siguiendo el ángulo de la porción.
class RadialMenu extends StatefulWidget {
  final List<RadialMenuItem> items;

  final double baseRadius;
  final double activeRadius;

  final double startAngleDeg;
  final double totalSpanDeg;
  final double gapDegrees;

  final double cornerRadius;

  final Color baseColor;
  final Color activeColor;
  final Color textColor;
  final Color? iconColor;
  final TextStyle? labelStyle;
  final double iconSize;

  final bool rotateLabels;
  final double labelRadiusFactor;

  final Duration animationDuration;
  final Curve animationCurve;

  final Offset originOffset;

  const RadialMenu({
    super.key,
    required this.items,
    this.baseRadius = 90,
    this.activeRadius = 140,
    this.startAngleDeg = 8,
    this.totalSpanDeg = 80,
    this.gapDegrees = 3,
    this.cornerRadius = 10,
    this.baseColor = const Color(0xFF7F77DD),
    this.activeColor = const Color(0xFF534AB7),
    this.textColor = Colors.white,
    this.iconColor,
    this.labelStyle,
    this.iconSize = 20,
    this.rotateLabels = false,
    this.labelRadiusFactor = 0.62,
    this.animationDuration = const Duration(milliseconds: 260),
    this.animationCurve = Curves.easeOut,
    this.originOffset = const Offset(24, 24),
  }) : assert(items.length > 0, 'RadialMenu necesita al menos un item');

  @override
  State<RadialMenu> createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  int? _activeIndex;

  @override
  void initState() {
    super.initState();
    _controllers = _buildControllers();
  }

  List<AnimationController> _buildControllers() {
    return List.generate(
      widget.items.length,
      (_) => AnimationController(vsync: this, duration: widget.animationDuration),
    );
  }

  @override
  void didUpdateWidget(covariant RadialMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      for (final c in _controllers) {
        c.dispose();
      }
      _controllers = _buildControllers();
      _activeIndex = null;
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  // Ancho angular de cada porción, descontando los espacios (gaps) entre ellas.
  double get _sliceAngleDeg {
    final n = widget.items.length;
    final totalGap = widget.gapDegrees * (n - 1);
    return (widget.totalSpanDeg - totalGap) / n;
  }

  // Ángulo central de la porción i, en grados, convención matemática
  // estándar (0° = derecha, aumenta en sentido antihorario/hacia arriba).
  double _angleCenterDeg(int index) {
    final step = _sliceAngleDeg + widget.gapDegrees;
    return widget.startAngleDeg + step * index;
  }

  // Determina qué porción contiene el punto dado (o null si ninguna).
  int? _hitTest(Offset localPosition, Offset origin) {
    final dx = localPosition.dx - origin.dx;
    final dy = origin.dy - localPosition.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    final angleDeg = math.atan2(dy, dx) * 180 / math.pi;
    final halfSlice = _sliceAngleDeg / 2;

    for (var i = 0; i < widget.items.length; i++) {
      final center = _angleCenterDeg(i);
      var diff = (angleDeg - center) % 360;
      if (diff > 180) diff -= 360;
      if (diff < -180) diff += 360;
      if (diff.abs() > halfSlice) continue;

      final currentRadius = widget.baseRadius +
          (widget.activeRadius - widget.baseRadius) * _controllers[i].value;
      if (distance <= currentRadius + widget.cornerRadius) {
        return i;
      }
    }
    return null;
  }

  void _setActive(int? index) {
    if (_activeIndex == index) return;
    if (_activeIndex != null) {
      _controllers[_activeIndex!].reverse();
    }
    if (index != null) {
      _controllers[index].forward();
    }
    setState(() => _activeIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final origin = Offset(
          widget.originOffset.dx,
          size.height - widget.originOffset.dy,
        );

        return MouseRegion(
          onHover: (event) => _setActive(_hitTest(event.localPosition, origin)),
          onExit: (_) => _setActive(null),
          child: GestureDetector(
            onTapDown: (details) => _setActive(_hitTest(details.localPosition, origin)),
            onTapUp: (details) {
              final index = _hitTest(details.localPosition, origin);
              if (index != null) {
                widget.items[index].onSelected?.call();
              }
            },
            child: AnimatedBuilder(
              animation: Listenable.merge(_controllers),
              builder: (context, _) {
                return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: size,
                        painter: _RadialMenuPainter(
                          items: widget.items,
                          controllers: _controllers,
                          origin: origin,
                          baseRadius: widget.baseRadius,
                          activeRadius: widget.activeRadius,
                          cornerRadius: widget.cornerRadius,
                          baseColor: widget.baseColor,
                          activeColor: widget.activeColor,
                          angleCenterDeg: _angleCenterDeg,
                          sliceAngleDeg: _sliceAngleDeg,
                        ),
                      ),
                      ..._buildLabels(origin),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildLabels(Offset origin) {
    return List.generate(widget.items.length, (i) {
      final t = _controllers[i].value;
      final item = widget.items[i];
      final isSectionActive = item.isActive;
      // Slightly highlight active section label
      final effectiveT = math.max(t, isSectionActive ? 0.3 : 0.0);
      
      final angleRad = _angleCenterDeg(i) * math.pi / 180;
      final radius = widget.baseRadius + (widget.activeRadius - widget.baseRadius) * effectiveT;
      final labelRadius = radius * widget.labelRadiusFactor;
      final dx = origin.dx + labelRadius * math.cos(angleRad);
      final dy = origin.dy - labelRadius * math.sin(angleRad);
      
      final activeTextColor = isSectionActive ? widget.activeColor : widget.textColor;
      // Also fade in labels if they are active, or partially show them
      // We will make them always fully visible when expanded, or partially visible.
      // But the original code used `opacity: t`. We can use `opacity: math.max(t, isSectionActive ? 1.0 : 0.5)` so labels are readable.
      final opacity = math.max(t, isSectionActive ? 1.0 : 0.7);

      return Positioned(
        left: dx - 44,
        top: dy - 22,
        width: 88,
        height: 44,
        child: IgnorePointer(
          child: Opacity(
            opacity: opacity,
            child: Transform.rotate(
              angle: widget.rotateLabels ? -angleRad : 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.icon != null)
                    FaIcon(item.icon, size: widget.iconSize, color: widget.iconColor ?? activeTextColor),
                  Text(
                    item.label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: widget.labelStyle ??
                        TextStyle(fontSize: 12, fontWeight: isSectionActive ? FontWeight.w800 : FontWeight.w600, color: activeTextColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _RadialMenuPainter extends CustomPainter {
  final List<RadialMenuItem> items;
  final List<AnimationController> controllers;
  final Offset origin;
  final double baseRadius;
  final double activeRadius;
  final double cornerRadius;
  final Color baseColor;
  final Color activeColor;
  final double Function(int) angleCenterDeg;
  final double sliceAngleDeg;

  _RadialMenuPainter({
    required this.items,
    required this.controllers,
    required this.origin,
    required this.baseRadius,
    required this.activeRadius,
    required this.cornerRadius,
    required this.baseColor,
    required this.activeColor,
    required this.angleCenterDeg,
    required this.sliceAngleDeg,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final halfAngle = sliceAngleDeg / 2 * math.pi / 180;

    for (var i = 0; i < items.length; i++) {
      final t = controllers[i].value;
      final bool isSectionActive = items[i].isActive;
      // Slightly expand active section
      final double effectiveT = math.max(t, isSectionActive ? 0.15 : 0.0);
      
      final radius = baseRadius + (activeRadius - baseRadius) * effectiveT;
      
      final baseColorForSlice = isSectionActive ? activeColor.withValues(alpha: 0.7) : baseColor;
      final color = Color.lerp(baseColorForSlice, items[i].color ?? activeColor, t) ?? baseColorForSlice;
      
      final angleRad = angleCenterDeg(i) * math.pi / 180;

      canvas.save();
      canvas.translate(origin.dx, origin.dy);
      canvas.rotate(-angleRad);

      // Porción con forma de sector circular (M -> L -> arco -> close),
      // igual que una porción de pizza vista desde arriba.
      final path = Path()
        ..moveTo(0, 0)
        ..lineTo(radius * math.cos(halfAngle), -radius * math.sin(halfAngle))
        ..arcTo(Rect.fromCircle(center: Offset.zero, radius: radius), -halfAngle, halfAngle * 2, false)
        ..close();

      final fillPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      // Trazo grueso con uniones redondeadas: así se redondean tanto
      // la punta central como las dos puntas exteriores del sector.
      final strokePaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = cornerRadius * 2
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(path, fillPaint);
      canvas.drawPath(path, strokePaint);
      canvas.restore();
    }

    final hubPaint = Paint()..color = baseColor.withValues(alpha: 0.55);
    canvas.drawCircle(origin, 6, hubPaint);
  }

  @override
  bool shouldRepaint(covariant _RadialMenuPainter oldDelegate) => true;
}
