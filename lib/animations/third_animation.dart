import 'package:flutter/material.dart';

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
