import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class ClockView extends StatefulWidget {
  final double size ;

  const ClockView({Key? key, required this.size}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = CustomColors.clockBG;
    var outlineBrush = Paint()
      ..color = CustomColors.clockOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20;
    var centerDotBrush = Paint()..color = CustomColors.clockOutline;

    var secHandBrush = Paint()
      ..color = CustomColors.secHandColor!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [CustomColors.minHandStatColor, CustomColors.minHandEndColor])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [CustomColors.hourHandStatColor, CustomColors.hourHandEndColor])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 24;

    var dashBrush = Paint()
      ..color = CustomColors.clockOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    var hourHandX = centerX + radius * 0.4 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerY + radius * 0.4 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerY + radius * 0.6 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerY + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, radius * 0.12, centerDotBrush);

    var outerRadius = radius;
    var innerRadius = radius * 0.9;
    for (var i = 0; i < 360; i += 12) {
      var x1 = centerX + outerRadius * cos(i * pi / 180);
      var y1 = centerY + outerRadius * sin(i * pi / 180);

      var x2 = centerX + innerRadius * cos(i * pi / 180);
      var y2 = centerY + innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
//   @override
//   void paint(Canvas canvas, Size size) {
//     var centerX = size.width / 2;
//     var centerY = size.height / 2;
//     var center = Offset(centerX, centerY);
//     var radius = min(centerX, centerY);
//
//     var fillBrush = Paint()..color = Color(0xFF444974);
//
//     var outlinedBrush = Paint()
//       ..color = Color(0xFFEAECFF)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 16;
//
//     var centerFillBrush = Paint()..color = Color(0xFFEAECFF);
//
//     var secHandBrush = Paint()
//       ..color = Colors.orange[300]!
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 8;
//
//     var minHandBrush = Paint()
//       ..shader =
//           const RadialGradient(colors: [Colors.lightBlue, Color(0Xff77DDFF)])
//               .createShader(Rect.fromCircle(center: center, radius: radius))
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 12;
//
//     var hourHandBrush = Paint()
//       ..shader =
//           const RadialGradient(colors: [Color(0XFFEA74AB), Color(0XFFC279FB)])
//               .createShader(Rect.fromCircle(center: center, radius: radius))
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 16;
//
//     var dashBrush = Paint()
//       ..color = const Color(0xFFEAECFF)
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 1;
//
//     canvas.drawCircle(center, radius - 40, fillBrush);
//     canvas.drawCircle(center, radius - 40, outlinedBrush);
//
//     var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
//     var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
//     canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);
//
//     var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
//     var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
//     canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);
//
//     var hourHandX = centerX +
//         60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
//     var hourHandY = centerX +
//         60 * sin((dateTime.hour * 30 * dateTime.minute * 0.5) * pi / 180);
//     canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);
//
//     canvas.drawCircle(center, 16, centerFillBrush);
//
//     var outerCircleRadius = radius;
//     var innerCircleRadius = radius - 14;
//     for (double i = 0; i < 360; i += 12) {
//       var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
//       var y1 = centerY + outerCircleRadius * sin(i * pi / 180);
//
//       var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
//       var y2 = centerY + innerCircleRadius * sin(i * pi / 180);
//       canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
