import 'package:flutter/material.dart';

void main() {
  usefulDotStar('Once in a blue moon');
  ruleChoiceOfCharacter('w');
  ruleChoiceOfCharacter('W');
  ruleChoiceOfCharacter('wW');
  ruleChoiceOfCharacterFirstMatch('wWe');
  ruleChoiceOfCharacterFirstMatch('we');
  ruleChoiceOfCharacterFirstMatch('wae');
  wHy('wHy');
  d_between_char_classes('adE');
  runApp(MyApp());
}

/// The subexpression .* is often useful to match characters that
/// surround the part of a string you are interested in. The following expression
/// .*blue.*
/// matches any string with the substring blue in it. The expression matches:
/// Once in a blue moon.
/// https://chortle.ccsu.edu/finiteautomata/Section08/sect08_3.html
void usefulDotStar(String str) {
  print('usefulDotStar(): str: $str');

  final regex = RegExp(r'.*blue.*');
  final matches = regex.allMatches(str);

  print('usefulDotStar(): matches.length: ${matches.length}');
  for (final match in matches) {
    print('usefulDotStar(): match.groupeCount: ${match.groupCount}');
    print('usefulDotStar(): match.start-end: ${match.start}-${match.end}');
    print('usefulDotStar(): match.group(0): ${match.group(0)}');
    match.groupCount > 0 ? print('usefulDotStar(): match.group(1): ${match.group(1)}') : null;
    match.groupCount > 1 ? print('usefulDotStar(): match.group(2): ${match.group(2)}') : null;
    match.groupCount > 2 ? print('usefulDotStar(): match.group(2): ${match.group(3)}') : null;
    match.groupCount > 3 ? print('usefulDotStar(): match.group(2): ${match.group(4)}') : null;
    match.groupCount > 4 ? print('usefulDotStar(): match.group(2): ${match.group(5)}') : null;
  }
}

void d_between_char_classes(String str) {
  print('d_between_char_classes(): str: $str');

  final regex = RegExp(r'[abc]d[EFG]');
  final matches = regex.allMatches(str);

  print('d_between_char_classes(): matches.length: ${matches.length}');
  for (final match in matches) {
    print('d_between_char_classes(): match.groupeCount: ${match.groupCount}');
    print('d_between_char_classes(): match.start-end: ${match.start}-${match.end}');
    print('d_between_char_classes(): match.group(0): ${match.group(0)}');
    match.groupCount > 0 ? print('d_between_char_classes(): match.group(1): ${match.group(1)}') : null;
    match.groupCount > 1 ? print('d_between_char_classes(): match.group(2): ${match.group(2)}') : null;
    match.groupCount > 2 ? print('d_between_char_classes(): match.group(2): ${match.group(3)}') : null;
    match.groupCount > 3 ? print('d_between_char_classes(): match.group(2): ${match.group(4)}') : null;
    match.groupCount > 4 ? print('d_between_char_classes(): match.group(2): ${match.group(5)}') : null;
  }
}

/// If you want to match one of several characters, place the
/// characters inside square brackets, []. Any number of characters can
/// be put inside the brackets, however the expression matches just one
/// character at a time. For example, [abc] matches just one character,
/// 'a' or 'b' or 'c'. Any number of bracketed groups can appear in a RE
/// https://chortle.ccsu.edu/finiteautomata/Section07/sect07_7.html
void ruleChoiceOfCharacter(String str) {
  print('ruleChoiceOfCharacter(): str: $str');

  final regex = RegExp(r'[wW]');
  final matches = regex.allMatches(str);

  print('ruleChoiceOfCharacter(): matches.length: ${matches.length}');
  for (final match in matches) {
    print('ruleChoiceOfCharacter(): match.groupeCount: ${match.groupCount}');
    print('ruleChoiceOfCharacter(): match.start-end: ${match.start}-${match.end}');
    print('ruleChoiceOfCharacter(): match.group(0): ${match.group(0)}');
    match.groupCount > 0 ? print('ruleChoiceOfCharacter(): match.group(1): ${match.group(1)}') : null;
    match.groupCount > 1 ? print('ruleChoiceOfCharacter(): match.group(2): ${match.group(2)}') : null;
    match.groupCount > 2 ? print('ruleChoiceOfCharacter(): match.group(2): ${match.group(3)}') : null;
    match.groupCount > 3 ? print('ruleChoiceOfCharacter(): match.group(2): ${match.group(4)}') : null;
    match.groupCount > 4 ? print('ruleChoiceOfCharacter(): match.group(2): ${match.group(5)}') : null;
  }
}

void ruleChoiceOfCharacterFirstMatch(String str) {
  print('ruleChoiceOfCharacterFirstMatch(): str: $str');

  final regex = RegExp(r'[wW]e');
  final match = regex.firstMatch(str);

  print('ruleChoiceOfCharacterFirstMatch(): match.group(0): ${match?.group(0)}');
  if (match != null) {
    match.groupCount > 0 ? print('ruleChoiceOfCharacterFirstMatch(): match.group(1): ${match.group(1)}') : null;
    match.groupCount > 1 ? print('ruleChoiceOfCharacterFirstMatch(): match.group(2): ${match.group(2)}') : null;
    match.groupCount > 2 ? print('ruleChoiceOfCharacterFirstMatch(): match.group(2): ${match.group(3)}') : null;
    match.groupCount > 3 ? print('ruleChoiceOfCharacterFirstMatch(): match.group(2): ${match.group(4)}') : null;
    match.groupCount > 4 ? print('ruleChoiceOfCharacterFirstMatch(): match.group(2): ${match.group(5)}') : null;
  } else {
    print('ruleChoiceOfCharacterFirstMatch(): No Matches');
  }
}

void wHy(String str) {
  print('wHy(): str: $str');

  final regex = RegExp(r'[wW][hH][yY]');
  final match = regex.firstMatch(str);

  print('wHy(): match.group(0): ${match?.group(0)}');
  if (match != null) {
    match.groupCount > 0 ? print('wHy(): match.group(1): ${match.group(1)}') : null;
    match.groupCount > 1 ? print('wHy(): match.group(2): ${match.group(2)}') : null;
    match.groupCount > 2 ? print('wHy(): match.group(2): ${match.group(3)}') : null;
    match.groupCount > 3 ? print('wHy(): match.group(2): ${match.group(4)}') : null;
    match.groupCount > 4 ? print('wHy(): match.group(2): ${match.group(5)}') : null;
  } else {
    print('wHy(): No Matches');
  }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('ccsu_examples'),
      ),
    );
  }
}
