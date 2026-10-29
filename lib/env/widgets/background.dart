part of '../env.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
    this.opacity = 0.25,
    this.backgroundColor,
    this.position = 0.0,
    required this.child,
  }) : builder = null;

  const Background.builder(
    this.builder, {
    super.key,
    this.opacity = 0.25,
    this.child = const SizedBox(),
    this.backgroundColor,
  })  : position = 0.0,
        assert(builder != null);
  final Widget child;
  final Widget Function(BuildContext context, Widget child)? builder;
  final double opacity;
  final Color? backgroundColor;

  /// Vertical progress of the pattern, from 0.0 (top) to 1.0 (bottom).
  final double position;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: ColoredBox(color: backgroundColor ?? context.color.primary)),
        Positioned.fill(
            child: Opacity(
                opacity: opacity,
                child: builder != null
                    ? Builder(builder: (context) => builder!(context, child))
                    : CustomPaint(
                        painter: BackgroundPainter(
                          position: position,
                          color: context.color.background,
                          accent: context.color.secondary,
                        ),
                      ))),
        child
      ],
    );
  }

  static Background parallax({
    required Widget child,
  }) {
    return Background.builder(
        (_, __) => DChangeBuilder(
              value: Env.controller.scroll,
              builder: (context, value, child) {
                double position = 0.0;

                if (value.hasClients) {
                  double maxScrollExtent = value.position.maxScrollExtent;
                  double offset = value.offset;

                  if (maxScrollExtent > 0) {
                    position = offset / maxScrollExtent;
                  }
                }
                return RepaintBoundary(
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: BackgroundPainter(
                      position: position,
                      color: context.color.background,
                      accent: context.color.secondary,
                    ),
                  ),
                );
              },
            ),
        child: child);
  }
}

/// Paints a subtle blueprint-style grid with orbit rings, replacing the
/// original raster background image.
class BackgroundPainter extends CustomPainter {
  const BackgroundPainter({
    required this.position,
    required this.color,
    required this.accent,
  });

  final double position;
  final Color color, accent;

  @override
  void paint(Canvas canvas, Size size) {
    const double cell = 48.0;
    final double shift = position * size.height * 0.6;

    // [1] Draw the grid, shifted to create the parallax effect
    final grid = Paint()
      ..color = color.withOpacity(0.08)
      ..strokeWidth = 1.0;
    for (double x = 0.0; x <= size.width; x += cell) {
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), grid);
    }
    for (double y = -(shift % cell); y <= size.height; y += cell) {
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), grid);
    }

    // [2] Draw concentric rings on opposite corners
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final double base = size.shortestSide.limit(320.0, 900.0);
    final rings = [
      (Offset(size.width * 0.9, size.height * 0.15 - shift * 0.5), color),
      (Offset(size.width * 0.05, size.height * 0.85 - shift * 0.25), accent),
    ];
    for (final (center, tone) in rings) {
      for (int i = 1; i <= 4; i++) {
        ring.color = tone.withOpacity(0.25 / i);
        canvas.drawCircle(center, base * 0.18 * i, ring);
      }
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) {
    return oldDelegate.position != position ||
        oldDelegate.color != color ||
        oldDelegate.accent != accent;
  }
}
