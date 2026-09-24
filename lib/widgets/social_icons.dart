import 'package:flutter/material.dart';

/// Custom vector widget for Instagram Logo
class InstagramIcon extends StatelessWidget {
  final double size;
  const InstagramIcon({super.key, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.25),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFFFEE440),
            Color(0xFFF77737),
            Color(0xFFE1306C),
            Color(0xFFC13584),
            Color(0xFF833AB4),
          ],
        ),
      ),
      child: CustomPaint(
        size: Size(size, size),
        painter: _InstagramPainter(),
      ),
    );
  }
}

class _InstagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.085;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Outer rounded box stroke
    final double boxMargin = w * 0.18;
    final double boxSize = w - (boxMargin * 2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(boxMargin, boxMargin, boxSize, boxSize),
        Radius.circular(w * 0.16),
      ),
      strokePaint,
    );

    // Center circle stroke
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.5),
      w * 0.19,
      strokePaint,
    );

    // Top-right dot fill
    canvas.drawCircle(
      Offset(w * 0.70, h * 0.30),
      w * 0.055,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom vector widget for Facebook Logo
class FacebookIcon extends StatelessWidget {
  final double size;
  const FacebookIcon({super.key, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _FacebookPainter(),
    );
  }
}

class _FacebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Background blue circle
    final bgPaint = Paint()
      ..color = const Color(0xFF1877F2)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.5, bgPaint);

    // Facebook 'f' logo path
    final fPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(w * 0.66, h * 0.96);
    path.lineTo(w * 0.66, h * 0.58);
    path.lineTo(w * 0.78, h * 0.58);
    path.lineTo(w * 0.80, h * 0.44);
    path.lineTo(w * 0.66, h * 0.44);
    path.lineTo(w * 0.66, h * 0.36);
    path.cubicTo(w * 0.66, h * 0.29, w * 0.69, h * 0.25, w * 0.77, h * 0.25);
    path.lineTo(w * 0.81, h * 0.25);
    path.lineTo(w * 0.81, h * 0.11);
    path.cubicTo(w * 0.77, h * 0.10, w * 0.71, h * 0.09, w * 0.64, h * 0.09);
    path.cubicTo(w * 0.50, h * 0.09, w * 0.42, h * 0.17, w * 0.42, h * 0.32);
    path.lineTo(w * 0.42, h * 0.44);
    path.lineTo(w * 0.31, h * 0.44);
    path.lineTo(w * 0.31, h * 0.58);
    path.lineTo(w * 0.42, h * 0.58);
    path.lineTo(w * 0.42, h * 0.96);
    path.close();

    canvas.drawPath(path, fPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom vector widget for LinkedIn Logo
class LinkedInIcon extends StatelessWidget {
  final double size;
  const LinkedInIcon({super.key, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _LinkedInPainter(),
    );
  }
}

class _LinkedInPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final bgPaint = Paint()
      ..color = const Color(0xFF0A66C2)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), Radius.circular(w * 0.2)),
      bgPaint,
    );

    final textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // 'i' dot
    canvas.drawCircle(Offset(w * 0.26, h * 0.28), w * 0.065, textPaint);

    // 'i' bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(w * 0.20, h * 0.40, w * 0.32, h * 0.78),
        Radius.circular(w * 0.02),
      ),
      textPaint,
    );

    // 'n' left bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(w * 0.42, h * 0.40, w * 0.54, h * 0.78),
        Radius.circular(w * 0.02),
      ),
      textPaint,
    );

    // 'n' arch & right bar path
    final nPath = Path();
    nPath.moveTo(w * 0.54, h * 0.52);
    nPath.cubicTo(w * 0.58, h * 0.40, w * 0.67, h * 0.38, w * 0.74, h * 0.42);
    nPath.cubicTo(w * 0.80, h * 0.45, w * 0.80, h * 0.53, w * 0.80, h * 0.60);
    nPath.lineTo(w * 0.80, h * 0.78);
    nPath.lineTo(w * 0.68, h * 0.78);
    nPath.lineTo(w * 0.68, h * 0.61);
    nPath.cubicTo(w * 0.68, h * 0.54, w * 0.65, h * 0.50, w * 0.60, h * 0.50);
    nPath.cubicTo(w * 0.55, h * 0.50, w * 0.54, h * 0.54, w * 0.54, h * 0.60);
    nPath.close();

    canvas.drawPath(nPath, textPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
