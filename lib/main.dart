import 'package:flutter/material.dart';
import 'package:learning_animation/animations/fifth_animation.dart';
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            TabBar(
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.center,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.blue,
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              labelColor: Colors.white,
              controller: tabController,
              tabs: [
                Container(
                  height: 36, // Adjust this height as needed
                  alignment: Alignment.center,
                  child: const Text("First Page"),
                ),
                Container(
                  height: 36, // Adjust this height as needed
                  alignment: Alignment.center,
                  child: const Text("Second Page"),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  Column(
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
                  Column(
                    children: [
                      FourthAnimation(),
                      SizedBox(height: 200),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => FifthAnimation()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.blue,
                          ),
                          child: Text(
                            "Let's see the next animation",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
