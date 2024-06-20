import 'package:flutter/material.dart';
import 'package:learning_animation/animations/fourth_animation.dart';

import 'animations/first_animation.dart';
import 'animations/second_animation.dart';
import 'animations/third_animation.dart';

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
        backgroundColor: Colors.grey,
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
            SizedBox(height: 50),
            FourthAnimation(),
          ],
        ),
      ),
    );
  }
}
