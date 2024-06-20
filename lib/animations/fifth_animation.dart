import 'package:flutter/material.dart';

class FifthAnimation extends StatefulWidget {
  const FifthAnimation({super.key});

  @override
  State<FifthAnimation> createState() => _FifthAnimationState();
}

class _FifthAnimationState extends State<FifthAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A2A2D),
      appBar: AppBar(
        backgroundColor: const Color(0xff141416),
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              size: 24,
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: const Text(
          'People',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(person: person),
                ),
              );
            },
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            leading: Hero(
              tag: person.name,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            title: Text(
              person.name,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              person.age.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

final List<Person> people = [
  Person(name: 'John', age: 14, emoji: '🙂'),
  Person(name: 'Azim', age: 14, emoji: '🙂'),
  Person(name: 'Christophen', age: 14, emoji: '🙂'),
];

class Person {
  final String name;
  final int age;
  final String emoji;

  Person({required this.name, required this.age, required this.emoji});
}

class DetailPage extends StatelessWidget {
  final Person person;
  const DetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A2A2D),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff141416),
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              size: 24,
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: Hero(
          flightShuttleBuilder:
              (flightContext, animation, direction, fromContext, toContext) {
            switch (direction) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(begin: 0, end: 1)
                          .chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: toContext.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(begin: 1, end: 0)
                          .chain(CurveTween(curve: Curves.easeIn)),
                    ),
                    child: fromContext.widget,
                  ),
                );
            }
          },
          tag: person.name,
          child: Text(
            person.emoji,
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20, width: double.infinity),
          Text(
            person.name,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20),
          Text(
            person.age.toString(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
          )
        ],
      ),
    );
  }
}
