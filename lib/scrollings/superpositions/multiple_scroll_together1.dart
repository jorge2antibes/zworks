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

class OnTheBench extends StatefulWidget {
  const OnTheBench({super.key});

  @override
  State<OnTheBench> createState() => _OnTheBenchState();
}

class _OnTheBenchState extends State<OnTheBench> {
  late final ScrollController aboveScrollController;
  late final ScrollController belowScrollController;

  @override
  void initState() {
    super.initState();
    aboveScrollController = ScrollController()..addListener(listenOnAbove);
    /// this line will create an infinite loop feeding back each other's scroll view.
    belowScrollController = ScrollController()..addListener(listenOnBellow);
  }

  void listenOnAbove() {
    belowScrollController.animateTo(aboveScrollController.offset, duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  void listenOnBellow() {
    aboveScrollController.animateTo(belowScrollController.offset, duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  void dispose() {
    aboveScrollController.dispose();
    belowScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Scrolls together'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            controller: aboveScrollController,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            child: Row(
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
          ),
          SingleChildScrollView(
            reverse: true,
            controller: belowScrollController,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            child: Row(
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
          ),
        ],
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
