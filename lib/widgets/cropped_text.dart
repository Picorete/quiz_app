import 'package:flutter/material.dart';

class CroppedText extends StatefulWidget {
  final String text;
  TextStyle style = TextStyle();

  /// Callback when the animation finish, if [loop] is true the callback will trigger every time animations ends
  Function callback = () {};

  /// Set true to loop the animation, default [loop] = false
  bool loop = false;

  /// Stop in the last animation
  bool stop = false;
  Duration duration;

  CroppedText(this.text,
      {duration, this.callback, this.style, this.loop, this.stop})
      : this.duration =
            (duration != null) ? duration : Duration(milliseconds: 150);

  @override
  _CroppedTextState createState() => _CroppedTextState();
}

class _CroppedTextState extends State<CroppedText> {
  List<List<bool>> animations = [
    [true, false],
    [true, false],
    [true, false]
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => startAnimation(context));
  }

  @override
  void dispose() {
    super.dispose();
    widget.loop = false;
  }

  startAnimation(BuildContext context) {
    setState(() {
      animations[0][0] = false;
    });
    Future.delayed(Duration(milliseconds: 130), () {
      setState(() {
        animations[1][0] = false;
      });
      Future.delayed(Duration(milliseconds: 110), () {
        setState(() {
          animations[2][0] = false;
        });
        Future.delayed(Duration(milliseconds: 450), () {
          if (widget.stop == false) {
            setState(() {
              animations[0][1] = true;
            });
            Future.delayed(Duration(milliseconds: 130), () {
              setState(() {
                animations[1][1] = true;
              });
              Future.delayed(Duration(milliseconds: 110), () {
                setState(() {
                  animations[2][1] = true;
                });
                Future.delayed(Duration(milliseconds: 140), () {
                  setState(() {
                    animations[0][0] = true;
                    animations[1][0] = true;
                    animations[2][0] = true;
                    animations[0][1] = false;
                    animations[1][1] = false;
                    animations[2][1] = false;
                  });
                  Future.delayed(Duration(milliseconds: 100), () {
                    setState(() {
                      if (widget.callback != null) {
                        widget.callback();
                      }
                      if (widget.loop == true) {
                        this.startAnimation(context);
                      }
                    });
                  });
                });
              });
            });
          } else {
            if (widget.callback != null) {
              widget.callback();
            }
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: AnimatedPositioned(
            curve: Curves.decelerate,
            right: animations[0][0] ? 0 : 50,
            left: animations[0][1] ? 0 : 50,
            duration: widget.duration,
            child: AnimatedOpacity(
              opacity: animations[0][0] ? 0 : (animations[0][1] ? 0 : 1),
              duration: widget.duration,
              child: Center(
                child: ClipPath(
                  clipper: CustomClipperr(1),
                  child: Container(
                    child: Stack(
                      children: [
                        Center(
                            child: Text(
                          widget.text,
                          style: widget.style,
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          child: AnimatedPositioned(
            curve: Curves.decelerate,
            right: animations[1][0] ? 0 : 50,
            left: animations[1][1] ? 0 : 50,
            duration: widget.duration,
            child: AnimatedOpacity(
              opacity: animations[1][0] ? 0 : (animations[1][1] ? 0 : 1),
              duration: widget.duration,
              child: Center(
                child: ClipPath(
                  clipper: CustomClipperr(2),
                  child: Container(
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            widget.text,
                            style: widget.style,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          child: AnimatedPositioned(
            curve: Curves.decelerate,
            right: animations[2][0] ? 0 : 50,
            left: animations[2][1] ? 0 : 50,
            duration: widget.duration,
            child: AnimatedOpacity(
              opacity: animations[2][0] ? 0 : (animations[2][1] ? 0 : 1),
              duration: widget.duration,
              child: Center(
                child: ClipPath(
                  clipper: CustomClipperr(3),
                  child: Container(
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            widget.text,
                            style: widget.style,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomClipperr extends CustomClipper<Path> {
  final int split;

  CustomClipperr(this.split);
  @override
  Path getClip(Size size) {
    final Path path = new Path();

    if (split == 1) {
      path.lineTo(0, size.height / 3);
      path.lineTo(size.width, size.height / 3);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else if (split == 2) {
      path.moveTo(0, (size.height / 3) - 1);
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(size.width, (size.height / 3) - 1);
      path.lineTo(0, (size.height / 3) - 1);
    } else if (split == 3) {
      path.moveTo(0, size.height / 2);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height / 2);
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
