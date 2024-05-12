import 'package:flutter/material.dart';
import 'package:sbox1/regexs/regexp_dart_api.dart';

/// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Regular_expressions/Character_class
void main() {
  ['a', ' ', 'b', '0'].hasMatch(pattern: '[^a]');
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
