import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quiz_app/result_page.dart';
import 'package:quiz_app/widgets/cropped_text.dart';
import 'package:quiz_app/widgets/timer_widget.dart';

class QuizQuestionPage extends StatefulWidget {
  QuizQuestionPage({Key key}) : super(key: key);

  @override
  _QuizQuestionPageState createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage>
    with TickerProviderStateMixin {
  bool animations = false;
  List<BoxAnimation> boxAnimations = [];
  AnimationController outLineTimer;
  AnimationController maintLineTimer;
  bool timerCountDown = false;
  bool timerCountDownLoop = true;
  bool timerCountDownStop = false;
  int timer = 7;

  @override
  void dispose() {
    outLineTimer.dispose();
    maintLineTimer.dispose();
    boxAnimations[0].controller.dispose();
    boxAnimations[1].controller.dispose();
    boxAnimations[2].controller.dispose();
    boxAnimations[3].controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    boxAnimations = [
      new BoxAnimation(AnimationController(
        value: .9,
        duration: const Duration(seconds: 4),
        vsync: this,
      )),
      new BoxAnimation(AnimationController(
        value: .9,
        duration: const Duration(seconds: 4),
        vsync: this,
      )),
      new BoxAnimation(
        AnimationController(
          value: .9,
          duration: const Duration(seconds: 4),
          vsync: this,
        ),
      ),
      new BoxAnimation(
        AnimationController(
          value: .9,
          duration: const Duration(seconds: 4),
          vsync: this,
        ),
      )
    ];

    outLineTimer = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      value: 0,
    );
    maintLineTimer = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      value: 0,
    );

    WidgetsBinding.instance
        .addPostFrameCallback((_) => startAnimations(context));
  }

  void startAnimations(_) {
    setState(() {
      this.animations = true;
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          boxAnimations[0].controller.forward();
          boxAnimations[0].isExpanded = true;
          boxAnimations[0].opacity = true;
          boxAnimations[0].moved = true;
        });
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            boxAnimations[1].controller.forward();
            boxAnimations[1].isExpanded = true;
            boxAnimations[1].opacity = true;
            boxAnimations[1].moved = true;
            boxAnimations[0].content = true;
          });
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              boxAnimations[2].controller.forward();
              boxAnimations[2].isExpanded = true;
              boxAnimations[2].opacity = true;
              boxAnimations[2].moved = true;
              boxAnimations[1].content = true;
            });
            Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                outLineTimer.forward();
                timerCountDown = true;
                boxAnimations[3].controller.forward();
                boxAnimations[3].isExpanded = true;
                boxAnimations[3].opacity = true;
                boxAnimations[3].moved = true;
                boxAnimations[2].content = true;
              });
              Future.delayed(Duration(milliseconds: 500), () {
                setState(() {
                  maintLineTimer.forward();

                  boxAnimations[3].content = true;
                });
                Future.delayed(Duration(milliseconds: 550), () {
                  setState(() {
                    maintLineTimer.duration = Duration(seconds: 5);
                    maintLineTimer.reverse();
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF7b49ec), Color(0xFF2d21a9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Scaffold(
          body: Stack(
            children: [
              AnimatedPositioned(
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 500),
                top: animations ? width * .01 : width * -1,
                width: width,
                child: AnimatedOpacity(
                  opacity: animations ? 1 : .2,
                  duration: Duration(milliseconds: 500),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'Oh my Quiz',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 500),
                top: animations ? width * .15 : width * .8,
                width: width,
                child: AnimatedOpacity(
                  opacity: animations ? 1 : .2,
                  duration: Duration(milliseconds: 500),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'What is the fastest animal in the world?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    BeautifulTimer(
                      animationController: outLineTimer,
                      animationController2: maintLineTimer,
                    ),
                    Positioned(
                        width: width,
                        height: 200,
                        top: (height * .25) / 2.8,
                        child: AnimatedOpacity(
                            opacity: (timerCountDown) ? 1 : 0,
                            duration: Duration(milliseconds: 300),
                            child: CroppedText(
                              '0:0$timer',
                              callback: () {
                                setState(() {
                                  timer--;
                                  if (timer < 2) {
                                    setState(() {
                                      timerCountDownStop = true;
                                      timerCountDownLoop = false;
                                    });
                                  }
                                });
                              },
                              stop: timerCountDownStop,
                              loop: timerCountDownLoop,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            )))
                  ],
                ),
                top: width * .4,
                width: width,
                height: height * .25,
              ),
              Positioned(
                width: width,
                height: height * .48,
                top: width * .8,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                          top: 0,
                          left: 0,
                          width: width * .4,
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeIn,
                          height: height * .2,
                          child: QuestionOptionBox(
                            animation: boxAnimations[0],
                            position: BoxPosition.TopLeft,
                            option: 'Turtle',
                            letterOption: 'A',
                            letterOptionColor: Color(0xFFfac23b),
                            hero: 'q1',
                          )),
                      AnimatedPositioned(
                          top: 0,
                          right: 0,
                          width: width * .4,
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeIn,
                          height: height * .2,
                          child: QuestionOptionBox(
                            animation: boxAnimations[1],
                            position: BoxPosition.TopRight,
                            option: 'Cheetah',
                            letterOption: 'B',
                            letterOptionColor: Color(0xFF57d3fc),
                            hero: 'q2',
                          )),
                      AnimatedPositioned(
                          bottom: 0,
                          left: 0,
                          width: width * .4,
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeIn,
                          height: height * .2,
                          child: QuestionOptionBox(
                            animation: boxAnimations[2],
                            position: BoxPosition.BottomLeft,
                            option: 'Rabbit',
                            letterOption: 'C',
                            letterOptionColor: Color(0xFFa3ea67),
                            hero: 'q3',
                          )),
                      AnimatedPositioned(
                          bottom: 0,
                          right: 0,
                          width: width * .4,
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeIn,
                          height: height * .2,
                          child: QuestionOptionBox(
                            animation: boxAnimations[3],
                            position: BoxPosition.BottomRight,
                            option: 'Leopard',
                            letterOption: 'D',
                            letterOptionColor: Color(0xFFfe7069),
                            hero: 'q4',
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

enum BoxPosition { TopLeft, TopRight, BottomRight, BottomLeft, Center }

class QuestionOptionBox extends StatefulWidget {
  BoxPosition position;
  double scaleValue = 1;
  final BoxAnimation animation;
  final String option;
  final String letterOption;
  final Color letterOptionColor;
  final String hero;
  QuestionOptionBox({
    Key key,
    @required this.animation,
    @required this.position,
    @required this.option,
    @required this.letterOption,
    @required this.letterOptionColor,
    this.hero,
  }) : super(key: key);

  @override
  _QuestionOptionBoxState createState() => _QuestionOptionBoxState();
}

class _QuestionOptionBoxState extends State<QuestionOptionBox> {
  bool bounce = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Hero(
      tag: widget.hero,
      child: RotationTransition(
        turns: widget.animation.controller,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 600),
          opacity: widget.animation.opacity ? 1 : 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    bounce = true;
                  });
                  Future.delayed(Duration(milliseconds: 200), () {
                    setState(() {
                      bounce = false;
                    });
                    Future.delayed(Duration(milliseconds: 600), () {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 700),
                          pageBuilder: (_, __, ___) => ResultPage(widget),
                          transitionsBuilder:
                              (context, animation1, animation2, child) =>
                                  FadeTransition(
                                    opacity: animation1,
                                    child: child,
                                  )));
                    });
                  });
                },
                child: AnimatedContainer(
                  curve: (!bounce) ? Curves.decelerate : Curves.ease,
                  duration: Duration(milliseconds: 600),
                  alignment: Alignment.center,
                  width: (widget.animation.isExpanded)
                      ? (bounce)
                          ? width * .37
                          : width * .4
                      : 0,
                  height: (widget.animation.isExpanded)
                      ? (bounce)
                          ? height * .17
                          : height * .2
                      : 0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: AnimatedOpacity(
                    opacity: 1,
                    duration: Duration(milliseconds: 300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          maxRadius: widget.animation.content ? null : 0,
                          backgroundColor: widget.letterOptionColor,
                          child: Text(
                            widget.letterOption,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 26,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          child: AnimatedDefaultTextStyle(
                            duration: Duration(seconds: 1),
                            curve: Curves.bounceOut,
                            style: TextStyle(
                                fontSize: widget.animation.content ? 30 : 0),
                            child: Text(
                              widget.option,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BoxAnimation {
  final isRotated = false;
  AnimationController controller;
  AnimationController scaleAnimationController;
  CurvedAnimation rotateAnimation;
  bool isExpanded = false;
  bool opacity = false;
  bool moved = false;
  bool content = false;
  BoxAnimation(this.controller) {
    rotateAnimation = CurvedAnimation(
      parent: this.controller,
      curve: Curves.ease,
    );
  }
}
