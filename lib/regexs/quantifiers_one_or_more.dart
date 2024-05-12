import 'package:flutter/material.dart';
import 'package:sbox1/regexs/regexp_dart_api.dart';


/// The character + in a regular expression means "match the preceding character one or more times".
/// For example A+ matches one or more of character A.
//
// The plus character, used in a regular expression, is called a Kleene plus
/// https://chortle.ccsu.edu/finiteautomata/Section07/sect07_19.html
void main() {
  // ['Beed', 'ZZeed', 'ZZeebd', 'Dud', 'greed', 'geed', 'Greed', 'Grd', 'Gd', 'Gadd'].alllMatches(pattern: r'[A-Z]+[aeiou]+[bd]?');
  /// Since it is greedy, the first X+ matches as much as it can without blocking the entire RE from matching, which is XXX .
  /// The final 'X' is matched by last part of the RE.
  /// Bug Alert! It is tempting to think that each half of X+X+ matches the same number of chracters X. But this is not so.
  ['xxxx'].alllMatches(pattern: r'x+x+');
  /// To turn a greedy quantifier into a reluctant type, I must add question mark (?) rigth after
  ['xxxx'].alllMatches(pattern: r'x+?x+?');
  ['xxxx'].alllMatches(pattern: r'xx+');
  ['xxxx'].alllMatches(pattern: r'(x)(x)+');
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
