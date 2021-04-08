import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_question.dart';
import 'package:quiz_app/widgets/cropped_text.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int animation = 0;
  bool readyAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => startReadyAnimation(context));
  }

  void startReadyAnimation(_) {
    setState(() {
      this.readyAnimation = true;
    });
  }

  int number = 3;
  bool loop = true;

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
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              AnimatedPositioned(
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 500),
                top: readyAnimation ? width * .4 : 0,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: readyAnimation ? 1 : 0,
                  child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 500),
                      style: TextStyle(fontSize: readyAnimation ? 30 : 60),
                      child: Text(
                        'Get Ready!',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                ),
              ),
              Positioned(
                top: height * .4,
                height: 200,
                width: width,
                child: CroppedText(
                  number.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                  loop: loop,
                  stop: false,
                  callback: () {
                    setState(() {
                      if (number > 2) {
                        number--;
                      } else {
                        number--;
                        setState(() {
                          loop = false;
                        });
                      }
                      if (number == 0) {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => QuizQuestionPage(),
                            transitionsBuilder:
                                (context, animation1, animation2, child) =>
                                    FadeTransition(
                                      opacity: animation1,
                                      child: child,
                                    )));
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
