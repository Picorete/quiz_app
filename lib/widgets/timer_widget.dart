import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class BeautifulTimer extends StatefulWidget {
  final AnimationController animationController;
  final AnimationController animationController2;
  BeautifulTimer({Key key, this.animationController, this.animationController2})
      : super(key: key);

  @override
  _BeautifulTimerState createState() => _BeautifulTimerState();
}

class _BeautifulTimerState extends State<BeautifulTimer> {
  CurvedAnimation curvendAnimation;
  CurvedAnimation curvendAnimation2;
  @override
  void initState() {
    super.initState();
    curvendAnimation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.decelerate,
    );
    curvendAnimation2 = CurvedAnimation(
      parent: widget.animationController2,
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: curvendAnimation2,
        builder: (_, __) {
          return AnimatedBuilder(
            animation: curvendAnimation,
            builder: (_, __) {
              return CustomPaint(
                painter: TimerPainter(
                    curvendAnimation.value, curvendAnimation2.value),
              );
            },
          );
        });
  }
}

class TimerPainter extends CustomPainter {
  double animationValue;
  double animationValue2;

  TimerPainter(this.animationValue, this.animationValue2);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color(0xFFF6F6F8).withOpacity(.5)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..shader;
    Path drawCircle = this.drawCircle(Offset(0, 0));

    ui.PathMetrics pathMetrics = drawCircle.computeMetrics();
    for (ui.PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * animationValue,
      );
      canvas.drawPath(extractPath, paint);
    }

    if (animationValue == 1.0) {
      paint = new Paint()
        ..strokeWidth = 15
        ..style = PaintingStyle.stroke
        ..shader
        ..strokeCap = StrokeCap.round
        ..shader = ui.Gradient.linear(Offset(30, 30), Offset(-35, -35), [
          Color(0xFFC034EB),
          Color(0xFFE23535),
        ]);

      drawCircle = this.drawCircle(Offset(0, 0));
      ui.PathMetrics pathMetrics = drawCircle.computeMetrics();
      for (ui.PathMetric pathMetric in pathMetrics) {
        Path extractPath = pathMetric.extractPath(
          0.0,
          pathMetric.length * animationValue2,
        );
        canvas.drawPath(extractPath, paint);
      }
    }
  }

  Path drawCircle(Offset center) {
    var path = Path();

    path.addOval(Rect.fromCircle(center: center, radius: 70));
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
