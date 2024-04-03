import 'package:flutter/material.dart';

/// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Regular_expressions/Character_class
void main() {
  matchingHexadecimals('cab');
  matchingHexadecimals('2F3a');
  matchingHexadecimals('undefined');
  matchingAllLineTerminators('''A poem\r
      Is split\r\n
      Into many
      Stanzas''');
  runApp(MyApp());
}

void matchingAllLineTerminators(String str) {
  print('matchingAllLineTerminators(): str: $str');

  final regex = RegExp(r'(?:\r|\n|\u2028|\u2029|\r\n)', caseSensitive: true, unicode: true);
  // final regex = RegExp(r'[\r\n\u2028\u2029]', caseSensitive: true, unicode: true);
  final matches = regex.allMatches(str);

  print('matchingAllLineTerminators(): matches.count: ${matches.length}');

  for (final match in matches) {
    print(
        'matchingAllLineTerminators(): match.groupCount: ${match.groupCount}');
    print(
        'matchingAllLineTerminators(): match.groupNames: ${match.groupNames}');
    print('matchingAllLineTerminators(): match.groups: ${match.groups([0])}');
    print('matchingAllLineTerminators(): match.group(0): ${match.group(0)}');
  }
}

void matchingHexadecimals(String str) {
  print('matchingHexadecimals(): str: $str');

  final regex = RegExp(r'^[0-9a-fA-F]+$', caseSensitive: true);
  final matches = regex.allMatches(str);

  print('matchingHexadecimals(): matches.count: ${matches.length}');

  for (final match in matches) {
    print('matchingHexadecimals(): match.groupCount: ${match.groupCount}');
    print('matchingHexadecimals(): match.groupNames: ${match.groupNames}');
    print('matchingHexadecimals(): match.groups: ${match.groups([0])}');
    print('matchingHexadecimals(): match.group(0): ${match.group(0)}');
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
    return const Placeholder();
  }
}
