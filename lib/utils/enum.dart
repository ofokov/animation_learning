import 'package:flutter/material.dart';

import '../animations/second_animation.dart';

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
