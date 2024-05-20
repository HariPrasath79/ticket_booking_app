import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5009833, size.height * 0.0068000);
    path_0.quadraticBezierTo(size.width * 0.4233083, size.height * 0.0074286,
        size.width * 0.3822333, size.height * 0.1814714);
    path_0.lineTo(size.width * 0.3822333, size.height * 0.2800571);
    path_0.lineTo(size.width * 0.3822333, size.height * 0.3674571);
    path_0.lineTo(size.width * 0.2101417, size.height * 0.4888571);
    path_0.lineTo(size.width * 0.2676500, size.height * 0.5242714);
    path_0.lineTo(size.width * 0.3822333, size.height * 0.4859857);
    path_0.lineTo(size.width * 0.3822333, size.height * 0.7260000);
    path_0.quadraticBezierTo(size.width * 0.4387417, size.height * 0.8810857,
        size.width * 0.5004583, size.height * 0.8818857);
    path_0.quadraticBezierTo(size.width * 0.5670750, size.height * 0.8717429,
        size.width * 0.6170000, size.height * 0.7230286);
    path_0.lineTo(size.width * 0.6170000, size.height * 0.4859857);
    path_0.lineTo(size.width * 0.7238000, size.height * 0.5134286);
    path_0.lineTo(size.width * 0.7839750, size.height * 0.4863000);
    path_0.lineTo(size.width * 0.6170000, size.height * 0.3674571);
    path_0.lineTo(size.width * 0.6170000, size.height * 0.2770857);
    path_0.lineTo(size.width * 0.6170000, size.height * 0.1814714);
    path_0.quadraticBezierTo(size.width * 0.5807750, size.height * 0.0099714,
        size.width * 0.5009833, size.height * 0.0068000);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 220, 201, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.001
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);

    // Layer 1

    Paint paint_fill_1 = Paint()
      ..color = Colors.grey[100]!
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.001
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.4379250, size.height * 0.8319286);
    path_1.lineTo(size.width * 0.3275667, size.height * 0.9748143);
    path_1.lineTo(size.width * 0.4053250, size.height * 0.9755857);
    path_1.lineTo(size.width * 0.5000750, size.height * 0.8910286);
    path_1.lineTo(size.width * 0.5993500, size.height * 0.9754429);
    path_1.lineTo(size.width * 0.6743417, size.height * 0.9746857);
    path_1.lineTo(size.width * 0.5631417, size.height * 0.8326000);

    canvas.drawPath(path_1, paint_fill_1);

    // Layer 1

    Paint paint_stroke_1 = Paint()
      ..color = const Color.fromARGB(255, 220, 201, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paint_stroke_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
