import 'package:flutter/material.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/quiz_question.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class ResultPage extends StatefulWidget {
  final QuestionOptionBox questionOptionBox;
  ResultPage(this.questionOptionBox);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin {
  AnimationController scaleController;
  bool cardFlipped = false;
  bool cardFlippedOut = false;
  @override
  void initState() {
    super.initState();
    widget.questionOptionBox.position = BoxPosition.Center;
    scaleController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 700), value: 1);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => startAnimations(context));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF7b49ec), Color(0xFF2d21a9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
            animation: scaleController,
            builder: (_, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(
                          (1 - scaleController.value) * math.pi / 2),
                      child: (this.cardFlipped)
                          ? AnimatedOpacity(
                              opacity: (!cardFlippedOut) ? 1 : 0,
                              duration: Duration(milliseconds: 700),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 700),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                width: (!cardFlippedOut) ? width * .4 : 0,
                                height: (!cardFlippedOut) ? height * .2 : 0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 40),
                                  child: CustomPaint(
                                    painter: RPSCustomPainter(),
                                  ),
                                ),
                              ),
                            )
                          : widget.questionOptionBox,
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  startAnimations(BuildContext context) {
    Future.delayed(Duration(milliseconds: 600), () {
      scaleController.reverse();
      Future.delayed(Duration(milliseconds: 1000), () {
        this.cardFlipped = true;
        scaleController.forward();
        Future.delayed(Duration(milliseconds: 1000), () {
          setState(() {
            this.cardFlippedOut = true;
          });
          Future.delayed(Duration(milliseconds: 1000), () {
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (_, __, ___) => Home(),
                transitionsBuilder: (context, animation1, animation2, child) =>
                    FadeTransition(
                      opacity: animation1,
                      child: child,
                    )));
          });
        });
      });
    });
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9819358, size.height * 0.2225800);
    path_0.lineTo(size.width * 0.8941955, size.height * 0.1348397);
    path_0.cubicTo(
        size.width * 0.8821647,
        size.height * 0.1227999,
        size.width * 0.8675330,
        size.height * 0.1167777,
        size.width * 0.8503343,
        size.height * 0.1167777);
    path_0.cubicTo(
        size.width * 0.8331198,
        size.height * 0.1167777,
        size.width * 0.8184881,
        size.height * 0.1227999,
        size.width * 0.8064574,
        size.height * 0.1348397);
    path_0.lineTo(size.width * 0.3832257, size.height * 0.5587109);
    path_0.lineTo(size.width * 0.1935471, size.height * 0.3683861);
    path_0.cubicTo(
        size.width * 0.1815028,
        size.height * 0.3563418,
        size.width * 0.1668802,
        size.height * 0.3503264,
        size.width * 0.1496815,
        size.height * 0.3503264);
    path_0.cubicTo(
        size.width * 0.1324715,
        size.height * 0.3503264,
        size.width * 0.1178488,
        size.height * 0.3563418,
        size.width * 0.1058045,
        size.height * 0.3683861);
    path_0.lineTo(size.width * 0.01806419, size.height * 0.4561287);
    path_0.cubicTo(size.width * 0.006019890, size.height * 0.4681707, 0,
        size.height * 0.4827979, 0, size.height * 0.5000056);
    path_0.cubicTo(
        0,
        size.height * 0.5171998,
        size.width * 0.006019890,
        size.height * 0.5318406,
        size.width * 0.01806419,
        size.height * 0.5438803);
    path_0.lineTo(size.width * 0.2516084, size.height * 0.7774200);
    path_0.lineTo(size.width * 0.3393555, size.height * 0.8651603);
    path_0.cubicTo(
        size.width * 0.3513930,
        size.height * 0.8772092,
        size.width * 0.3660202,
        size.height * 0.8832245,
        size.width * 0.3832257,
        size.height * 0.8832245);
    path_0.cubicTo(
        size.width * 0.4004244,
        size.height * 0.8832245,
        size.width * 0.4150515,
        size.height * 0.8771933,
        size.width * 0.4270958,
        size.height * 0.8651603);
    path_0.lineTo(size.width * 0.5148407, size.height * 0.7774200);
    path_0.lineTo(size.width * 0.9819358, size.height * 0.3103271);
    path_0.cubicTo(size.width * 0.9939688, size.height * 0.2982828, size.width,
        size.height * 0.2836579, size.width, size.height * 0.2664502);
    path_0.cubicTo(
        size.width * 1.000009,
        size.height * 0.2492515,
        size.width * 0.9939688,
        size.height * 0.2346243,
        size.width * 0.9819358,
        size.height * 0.2225800);
    path_0.close();

    Paint paint_0_fill = Paint()
      ..style = PaintingStyle.fill
      ..shader =
          ui.Gradient.linear(Offset(0, size.height), Offset(size.width, 0), [
        Color(0xFFC034EB),
        Color(0xFFE23535),
      ]);
    paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
