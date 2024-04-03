import 'package:flutter/material.dart';

/// Look arounds, captu
/// https://www.rexegg.com/regex-disambiguation.html
void main() {
  /// lookAheads
  /// X(?=Y)	Positive lookahead	X if followed by Y
  lookAheadAfterMatch('100 dollars');
  lookAheadBeforeMatch('100 dollars');

  /// X(?!Y)	Negative lookahead	X if not followed by Y
  negativeLookAheadAfterMatch('100 dollars');
  negativeLookAheadAfterMatch('100 pesos');

  ///lookBehinds
  /// (?<=Y)X	Positive lookbehind	X if after Y
  lookBehindBeforeMatch('USD100');
  lookBehindAfterMatch('USD100');

  /// (?<!Y)X	Negative lookbehind	X if not after Y
  negativeLookBehindBeforeMatch('JPY100');
  negativeLookBehindBeforeMatch('USD100');
  negativeLookBehindAfterMatch('JPY100');
  negativeLookBehindAfterMatch('USD100');

  dontCaptureThisNames('his name is Bob and her name Chloe');

  ///other examples
  findNegatives('0 12 -5 123 -18');
  insertTag();
  insertTagWithLookBehind();
  runApp(MyApp());
}

void insertTag() {
  final str = '''
    <html>
      <body style="height: 200px">
        ...
      </body>
    </html>''';

  print('insertTag(): str: $str');
  
  final resulting = str.replaceAll(RegExp(r'<body.*?>'), '<h1>Hello</h1>');

  print('insertTag(): resulting: $resulting');
}

void insertTagWithLookBehind() {
  final str = '''
    <html>
      <body style="height: 200px">
        ...
      </body>
    </html>''';

  print('insertTagWithLookBehind(): str: $str');

  final resulting = str.replaceAll(RegExp(r'(?<=<body.*?>)'), '<h1>Hello</h1>');

  print('insertTagWithLookBehind(): resulting: $resulting');
}

/// Create a regexp that looks for only non-negative ones (zero is allowed)
void findNegatives(String str) {
  print('findNegatives(): str: $str');

  //ok but, also takes 8 from -18
  // final regex = RegExp(r'(?<!-)\d+');
  // one solution is to add another negatives look behind
  // final regex = RegExp(r'(?<!-)(?<!\d)\d+');
  // another solution would be to join them in a single lookbehind
  final regex = RegExp(r'(?<![-\d])\d+');
  final matches = regex.allMatches(str);
  for (final match in matches) {
    print('findNegatives(): match[0]: ${match[0]}');
  }
}

List<RegExpMatch> dontCaptureThisNames(String str) {
  print('dontCaptureThisNames(): str: $str');

  final regex = RegExp(r'(?:Bob|Chloe)');
  final matches = regex.allMatches(str);

  for (final match in matches) {
    print('dontCaptureThisNames(): match[0]: ${match[0]}');
  }
  return matches.toList();
}

/// X(?=Y)	Positive lookahead	X if followed by Y
/// Lookahead After the Match: \d+(?= dollars)
/// Sample Match: 100 in 100 dollars
/// Explanation: \d+ matches the digits 100, then the lookahead (?= dollars)
/// asserts that at that position in the string, what immediately follows is
/// the characters "dollars"
void lookAheadAfterMatch(String str) {
  print('lookAheadAfterMatch(): str: $str');

  final regex = RegExp(r'\d+(?= dollars)');
  final match = regex.matchAsPrefix(str);

  print('lookAheadAfterMatch(): match: ${match?[0]}');
}

///Lookahead Before the Match: (?=\d+ dollars)\d+
/// Sample Match: 100 in 100 dollars
/// Explanation: The lookahead (?=\d+ dollars) asserts that at the current
/// position in the string, what follows is digits then the characters
/// " dollars". If the assertion succeeds, the engine matches the digits
/// with \d+
///Note that this pattern achieves the same result as \d+(?= dollars) from
///above, but it is less efficient because \d+ is matched twice. A better
///use of looking ahead before matching characters is to validate multiple
///conditions in a password
void lookAheadBeforeMatch(String str) {
  print('lookAheadBeforeMatch(): str: $str');

  final regex = RegExp(r'(?=\d+ dollars)\d+');
  final match = regex.matchAsPrefix(str);

  print('lookAheadBeforeMatch(): match: ${match?[0]}');
}

/// Negative Lookahead After the Match: \d+(?!\d| dollars)
/// Sample Match: 100 in 100 pesos
/// Explanation: \d+ matches 100, then the negative lookahead (?!\d| dollars)
/// asserts that at that position in the string, what immediately follows is
/// neither a digit nor the characters " dollars"
void negativeLookAheadAfterMatch(String str) {
  print('negativeLookAheadAfterMatch(): str: $str');

  final regex = RegExp(r'\d+(?!\d| dollars)');
  final match = regex.matchAsPrefix(str);

  print('negativeLookAheadAfterMatch(): match: ${match?[0]}');
}

/// Negative Lookahead Before the Match: (?!\d+ dollars)\d+
/// Sample Match: 100 in 100 pesos
/// Explanation: The negative lookahead (?!\d+ dollars) asserts that at the
/// current position in the string, what follows is not digits then the characters
/// " dollars". If the assertion succeeds, the engine matches the digits with \d+.
/// Note that this pattern achieves the same result as \d+(?!\d| dollars) from
/// above, but it is less efficient because \d+ is matched twice. A better use
/// of looking ahead before matching characters is to validate multiple
/// conditions in a password.
void negativeLookAheadBeforeMatch(String str) {
  print('negativeLookAheadBeforeMatch(): str: $str');

  final regex = RegExp(r'(?!\d+ dollars)\d+');
  final match = regex.matchAsPrefix(str);

  print('negativeLookAheadBeforeMatch(): match: ${match?[0]}');
}

/// Lookbehind Before the match: (?<=USD)\d{3}
/// Sample Match: 100 in USD100
/// Explanation: The lookbehind (?<=USD) asserts that at the current position
/// in the string, what precedes is the characters "USD". If the assertion
/// succeeds, the engine matches three digits with \d{3}.
void lookBehindBeforeMatch(String str) {
  print('lookBehindBeforeMatch(): str: $str');

  final regex = RegExp(r'(?<=USD)\d{3}');
  final match = regex.firstMatch(str);

  print('lookBehindBeforeMatch(): match: ${match?[0]}');
}

/// Lookbehind After the match: \d{3}(?<=USD\d{3})
/// Sample Match: 100 in USD100
/// Explanation: \d{3} matches 100, then the lookbehind (?<=USD\d{3}) asserts
/// that at that position in the string, what immediately precedes is the
/// characters "USD" then three digits.
/// Note that this pattern achieves the same result as (?<=USD)\d{3} from above,
/// but it is less efficient because \d{3} is matched twice.
void lookBehindAfterMatch(String str) {
  print('lookBehindAfterMatch(): str: $str');

  final regex = RegExp(r'\d{3}(?<=USD\d{3})');
  final match = regex.firstMatch(str);

  print('lookBehindAfterMatch(): match: ${match?[0]}');
}

/// Negative Lookbehind Before the Match: (?<!USD)\d{3}
/// Sample Match: 100 in JPY100
/// Explanation: The negative lookbehind (?<!USD) asserts that at the current
/// position in the string, what precedes is not the characters "USD". If the
/// assertion succeeds, the engine matches three digits with \d{3}.
void negativeLookBehindBeforeMatch(String str) {
  print('negativeLookBehindBeforeMatch(): str: $str');

  final regex = RegExp(r'(?<!USD)\d{3}');
  final match = regex.firstMatch(str);

  print('negativeLookBehindBeforeMatch(): match: ${match?[0]}');
}

/// Negative Lookbehind After the Match: \d{3}(?<!USD\d{3})
/// Explanation: \d{3} matches 100, then the negative lookbehind (?<!USD\d{3})
/// asserts that at that position in the string, what immediately precedes is
/// not the characters "USD" then three digits.
/// Note that this pattern achieves the same result as (?<!USD)\d{3} from
/// above, but it is less efficient because \d{3} is matched twice.
void negativeLookBehindAfterMatch(String str) {
  print('negativeLookBehindAfterMatch(): str: $str');

  final regex = RegExp(r'\d{3}(?<!USD\d{3})');
  final match = regex.firstMatch(str);

  print('negativeLookBehindAfterMatch(): match: ${match?[0]}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Look arounds',
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
