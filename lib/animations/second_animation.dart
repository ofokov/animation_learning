import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/enum.dart';

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

extension on VoidCallback {
  Future<void> delay(Duration duration) => Future.delayed(duration, this);
}

enum CircleSide {
  left,
  right,
}
