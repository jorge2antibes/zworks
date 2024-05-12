import 'package:flutter/material.dart';

void main() {
  dotStarStringDotStar(['blue', 'xblue', ' blue', 'x blue', 'bluey', 'blue y', 'xbluey']);
  dotStringDotStar(['blue', 'xblue', ' blue', 'x blue', 'bluey', 'blue y', 'xbluey']);
  dotStringDot(['blue', 'xblue', ' blue', 'x blue', 'bluey', 'blue y', 'xbluey']);
  runApp(MyApp());
}

/// The subexpression .* is often useful to match characters that
/// surround the part of a string you are interested in. The following expression
/// .*blue.*
/// matches any string with the substring blue in it. The expression matches:
/// Once in a blue moon.
/// https://chortle.ccsu.edu/finiteautomata/Section08/sect08_3.html
void dotStarStringDotStar(List<String> strings) {
  print('///// dotStarStringDotStar(): strings: $strings');

  final regex = RegExp(r'.*blue.*');
  print('dotStarStringDotStar(): regex: $regex');

  strings.forEach(
    (input) {
      final match = regex.firstMatch(input);

      if (match != null) {
        print('dotStarStringDotStar(): match.input: ${match.input}');
        print('dotStarStringDotStar(): match.groupeCount: ${match.groupCount}');
        print('dotStarStringDotStar(): match.start-end: ${match.start}-${match.end}');
        print('dotStarStringDotStar(): match.group(0): ${match.group(0)}');
        match.groupCount > 0 ? print('dotStarStringDotStar(): match.group(1): ${match.group(1)}') : null;
        match.groupCount > 1 ? print('dotStarStringDotStar(): match.group(2): ${match.group(2)}') : null;
        match.groupCount > 2 ? print('dotStarStringDotStar(): match.group(2): ${match.group(3)}') : null;
        match.groupCount > 3 ? print('dotStarStringDotStar(): match.group(2): ${match.group(4)}') : null;
        match.groupCount > 4 ? print('dotStarStringDotStar(): match.group(2): ${match.group(5)}') : null;
      } else {
        print('dotStarStringDotStar(): NO MATCH on input: $input');
      }
    },
  );
}

void dotStringDotStar(List<String> strings) {
  print('///// dotStringDotStar(): strings: $strings');

  final regex = RegExp(r'.blue.*');
  print('dotStringDotStar(): regex: $regex');

  strings.forEach(
    (input) {
      final match = regex.firstMatch(input);
      if (match != null) {
        print('dotStringDotStar(): match.input: ${match.input}');
        print('dotStringDotStar(): match.groupeCount: ${match.groupCount}');
        print('dotStringDotStar(): match.start-end: ${match.start}-${match.end}');
        print('dotStringDotStar(): match.group(0): ${match.group(0)}');
        match.groupCount > 0 ? print('dotStringDotStar(): match.group(1): ${match.group(1)}') : null;
        match.groupCount > 1 ? print('dotStringDotStar(): match.group(2): ${match.group(2)}') : null;
        match.groupCount > 2 ? print('dotStringDotStar(): match.group(2): ${match.group(3)}') : null;
        match.groupCount > 3 ? print('dotStringDotStar(): match.group(2): ${match.group(4)}') : null;
        match.groupCount > 4 ? print('dotStringDotStar(): match.group(2): ${match.group(5)}') : null;
      } else {
        print('dotStringDotStar(): NO MATCH on input: $input');
      }
    },
  );
}

void dotStringDot(List<String> strings) {
  print('///// dotStringDot(): strings: $strings');

  final regex = RegExp(r'.blue.');
  print('dotStringDot(): regex: $regex');

  strings.forEach(
    (input) {
      final match = regex.firstMatch(input);
      if (match != null) {
        print('dotStringDot(): match.input: ${match.input}');
        print('dotStringDot(): match.groupeCount: ${match.groupCount}');
        print('dotStringDot(): match.start-end: ${match.start}-${match.end}');
        print('dotStringDot(): match.group(0): ${match.group(0)}');
        match.groupCount > 0 ? print('dotStringDot(): match.group(1): ${match.group(1)}') : null;
        match.groupCount > 1 ? print('dotStringDot(): match.group(2): ${match.group(2)}') : null;
        match.groupCount > 2 ? print('dotStringDot(): match.group(2): ${match.group(3)}') : null;
        match.groupCount > 3 ? print('dotStringDot(): match.group(2): ${match.group(4)}') : null;
        match.groupCount > 4 ? print('dotStringDot(): match.group(2): ${match.group(5)}') : null;
      } else {
        print('dotStringDot(): NO MATCH on input: $input');
      }
    },
  );
}

void wHy(String str) {
  print('///// wHy(): str: $str');

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
