import 'package:flutter/material.dart';

void main() {
  'abc'.hasMatch(pattern: r'abc');
  ['abc', 'bca'].hasMatch(pattern: r'abc');
  'abc'.firstMatch(pattern: r'abc');
  ['abc', 'bca'].firstMatch(pattern: r'abc');
  'abc'.alllMatches(pattern: r'abc');
  ['abc', 'bca'].alllMatches(pattern: r'abc');
  exampleAllMatchesDocs();
}

extension regexes on String {
  bool hasMatch({required String pattern}) {
    final regex = RegExp(pattern);
    final hasMatch = regex.hasMatch(this);
    print(''''$this'.hasMatch(pattern: '$pattern') => hasMatch: $hasMatch''');
    return hasMatch;
  }

  void firstMatch({required String pattern}) {
    final regex = RegExp(pattern);

    final hasMatch = regex.hasMatch(this);
    final firstMatch = regex.firstMatch(this);

    print(''''$this'.firstMatch(pattern: '$pattern') => hasMatch: $hasMatch''');

    if (firstMatch != null) {
      print('\t\tfirstMatch(): firstMatch.input: ${firstMatch.input}');
      print('\t\tfirstMatch(): firstMatch.groupeCount: ${firstMatch.groupCount}');
      print('\t\tfirstMatch(): firstMatch.start-end: ${firstMatch.start}-${firstMatch.end}');
      if (firstMatch.group(0) == null) {
        print('\t\tfirstMatch(): NO MATCH on input: $this at firstMatch.group(0): ${firstMatch.group(0)}');
      } else {
        print('\t\tfirstMatch(): firstMatch.group(0): ${firstMatch.group(0)}');
        firstMatch.groupCount > 0 ? print('\t\tfirstMatch(): firstMatch.group(1): ${firstMatch.group(1)}') : null;
        firstMatch.groupCount > 1 ? print('\t\tfirstMatch(): firstMatch.group(2): ${firstMatch.group(2)}') : null;
        firstMatch.groupCount > 2 ? print('\t\tfirstMatch(): firstMatch.group(3): ${firstMatch.group(3)}') : null;
        firstMatch.groupCount > 3 ? print('\t\tfirstMatch(): firstMatch.group(4): ${firstMatch.group(4)}') : null;
        firstMatch.groupCount > 4 ? print('\t\tfirstMatch(): firstMatch.group(5): ${firstMatch.group(5)}') : null;
      }
    } else {
      print('\t\tfirstMatch(): NO MATCH on input: $this');
    }
  }

  void alllMatches({required String pattern, int start = 0}) {
    final regex = RegExp(pattern);
    final hasMatch = regex.hasMatch(this);
    final alllMatches = regex.allMatches(this, start);

    print(''''$this'.alllMatches(pattern: $pattern); => hasMatch: $hasMatch''');

    for (final match in alllMatches) {
      print('\t\t\talllMatches(): match.input: ${match.input}');
      print('\t\t\talllMatches(): match.groupeCount: ${match.groupCount}');
      print('\t\t\talllMatches(): match.start-end: ${match.start}-${match.end}');
      if (match.group(0) == null) {
        print('\t\t\talllMatches(): NO MATCH on input: $this at match.group(0): ${match.group(0)}');
      } else {
        print('\t\t\talllMatches(): match.group(0): ${match.group(0)}');
        match.groupCount > 0 ? print('\t\t\talllMatches(): match.group(1): ${match.group(1)}') : null;
        match.groupCount > 1 ? print('\t\t\talllMatches(): match.group(2): ${match.group(2)}') : null;
        match.groupCount > 2 ? print('\t\t\talllMatches(): match.group(3): ${match.group(3)}') : null;
        match.groupCount > 3 ? print('\t\t\talllMatches(): match.group(4): ${match.group(4)}') : null;
        match.groupCount > 4 ? print('\t\t\talllMatches(): match.group(5): ${match.group(5)}') : null;
      }
    }
  }
}

extension regexlists on List<String> {
  void hasMatch({required String pattern}) {
    print('''$this.hasMatch(pattern: '$pattern') => ...''');

    final regex = RegExp(pattern);
    for (final str in this) {
      final hasMatch = regex.hasMatch(str);
      print('''\t\thasMatch(): '$str' hasMatch: $hasMatch''');
    }
  }

  void firstMatch({required String pattern}) {
    final regex = RegExp(pattern);

    print('''$this.firstMatch(pattern: '$pattern') => ...''');

    for (final str in this) {
      final hasMatch = regex.hasMatch(str);
      final firstMatch = regex.firstMatch(str);
      print('''\t\t$str.firstMatch(pattern: '$pattern') => hasMatch: $hasMatch''');
      print('''\t\t\tfirstMatch: ${str} against regex: $pattern''');
      if (firstMatch != null) {
        print('\t\t\tfirstMatch(): firstMatch.input: ${firstMatch.input}');
        print('\t\t\tfirstMatch(): firstMatch.groupeCount: ${firstMatch.groupCount}');
        print('\t\t\tfirstMatch(): firstMatch.start-end: ${firstMatch.start}-${firstMatch.end}');
        if (firstMatch.group(0) == null) {
          print('\t\t\tfirstMatch(): NO MATCH on input: $str at firstMatch.group(0): ${firstMatch.group(0)}');
        } else {
          print('\t\t\tfirstMatch(): firstMatch.group(0): ${firstMatch.group(0)}');
          firstMatch.groupCount > 0 ? print('\t\t\tfirstMatch(): firstMatch.group(1): ${firstMatch.group(1)}') : null;
          firstMatch.groupCount > 1 ? print('\t\t\tfirstMatch(): firstMatch.group(2): ${firstMatch.group(2)}') : null;
          firstMatch.groupCount > 2 ? print('\t\t\tfirstMatch(): firstMatch.group(3): ${firstMatch.group(3)}') : null;
          firstMatch.groupCount > 3 ? print('\t\t\tfirstMatch(): firstMatch.group(4): ${firstMatch.group(4)}') : null;
          firstMatch.groupCount > 4 ? print('\t\t\tfirstMatch(): firstMatch.group(5): ${firstMatch.group(5)}') : null;
        }
      } else {
        print('\t\t\tfirstMatch(): NO MATCH on input: $str');
      }
    }
  }

  void alllMatches({required String pattern, int start = 0}) {
    final regex = RegExp(pattern);

    print('''$this.alllMatches(pattern: $pattern); => ...''');

    for (final str in this) {
      final hasMatch = regex.hasMatch(str);
      print('''\t\t'$str'.alllMatches(pattern: $pattern); => hasMatch: $hasMatch''');
      final allMatches = regex.allMatches(str, start);

      for (final match in allMatches) {
        print('\t\t\talllMatches(): match.input: ${match.input}');
        print('\t\t\talllMatches(): match.groupeCount: ${match.groupCount}');
        print('\t\t\talllMatches(): match.start-end: ${match.start}-${match.end}');
        if (match.group(0) == null) {
          print('\t\t\talllMatches(): NO MATCH on input: $this at match.group(0): ${match.group(0)}');
        } else {
          print('\t\t\talllMatches(): match.group(0): ${match.group(0)}');
          match.groupCount > 0 ? print('\t\t\talllMatches(): match.group(1): ${match.group(1)}') : null;
          match.groupCount > 1 ? print('\t\t\talllMatches(): match.group(2): ${match.group(2)}') : null;
          match.groupCount > 2 ? print('\t\t\talllMatches(): match.group(3): ${match.group(3)}') : null;
          match.groupCount > 3 ? print('\t\t\talllMatches(): match.group(4): ${match.group(4)}') : null;
          match.groupCount > 4 ? print('\t\t\talllMatches(): match.group(5): ${match.group(5)}') : null;
        }
      }
      if (allMatches.length == 0) {
        print('\t\t\talllMatches(): NO MATCH on input: $str');
      }
    }
  }
}

void exampleAllMatchesDocs() {
  RegExp exp = RegExp(r'(\w+)');
  var str = 'Dash is a bird';
  Iterable<Match> matches = exp.allMatches(str, 0);
  for (final match in matches) {
    print('exampleAllMatchesDocs(): match.input: ${match.input}');
    print('exampleAllMatchesDocs(): match.pattern: ${match.pattern}');
    print('exampleAllMatchesDocs: match[0]: ${match[0]}');
    print('exampleAllMatchesDocs: match.group(0): ${match.group(0)}');
    match.groupCount > 0 ? print('\t\t\texampleAllMatchesDocs(): match.group(1): ${match.group(1)}') : null;
    match.groupCount > 1 ? print('\t\t\texampleAllMatchesDocs(): match.group(2): ${match.group(2)}') : null;
    match.groupCount > 2 ? print('\t\t\texampleAllMatchesDocs(): match.group(3): ${match.group(3)}') : null;
    match.groupCount > 3 ? print('\t\t\texampleAllMatchesDocs(): match.group(4): ${match.group(4)}') : null;
    match.groupCount > 4 ? print('\t\t\texampleAllMatchesDocs(): match.group(5): ${match.group(5)}') : null;
  }
}


