import 'package:flutter/material.dart';
import 'package:sbox1/regexs/regexp_dart_api.dart';

///Quantifiers
///
/// Here is a regular expression that matches strings that contain three o's in a row:
///
/// .*ooo.*
/// and here is a shorthand way to write the same expression:
///
/// .*o{3}.*
/// The subexpression o{3} means to match three characters 'o' in a row.
void main() {
  /// Quantifiers
  /// Here is a regular expression that matches strings that contain three o's in a row:
  /// .*ooo.*
  /// and here is a shorthand way to write the same expression:
  /// .*o{3}.*
  /// The subexpression o{3} means to match three characters 'o' in a row
  // ['ooo', 'lkjooo', 'ooolkj', 'lkjlooolkjlk', ' ooo ', ].alllMatches(pattern: r'.*ooo.*');
  // ['ooo', 'lkjooo', 'ooolkj', 'lkjlooolkjlk', ' ooo ', ].alllMatches(pattern: r'.*o{3}.*');
  /// regex that match strings that start with 5 'a' and end with 5 'z'
  // ['aaaaaooiuzzzzz', 'aaaaazzzzz', 'aaaaa zzzzz', ' aaaaaalkjzzzzz ', ' ooo ', ].alllMatches(pattern: r'a{5}.*z{5}');
  // ['aaaaaooiuzzzzz', 'aaaaazzzzz', 'aaaaa zzzzz', ' aaaaaalkjzzzzz ', ' ooo ', ].alllMatches(pattern: r'aaaaa.*zzzzz');
  /// It matches one or more groups of five characters, where each group
  /// consists only of the characters 'a' through 'd'
  // ['aaaaa', 'bbbbb', 'ccccc', ' ddddd ', 'abcda', 'abcdz', 'a', 'z' ].alllMatches(pattern: r'([a-d]{5})+');
  /// The subexpression X{n,m} means to match at least n but no more than m,
  /// of the subexpression X. The numbers n and m must be literal constants,
  /// like 5, or 0, or 23. Of course, n must be less than m
  ['aa', 'aaaaaaa', 'abc', ' addbcd ', 'a', 'abcdabcd', 'axaaa', 'z' ].alllMatches(pattern: r'[a-d]{2,7}');
  /// It matches strings that start with two through four characters from
  /// 'A', 'B', or 'C' followed by two through four characters of 'X', 'Y', or 'Z'
  ['ax', 'aaxx', 'aaaaxxxx', 'abcxyz', 'a', 'abcdabcd', 'axaaa', 'z' ].alllMatches(pattern: r'[abc]{2,4}[xyz]{2,4}');
  /// Write a regular expression that matches strings that have
  /// no more than 5 'A' followed by a 'Z'.
  ['az', 'aaz', 'aaaz', 'aaaaz', 'aaaaaz', 'aaaaaaz', 'z', 'zz' ].alllMatches(pattern: r'a{0,5}z');
  /// To ask for a match with subexpression X at least n times, use
  /// X{n,}
  ['rats!!', 'rats!!!!', 'rats', 'rats!'].alllMatches(pattern: r'rats!{2,}');
  /// Write the expression that matches two or more groups of Rats!
  /// such as Rats! Rats!  or Rats! Rats! Rats! Rats!
  ['rats!', 'rats!rats!', 'rats! rats! ', 'rats! rats!', 'rats!rats!rats!'].alllMatches(pattern: r'(rats! ){2,}');
  /// If you want the final space to be optional, the expression could be (Rats! ){1,}(Rats!) ?
  ['rats!', 'rats!rats!', 'rats! rats! ', 'rats! rats!', 'rats!rats!rats!'].alllMatches(pattern: r'(rats! ){1,}(rats!) ?');

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
