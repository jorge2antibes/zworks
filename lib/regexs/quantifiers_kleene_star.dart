import 'package:flutter/material.dart';
import 'package:sbox1/regexs/regexp_dart_api.dart';

void main() {
  // ['a', 'b', 'ba', 'baaaa', 'ZERO or more a'].firstMatch(pattern: r'a*');
  // ['b', 'ba', 'baaaa'].hasMatch(pattern: r'ba*');
  // ['', 'a', 'ab', 'aaa', 'ababbb', 'bbb'].hasMatch(pattern: r'[ab]*');
  // ['', '   ', 'a', 'ou\$aaa', 'ababbb', 'b7b', '77'].hasMatch(pattern: r'[^0-9]*');
  // ['   ', '   b', 'b', 'a', 'aaa', 'ab', 'abbb', 'bbb'].hasMatch(pattern: r'a*b*');
  // ['frog', 'fog', 'rog', 'og', 'rfrog'].hasMatch(pattern: r'[fr]*og');
  // ['008', '01234', '1234', '10012', '07890'].hasMatch(pattern: r'[0]*[1-9]*');
  ['dwoo', '', 'noon', 'ohm', 'aeiou', 'zp'].firstMatch( pattern: r'[^aeiou]*[aeiou]*');
  // ['08','008',	'1234',	'10012',	'07890'].alllMatches(pattern: r'([0])*([1-9])*');
  // 'Dash is a bird'.alllMatches(pattern: r'(\w+)');
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
