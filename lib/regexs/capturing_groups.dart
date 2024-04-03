import 'package:flutter/material.dart';

/// Capturing groups:
/// Capturing groups can be used in lookahead and lookbehind assertions. Because
/// lookbehind assertions match their atoms backwards, the final match
/// corresponding to this group is the one that appears to the left end of the string.
/// However, the indices of the match groups still correspond to their relative
/// locations in the regex source.
/// https://www.rexegg.com/regex-capture.html
void main() {
  matchRepeatedWords('this is regex regex but know');
  testingBackRef('this is a bb');
  lookAheadCaptGroups('cab');
  lookBehindCaptGroups('abc');
  lookBehindCaptGroups('bac');
  lookBehindCharacterClassCaptGroups('dac');
  nestingInnerGroups('aacbbbcac');
  runApp(MyApp());
}

///Capturing groups can be nested, in which case the outer group is numbered
///first, then the inner group, because they are ordered by their opening
/// parentheses. If a nested group is repeated by a quantifier, then each
/// time the group matches, the subgroups' results are all overwritten,
/// sometimes with undefined.
void nestingInnerGroups(String str) {
  print('nestingInnerGroups(): str: $str');

  // final regex = RegExp(r'((a+)?)*', caseSensitive: true);
  final regex = RegExp(r'((a+)?(b+)?(c))', caseSensitive: true);
  final matches = regex.allMatches(str);

  print('nestingInnerGroups(): matches.count: ${matches.length}');

  for (final match in matches) {
    print('nestingInnerGroups(): match.groupCount: ${match.groupCount}');
    print('nestingInnerGroups(): match.groupNames: ${match.groupNames}');
    // print('nestingInnerGroups(): match.groups(): ${match.groups([0])}');
    // print('nestingInnerGroups(): match.groups(): ${match.groups([0, 1])}');
    print('nestingInnerGroups(): match.groups(): ${match.groups([0, 1, 2, 3, 4])}');
    print('nestingInnerGroups(): match.group(0): ${match.group(0)}');
    print('nestingInnerGroups(): match.group(1): ${match.group(1)}');
    print('nestingInnerGroups(): match.group(2): ${match.group(2)}');
    print('nestingInnerGroups(): match.group(3): ${match.group(3)}');
    print('nestingInnerGroups(): match.group(4): ${match.group(4)}');
  }
}

void lookBehindCharacterClassCaptGroups(String str) {
  print('lookBehindCharacterClassCaptGroups(): str: $str');

  final regex = RegExp(r'(?<=([ab]))c', caseSensitive: true);
  final matches = regex.allMatches(str);

  for (final match in matches) {
    print(
        'lookBehindCharacterClassCaptGroups(): match.groupCount: ${match.groupCount}');
    print(
        'lookBehindCharacterClassCaptGroups(): match.groupNames: ${match.groupNames}');
    // print('lookBehindCharacterClassCaptGroups(): match.groups: ${match.groups([0])}');
    print('lookBehindCharacterClassCaptGroups(): match.groups: ${match.groups([
          0,
          1
        ])}');
    print(
        'lookBehindCharacterClassCaptGroups(): match.group(0): ${match.group(0)}');
    print(
        'lookBehindCharacterClassCaptGroups(): match.group(1): ${match.group(1)}');
    // print('lookBehindCharacterClassCaptGroups(): match.group(2): ${match.group(2)}');
    // print('lookBehindCharacterClassCaptGroups(): match.group(3): ${match.group(3)}');
  }
}

void lookBehindCaptGroups(String str) {
  print('lookBehindCaptGroups(): str: $str');

  final regex = RegExp(r'(?<=(a|b))c', caseSensitive: true);
  final matches = regex.allMatches(str);

  for (final match in matches) {
    print('lookBehindCaptGroups(): match.groupCount: ${match.groupCount}');
    print('lookBehindCaptGroups(): match.groupNames: ${match.groupNames}');
    print('lookBehindCaptGroups(): match.groups: ${match.groups([0, 1])}');
    print('lookBehindCaptGroups(): match.group(0): ${match.group(0)}');
    print('lookBehindCaptGroups(): match.group(1): ${match.group(1)}');
    // print('lookBehindCaptGroups(): match.group(2): ${match.group(2)}');
    // print('lookBehindCaptGroups(): match.group(3): ${match.group(3)}');
  }
}

void lookAheadCaptGroups(String str) {
  print('lookAheadCaptGroups(): str: $str');

  final regex = RegExp(r'c(?=(ab))', caseSensitive: true);
  final matches = regex.allMatches(str);

  for (final match in matches) {
    print('lookAheadCaptGroups(): match.groupCount: ${match.groupCount}');
    print('lookAheadCaptGroups(): match.groupNames: ${match.groupNames}');
    print('lookAheadCaptGroups(): match.groups: ${match.groups([0, 1])}');
    print('lookAheadCaptGroups(): match.group(0): ${match.group(0)}');
    print('lookAheadCaptGroups(): match.group(1): ${match.group(1)}');
  }
}

void testingBackRef(String str) {
  print('testingBackRef(): str: $str');

  final regex = RegExp(r'(b)\1', caseSensitive: true);
  final matches = regex.allMatches(str);

  for (final match in matches) {
    print('testingBackRef(): match.groupNames: ${match.groupNames}');
    print('testingBackRef(): match.groups: ${match.groups}');
    print('testingBackRef(): match[0]: ${match[0]}');
    print('testingBackRef(): match[1]: ${match[1]}');
  }
}

List<RegExpMatch> matchRepeatedWords(String str) {
  print('matchRepeatedWords(): str: $str');

  final regex = RegExp(r'\b(\w+)\b\s+\1\b');
  final matches = regex.allMatches(str);

  for (final Match match in matches) {
    print('matchRepeatedWords(): match[0]: ${match[0]}');
    print('matchRepeatedWords(): match[1]: ${match[1]}');
  }
  return matches.toList();
}

void yMethod(String str) {
  print('lookAheadAfterMatch(): str: $str');

  final regex = RegExp(r'\d+(?= dollars)');
  final match = regex.matchAsPrefix(str);

  print('lookAheadAfterMatch(): match: ${match?[0]}');
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
