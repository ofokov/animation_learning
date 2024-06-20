import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Column(
          children: [
            SizedBox(height: 50),
            FirstAnimation(),
            SizedBox(height: 50),
            SecondAnimation(),
            SizedBox(height: 50),
            CircularProgressIndicator(),
            SizedBox(height: 50),
            ThirdAnimation(),
          ],
        ),
      ),
    );
  }
}

class FirstAnimation extends StatefulWidget {
  const FirstAnimation({super.key});

  @override
  State<FirstAnimation> createState() => _FirstAnimationState();
}

class _FirstAnimationState extends State<FirstAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Specify the duration here
    );
    _animation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_animationController);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateY(_animation.value),
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                  color: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SecondAnimation extends StatefulWidget {
  const SecondAnimation({super.key});

  @override
  State<SecondAnimation> createState() => _SecondAnimationState();
}

class _SecondAnimationState extends State<SecondAnimation>
    with TickerProviderStateMixin {
  late AnimationController _counterClockwiseRotationController;
  late Animation<double> _counterClockwiseRotationAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _counterClockwiseRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Specify the duration here
    );
    _counterClockwiseRotationAnimation = Tween<double>(begin: 0, end: -pi / 2)
        .animate(CurvedAnimation(
            parent: _counterClockwiseRotationController,
            curve: Curves.bounceOut));

    _flipController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.bounceOut));

    _counterClockwiseRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('================ FINISH');
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value, end: _flipAnimation.value + pi)
            .animate(CurvedAnimation(
                parent: _flipController, curve: Curves.bounceOut));
        _flipController
          ..reset()
          ..forward();
      }
    });
    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _counterClockwiseRotationAnimation = Tween<double>(
                begin: _counterClockwiseRotationAnimation.value,
                end: _counterClockwiseRotationAnimation.value - pi / 2)
            .animate(CurvedAnimation(
                parent: _counterClockwiseRotationController,
                curve: Curves.bounceOut));
        _counterClockwiseRotationController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    _counterClockwiseRotationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterClockwiseRotationController
      ..reset()
      ..forward.delay(const Duration(seconds: 1));

    return AnimatedBuilder(
        animation: _counterClockwiseRotationController,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateZ(_counterClockwiseRotationAnimation.value),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..rotateY(_flipAnimation.value),
                        alignment: Alignment.centerRight,
                        child: ClipPath(
                          clipper: HalfCircle(side: CircleSide.left),
                          child: Container(
                            color: Colors.blue,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      );
                    }),
                AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..rotateY(_flipAnimation.value),
                        alignment: Alignment.centerLeft,
                        child: ClipPath(
                          clipper: HalfCircle(side: CircleSide.right),
                          child: Container(
                            color: Colors.yellow,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      );
                    }),
              ],
            ),
          );
        });
  }
}

class ThirdAnimation extends StatefulWidget {
  const ThirdAnimation({super.key});

  @override
  State<ThirdAnimation> createState() => _ThirdAnimationState();
}

class _ThirdAnimationState extends State<ThirdAnimation> {
  bool isExpanded = false;
  Widget expandedIcon = const Icon(
    Icons.done,
    color: Colors.white,
  );
  Widget nonExpandedIcon = const Icon(
    Icons.download,
    color: Colors.white,
  );
  Widget expandedText =
      const Text('Done', style: TextStyle(color: Colors.white));
  Widget nonExpandedText = const Text('');

  double _calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = 80; // Default width for non-expanded state
    if (isExpanded) {
      final double textWidth =
          _calculateTextWidth('Done', const TextStyle(color: Colors.white));
      containerWidth = 50 +
          textWidth +
          16; // Add padding for the icon and between icon and text
    }
//
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: isExpanded ? Colors.green : Colors.blue,
        ),
        height: 50,
        width: containerWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            isExpanded ? expandedIcon : nonExpandedIcon,
            if (isExpanded) expandedText,
          ],
        ),
      ),
    );
  }
}

extension on VoidCallback {
  Future<void> delay(Duration duration) => Future.delayed(duration, this);
}

enum CircleSide {
  left,
  right,
}

extension ToPath on CircleSide {
  Path toPath(Size size) {
    Path path = Path();
    late Offset offset;
    late bool isClockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        isClockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        isClockwise = true;
        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.height / 2, size.width / 2),
      clockwise: isClockwise,
    );

    path.close();
    return path;
  }
}

class HalfCircle extends CustomClipper<Path> {
  final CircleSide side;

  HalfCircle({super.reclip, required this.side});
  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
