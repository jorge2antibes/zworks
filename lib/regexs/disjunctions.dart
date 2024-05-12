import 'package:flutter/material.dart';
import 'package:sbox1/regexs/regexp_dart_api.dart';

/// Disjunction: OR
/// Sometimes you wish to match one string OR another. Use the
/// disjunction operator | for this. The disjunction operator has low
/// precidence, so that the complete subexpression on the left or the
/// complete subexpression on the right is matched.
void main() {
  ['cat', 'dog', 'catdog'].hasMatch(pattern: r'cat|dog');
  ['cat', 'dog', 'catdog'].firstMatch(pattern: r'((cat)|(dog))');
  ['cat', 'dog', 'catdog', 'ca', 'do', 'cado'].alllMatches(pattern: r'((cat)|(dog))');
  ['ca', 'do', 'cat', 'dog', 'catt', 'dogg', 'catdog'].alllMatches(pattern: r'cat*|dog*');
  ['cat', 'dog', 'catt', 'dogg', 'catdog'].alllMatches(pattern: r'(cat|dog)*');
  ['a', 'b', 'ab','aaa', 'bbb', 'aaabbb'].firstMatch(pattern: r'a*|b*');
  ['a', 'b', 'ab','aaa', 'bbb', 'aaabbb'].alllMatches(pattern: r'a*|b*');
  ['color', 'colour', 'collour', '', '', ].hasMatch(pattern: r'color|colour');
  //more efficient
  ['color', 'colour', 'collour', '', '', ].hasMatch(pattern: r'colou?r');
  ['a','1', '4', 'd', 'a1', '45', 'ab23', 'cd36', '44ee', 'aaa', 'abcd' , 'abcd4' ].hasMatch(pattern: r'[abc]+[123]*|[def]*[456]+');
  ['a','1', '4', 'd', 'a1', '45', 'ab23', 'cd36', '44ee', 'aaa', 'abcd' , 'abcd4' ].firstMatch(pattern: r'[abc]+[123]*|[def]*[456]+');
  ['a','1', '4', 'd', 'a1', '45', 'ab23', 'cd36', '44ee', 'aaa', 'abcd' , 'abcd4' ].alllMatches(pattern: r'[abc]+[123]*|[def]*[456]+');
  ['a', 'ab', 'aa', 'b', 'bbb', '', ' ', ].alllMatches(pattern: r'a*|b*');
  ['a', 'aa', 'c', 'x', '', ' ', ].alllMatches(pattern: r'a+|[^a]*');
  ['142', '834.90', '89.0', '0.89', '', ' ', ].alllMatches(pattern: r'[0-9]+|[0-9]+\.[0-9]+');
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
