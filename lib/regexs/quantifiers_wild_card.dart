import 'package:flutter/material.dart';
import 'package:sbox1/regexs/regexp_dart_api.dart';

///
/// https://chortle.ccsu.edu/finiteautomata/Section08/sect08_2.html
void main() {
  ///Could you easily write a regular expression that matches a string of any five characters?
  /// Not easily, because you would need to match punctuation and other odd characters.
  /// It would be nice to have a way to match any character.
  /// The period (.) matches any one character except end-of-line. So the answer is '.....'
  // [';lkljkdfj;alk'].alllMatches(pattern: r'.....');

  /// any character except 'end of line'
  ['a', '.', '_', '-', ' ', '\n', '\r'].alllMatches(pattern: r'.{1}');
  ['bat', 'bbt', 'b\.t', 'bct', 'b t', 'b%t', 'b\rt', 'b\t'].alllMatches(pattern: r'b.t');
  ['baty', 'bbtx', 'bctq', 'b tx', 'b%tx', 'b\rt', 'b\t'].alllMatches(pattern: r'b.t.');

  /// Write a regular expression that matches any three character string that starts with M.
  ['mab', 'm\.a', 'm a', 'xab', 'm\na'].alllMatches(pattern: r'm..');

  /// The useful '.*':
  /// The subexpression .* is often useful to match characters that surround the
  /// part of a string you are interested in. The following expression
  /// .*blue.* matches any string with the substring blue in it.
  /// The expression matches:
  ['once in a blue moon'].alllMatches(pattern: r'.*blue.*');

  /// People often confuse "affect" and "effect". You might want to inspect a file to find such errors
  ['affect', 'effect', 'Affect', 'Effect'].alllMatches(pattern: '.*[AaEe]ffect');

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
