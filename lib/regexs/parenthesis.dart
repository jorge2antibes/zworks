import 'package:flutter/material.dart';
import 'package:sbox1/regexs/regexp_dart_api.dart';

///Parentheses
/// Parentheses are used to group subexpressions. A subexpression
/// inside parentheses must be completely matched. For example,
/// (cat|snake) eyes matches cat eyes or snake eyes.
/// Parentheses have high precidence, so that what lies between them
/// is a complete subexpression.   (cat|snake) eyes means cat or snake
/// , followed by  eyes
/// The *, +, and ? quantifiers apply to the single character to their
/// left, or to the parenthetical subexpression to their left
void main() {
  // ['puppy', 'puppies', 'ies'].hasMatch(pattern: r'puppy|ies');
  // ['puppy', 'puppies', 'ies'].alllMatches(pattern: r'puppy|ies');
  // ['puppy', 'puppies', 'ies'].hasMatch(pattern: r'pupp(y|ies)');
  // ['puppy', 'puppies', 'ies'].alllMatches(pattern: r'pupp(y|ies)');
  // /// puppy* is like pupp with or without any number of y s
  // ['pup','pupp', 'puppy', 'puppyy', 'puppyyy', 'puppypuppy'].hasMatch(pattern: r'puppy*');
  // ['pup','pupp', 'puppy', 'puppyy', 'puppyyy', 'puppypuppy'].alllMatches(pattern: r'puppy*');
  // [' ', 'pup', 'pupp', 'puppy', 'puppyy', 'puppyyy', 'puppypuppy'].hasMatch(pattern: r'(puppy)*');
  // [' ', 'pup', 'pupp', 'puppy', 'puppyy', 'puppyyy', 'puppypuppy'].alllMatches(pattern: r'(puppy)*');
  // [' ', 'pup', 'pupp', 'puppy', 'puppyy', 'puppyyy', 'puppypuppy'].hasMatch(pattern: r'(puppy)+');
  // [' ', 'pup', 'pupp', 'puppy', 'puppyy', 'puppyyy', 'puppypuppy'].alllMatches(pattern: r'(puppy)+');
  // [' ', 'pup', 'pupp', 'puppy', 'puppyy', 'puppyyy', 'puppypuppy'].hasMatch(pattern: r'(puppy)?');
  // [' ', 'pup', 'pupp', 'puppy', 'puppyy', 'puppyyy', 'puppypuppy'].alllMatches(pattern: r'(puppy)?');
  // ['dog ', 'dog cat ', 'dog cat dog ', 'bat bat bat', 'dog', 'dogcatbab', 'puppypuppy'].hasMatch(pattern: r'(dog |cat |bat )+');
  // ['dog ', 'dog cat ', 'dog cat dog ', 'bat bat bat', 'dog', 'dogcatbab', 'puppypuppy'].alllMatches(pattern: r'(dog |cat |bat )+');
  // ///Not too good
  // ['porkchop', 'Porkchop', 'lambchop ', 'Lambchop', 'porkchops', 'Porkchops', 'lambchops', 'Lambchops'].hasMatch(pattern: r'([pPlL]{1})(ork|amb)chops*');
  // ['porkchop', 'Porkchop', 'lambchop ', 'Lambchop', 'porkchops', 'Porkchops', 'lambchops', 'Lambchops'].alllMatches(pattern: r'([pPlL]{1})(ork|amb)chops*');
  // /// betPter
  // ['porkchop', 'Porkchop', 'lambchop ', 'Lambchop', 'porkchops', 'Porkchops', 'lambchops', 'Lambchops'].hasMatch(pattern: r'([pP]ork|[lL]amb)chop?');
  // ['porkchop', 'Porkchop', 'lambchop ', 'Lambchop', 'porkchops', 'Porkchops', 'lambchops', 'Lambchops'].alllMatches(pattern: r'([pP]ork|[lL]amb)chop?');
  /// nesting groups:
  // ['porkchop', 'Porkchop', 'lambchop ', 'Lambchop', 'porkchops', 'Porkchops', 'lambchops', 'Lambchops'].alllMatches(pattern: r'([pP]ork|[lL]amb)chop?');
  // ['r2d2r2', 'r23', 'c3po', 'cpdo', 'r2opc3', 'rdcpcp', 'cpd2'].alllMatches(pattern: r'(([rd]2)|([cpo]3?))+');
  /// What regular expression describes the set of strings made up of 'a'
  /// and 'b' such that each 'a' is immediately preceded by at least one
  /// 'b' and immediately followed by at least one 'b'
  // [' ', 'b', 'bb', 'bbb', 'bab', 'babab', 'babbababb', 'a', 'ab', 'ba', 'abb', 'bba'].alllMatches(pattern: r'((ba)*b+)*');
  /// Find a regular expression that matches price tag amounts: a dollar sign,
  /// a dollar amount consisting of one or more digits 0 through 9, optionally
  /// followed by cents, but always a decimal point and two digits if cents are
  /// included. If a 0 immediately follows the dollar sign, then the dollar
  /// amount consists of only that digit.
  // ['\$45', '\$0.12', '\$149.99', '\$0.00', '\$0', '\$199.03', '\$1999.03', ' ', '\$49.1', '149.99', '\$.49', '\$00.45', '\$000'].alllMatches(pattern: r'\$(0|[1-9]*)(\.[0-9][0-9])?');
  /// Write a RE that matches strings that start with an 'a' and end with
  /// a 'b' and have any number of a's and b's in the middle.
  /// //original solution
  [' ', 'ab', 'aab', 'abb', 'abab', 'ba', 'abba', ''].alllMatches(pattern: r'a[ab]*b');
  /// my solution
  [' ', 'ab', 'aab', 'abb', 'abab', 'ba', 'abba', ''].alllMatches(pattern: r'a[ab]*b{1}');

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
