import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// https://www.youtube.com/watch?v=8T7hetwuwY4
///
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(primaryColor: Colors.blue),
      home: OnTheBench(),
    );
  }
}

class OnTheBench extends StatelessWidget {
  const OnTheBench({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Scrolls together'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (final String item in items)
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(
                        color: Colors.white30,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      item,
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
            Row(
              children: [
                for (int i = items.length - 1; i > -1; i--)
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(
                        color: Colors.white30,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      items[i],
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final items = <String>[
  'Barcelona',
  'Madrid',
  'Paris',
  'Nice',
  'Havana',
  'Pinar del Rio',
  'Bayamo',
  'Antibes',
  'Saint Laurent du bar',
];
