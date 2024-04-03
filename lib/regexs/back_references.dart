import 'dart:convert';

import 'package:flutter/material.dart';

/// Capturing groups
/// https://www.rexegg.com/regex-capture.html
void main() {
  matchRepeatedWords('this is regex regex but know');
  testingBackRef('this is a bb');
  parseTitleByPairingQuotes('title="foo"');
  parseTitleByPairingQuotes("title='foo' lang='en'");
  parseTitleByPairingQuotes('title="Named capturing groups\' advantages"');
  abOrCd('cdefab');
  bOverridesA('abc');
  matchGroupDocumentation();
  matchDocumentation();
  runApp(MyApp());
}

/// A regular expression match.
///
/// Regular expression matches are [Match]es. They also include the ability
/// to retrieve the names for any named capture groups and to retrieve
/// matches for named capture groups by name instead of by their index.
///
/// Example:
/// ```dart
void matchDocumentation() {
  const pattern =
      r'^\[(?<Time>\s*((?<hour>\d+)):((?<minute>\d+))\.((?<second>\d+)))\]\s(?<Message>\s*(.*)$)';
      // r'\s(?<Message>\s*(.*)$)';

  final regExp = RegExp(
    pattern,
    multiLine: true,
  );

  const multilineText = '[00:13.37] This is a first message.\n'
      '[01:15.57] This is a second message.\n'
      '[00:00.00] This is a third message.\n';

  RegExpMatch regExpMatch = regExp.firstMatch(multilineText)!;
  print(
      'matchDocumentation(): multilineText: $multilineText'); // hour-minute-second-Time-Message.
  print(
      'matchDocumentation(): groupNames.join(): ${regExpMatch.groupNames.join('-')}'); // hour-minute-second-Time-Message.
  final time = regExpMatch.namedGroup('Time'); // 00:13.37
  final hour = regExpMatch.namedGroup('hour'); // 00
  final minute = regExpMatch.namedGroup('minute'); // 13
  final second = regExpMatch.namedGroup('second'); // 37
  final message =
      regExpMatch.namedGroup('Message'); // This is the first message.
  // final date = regExpMatch.namedGroup('Date'); // Undefined `Date`, throws.
  // print('matchDocumentation(): date: $date');
  print('matchDocumentation(): time: $time');
  print('matchDocumentation(): hour: $hour');
  print('matchDocumentation(): minute: $minute');
  print('matchDocumentation(): second: $second');

  Iterable<RegExpMatch> matches = regExp.allMatches(multilineText);
  for (final m in matches) {
    print(
        'matchDocumentation(): on allMatches(): time: ${m.namedGroup('Time')}');
    print(
        'matchDocumentation(): on allMatches(): hour: ${m.namedGroup('hour')}');
    print(
        'matchDocumentation(): on allMatches(): minute: ${m.namedGroup('minute')}');
    print(
        'matchDocumentation(): on allMatches(): second: ${m.namedGroup('second')}');
    print(
        'matchDocumentation(): on allMatches(): message: ${m.namedGroup('Message')}');
// 00:13.37
// This is the first message.
// 01:15.57
// This is the second message.
  }
}

void matchGroupDocumentation() {
  final string = '[00:13.37] This is a chat message.';
  final regExp = RegExp(r'^\[\s*(\d+):(\d+)\.(\d+)\]\s*(.*)$');
  final match = regExp.firstMatch(string)!;
  final message = match[0]; // '[00:13.37] This is a chat message.'
  final hours = match[1]; // '00'
  final minutes = match[2]; // '13'
  final seconds = match[3]; // '37'
  final text = match[4]; // 'This is a chat message.'
  print('matchGroupDocumentation: message: $message');
  print('matchGroupDocumentation: hours: $hours');
  print('matchGroupDocumentation: minutes: $minutes');
  print('matchGroupDocumentation: seconds: $seconds');
  print('matchGroupDocumentation: text: $text');
}

void bOverridesA(String str) {
  print('bOverridesA(): str: $str');

  final regex = RegExp(r'([ab])+');
  final matches = regex.allMatches(str);
  for (final match in matches) {
    print('bOverridesA(): match.group(0): ${match.group(0)}');
    print('bOverridesA(): match.group(1): ${match.group(1)}');
  }
}

void abOrCd(String str) {
  print('abOrCd(): str: $str');

  final regex = RegExp(r'(ab)|(cd)');
  final matches = regex.allMatches(str);
  for (final match in matches) {
    print('abOrCd(): match.group(0): ${match.group(0)}');
    print('abOrCd(): match.group(1): ${match.group(1)}');
    print('abOrCd(): match.group(2): ${match.group(2)}');
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

void parseTitleByPairingQuotes(String str) {
  print('parseTitleByPairingQuotes(): str: $str');

  final regex = RegExp(r'''title=(["'])(.*?)\1''');
  final matches = regex.allMatches(str);
  for (final match in matches) {
    print('parseTitleByPairingQuotes(): match.groupCount: ${match.groupCount}');
    print('parseTitleByPairingQuotes(): match.groupNames: ${match.groupNames}');
    print('parseTitleByPairingQuotes(): match.group(0): ${match.group(0)}');
    print('parseTitleByPairingQuotes(): match.group(1): ${match.group(1)}');
    print('parseTitleByPairingQuotes(): match.group(2): ${match.group(2)}');
    print('parseTitleByPairingQuotes(): match[0]: ${match[0]}');
    print('parseTitleByPairingQuotes(): match[1]: ${match[1]}');
    print('parseTitleByPairingQuotes(): match[2]: ${match[2]}');
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back references',
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
