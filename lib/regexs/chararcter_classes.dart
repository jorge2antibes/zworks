import 'package:flutter/material.dart';
import 'regexp_dart_api.dart';

/// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Regular_expressions/Character_class
void main() {

  // ['0', '00', '01', '11', '10', '1', '21' ].firstMatch(pattern: r'[0-1][1-3]');
  // ['why', '___', '   ', 'why bc'].firstMatch(pattern: r'[wW][hH][yY]\s{1,}');
  // ['a', 'b', 'c', 'd', 'f', '-', '_', 'why bc'].firstMatch(pattern: r'[a-d]');
  // ['chapter 0', 'chapter 1', 'chapter 22' ].hasMatch(pattern: r'[Cc]hapter [1-9]');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strings',
      theme: ThemeData.dark(),
      home: StringsHolder(),
    );
  }
}

class StringsHolder extends StatelessWidget {
  const StringsHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
