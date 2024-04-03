import 'package:flutter/material.dart';

void main() {
  replaceFirstMapped();
  matchFirstWord('Parse my string');
  findAllMatches('Parse my string');
  matchLastWord('A quick fox');
  matchAllWords('A quick fox');
  matchAllWordsAndSpaces('A quick fox');
  var theStr = fixMatchingAtStartOfString('''tey, ihe light-greon apple
      tangs on ihe greon traa''');
  theStr = fixMatchingAtEndOfString(theStr);
  theStr = matchAndReplaceAtBorderOfWords(theStr);
  fruitsStartWithA('''Apple, Watermelon, Orange, 
  Avocado, Strawberry''');
  fruitsDontStartWithA('''Apple, Watermelon, Orange, 
  Avocado, Strawberry''');
  wordEndingOnEd('housed coming stoned man');
  wordNotEndingOnEd('housed coming stoned man');

  runApp(MyApp());
}

List<RegExpMatch> wordNotEndingOnEd(String str){
  print('wordNotEndingOnEd(): str: $str');

  /// here I failed partially i jumped to 'lookaround approach and the article bellow.
  /// https://www.rexegg.com/regex-lookarounds.html
  // final regex = RegExp(r'\w+(?<!ed)');//output: house coming stone mad , notice missing 'd'
  final regex = RegExp(r'\b\w+(?<!ed)\b');//ok with 'lookaround' output: coming man
  final matches = regex.allMatches(str);
  for (final match in matches) {
    print('wordNotEndingOnEd(): match: ${match[0]}');
  }
  return matches.toList();
}

List<RegExpMatch> wordEndingOnEd(String str){
  print('wordEndingOnEd(): str: $str');

  final regex = RegExp(r'\b\w+ed\b');
  final matches = regex.allMatches(str);
  for (final match in matches) {
    print('wordEndingOnEd(): match: ${match[0]}');
  }
  return matches.toList();
}

List<RegExpMatch> fruitsStartWithA(String srt) {
  final regex = RegExp(r'\bA\w+\b');
  final fruits = regex.allMatches(srt);

  for (final fruit in fruits) {
    print('fruitsStartWithA(): fruit: ${fruit[0]}');
  }

  return fruits.toList();
}

List<RegExpMatch> fruitsDontStartWithA(String srt) {
  final regex = RegExp(r'\b[^A]\w+\b');
  final fruits = regex.allMatches(srt);

  for (final fruit in fruits) {
    print('fruitsDontStartWithA(): fruit: ${fruit[0]}');
  }

  return fruits.toList();
}

String matchAndReplaceAtBorderOfWords(String str) {
  print('matchAndReplaceAtBorderOfWords(): str: $str');

  final regex = RegExp(r'\bi');
  final result = str.replaceAll(regex, 't');

  print('matchAndReplaceAtBorderOfWords(): result: $result');
  return result;
}

String fixMatchingAtStartOfString(String str) {
  print('fixMatchingAtStartOfString(): str: $str');

  final regex = RegExp(r'^.');
  final match = regex.stringMatch(str);

  print('fixMatchingAtStartOfString(): matchString: $match');

  final changed = str.replaceFirst(regex, 'H');
  print('fixMatchingAtStartOfString(): changed: $changed');
  return changed;
}

String fixMatchingAtEndOfString(String str) {
  print('fixMatchingAtStartOfString(): str: $str');

  final regex = RegExp(r'aa$');
  final match = regex.stringMatch(str);

  print('fixMatchingAtEndOfString(): matchString: $match');

  final changed = str.replaceAll(regex, 'ee');
  print('fixMatchingAtEndOfString(): changed: $changed');

  return changed;
}

void matchAllWords(String str) {
  print('matchAllWords(): str: $str');
  RegExp exp = RegExp(r'(\b\w+\b)');

  Iterable<RegExpMatch>? matches = exp.allMatches(str);
  for (final match in matches)
    print('matchAllWords(): match[0]: ${match![1]}'); //
}

void matchAllWordsAndSpaces(String str) {
  print('matchAllWordsAndSpaces(): str: $str');
  RegExp exp = RegExp(r'(\b\w*\b)');

  Iterable<RegExpMatch>? matches = exp.allMatches(str);
  for (final match in matches)
    print('matchAllWordsAndSpaces(): match[0]: ${match![1]}'); //
}

void matchLastWord(String str) {
  print('matchLastWord(): str: $str');
  RegExp exp = RegExp(r'(\w+$)');

  RegExpMatch? match = exp.firstMatch(str);
  print('matchLastWord(): match[0]: ${match![0]}'); // "Parse"
}

void matchFirstWord(String str) {
  print('matchFirstWord(): str: $str');
  RegExp exp = RegExp(r'(\w+)');

  RegExpMatch? match = exp.firstMatch(str);
  print('matchFirstWord(): match[0]: ${match![0]}'); // "Parse"
}

void findAllMatches(String str) {
  print('findAllMatches(): str: $str');
  RegExp exp = RegExp(r'(\w+)');

  Iterable<RegExpMatch> matches = exp.allMatches(str);
  for (final match in matches) {
    print('findAllMatches(): match[0]: ${match[0]}');
  }
}

void replaceFirstMapped() {
  const string = 'Dart is fun';
  print(
      'replaceFirstMapped(): ${string.replaceFirstMapped('fun', (m) => 'open source')}'); // Dart is open source

  print(
      'replaceFirstMapped(): ${string.replaceFirstMapped(RegExp(r'\w(\w*)'), (m) => '<${m[0]}-${m[1]}>')}'); // <Dart-art> is fun
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
