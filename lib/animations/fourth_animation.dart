import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart'
    hide Colors; // Ensure Colors is not conflicting with vector_math_64

class FourthAnimation extends StatefulWidget {
  const FourthAnimation({Key? key}) : super(key: key);

  @override
  State<FourthAnimation> createState() => _FourthAnimationState();
}

class _FourthAnimationState extends State<FourthAnimation>
    with TickerProviderStateMixin {
  final double widthAndHeight = 100;
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: widthAndHeight,
          width: double.infinity,
        ),
        AnimatedBuilder(
          animation: Listenable.merge([
            _xController,
            _yController,
            _zController,
          ]),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_animation.evaluate(_xController))
                ..rotateY(_animation.evaluate(_yController))
                ..rotateZ(_animation.evaluate(_zController)),
              child: Stack(
                children: [
                  /// back
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..translate(Vector3(0, 0, -widthAndHeight)),
                    child: Container(
                      color: Colors.green,
                      width: widthAndHeight,
                      height: widthAndHeight,
                    ),
                  ),

                  /// left side
                  Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()..rotateY(pi / 2.0),
                    child: Container(
                      color: Colors.red,
                      width: widthAndHeight,
                      height: widthAndHeight,
                    ),
                  ),

                  /// right side
                  Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()..rotateY(-pi / 2.0),
                    child: Container(
                      color: Colors.orange,
                      width: widthAndHeight,
                      height: widthAndHeight,
                    ),
                  ),

                  /// front
                  Container(
                    color: Colors.blue,
                    width: widthAndHeight,
                    height: widthAndHeight,
                  ),

                  /// top side
                  Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()..rotateX(-pi / 2.0),
                    child: Container(
                      color: Colors.white,
                      width: widthAndHeight,
                      height: widthAndHeight,
                    ),
                  ),

                  /// bottom side
                  Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()..rotateX(pi / 2.0),
                    child: Container(
                      color: Colors.yellow,
                      width: widthAndHeight,
                      height: widthAndHeight,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
