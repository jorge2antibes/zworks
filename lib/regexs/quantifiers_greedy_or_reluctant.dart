import 'package:flutter/material.dart';
import 'package:sbox1/regexs/regexp_dart_api.dart';

/// The character + in a regular expression means "match the preceding character one or more times".
/// For example A+ matches one or more of character A.
//
// The plus character, used in a regular expression, is called a Kleene plus
/// https://chortle.ccsu.edu/finiteautomata/Section07/sect07_19.html
void main() {
  // ['Beed', 'ZZeed', 'ZZeebd', 'Dud', 'greed', 'geed', 'Greed', 'Grd', 'Gd', 'Gadd'].alllMatches(pattern: r'[A-Z]+[aeiou]+[bd]?');
  /// Since it is greedy, the first X+ matches as much as it can without blocking the entire RE from matching, which is XXX .
  /// The final 'X' is matched by last part of the RE.
  /// Bug Alert! It is tempting to think that each half of X+X+ matches the same number of chracters X. But this is not so.
  // ['xxxx'].alllMatches(pattern: r'x+x+');

  /// To turn a greedy quantifier into a reluctant type, I must add question mark (?) rigth after
  // ['xxxx'].alllMatches(pattern: r'x+?x+?');
  // ['xxxx'].alllMatches(pattern: r'xx+');
  // ['xxxx'].alllMatches(pattern: r'(x)(x)+');

  /// Other greedy quantifiers:
  /// The star * plus + and ? quantifiers are all greedy. Each of them matches
  /// as much as it can without preventing a match between the complete RE and
  /// the string. Here is a RE
  /// a*a*
  /// and here is a string
  /// aaaaaaa
  /// The RE matches the string. In this case, the first A* in the RE matches the
  /// entire string, since the second A* will then match zero characters and the
  /// entire match will still succeed
  // ['aaaa'].alllMatches(pattern: r'(a)*(a)*');

  /// Here is a RE A+A+ and here is the automaton that matches it
  /// Non-deterministic Finite Automaton
  /// The automaton is non-deterministic. If (for example) the automaton is
  /// in state q1 and the current character is 'A' it has a choice of transitions.
  /// "Greedy" behavior is that the automaton will stay in q1 unless doing so
  /// will prevent it from reaching the final state.
  /// A non-deterministic automaton matches a string if there is a possible path
  /// through it that consumes each of the characters in the string. Not all paths
  /// have to match the string
  // ['aaaa'].alllMatches(pattern: r'(a)+(a)+');

  /// Here is a RE   z*z+   and here is a string it matches:  zzzz .
  /// What part of the string does  z*  match?
  /// Is there a simpler RE that matches the same set of strings?
  /// Response:
  /// z* will process zzz — it must leave the last "z" so the z+ has something to match.
  /// Is there a simpler RE that matches the same set of strings?
  /// z+
  // ['zzzz', 'yz', 'yzz', 'yzzz'].alllMatches(pattern: r'(z)*(z)+');
  // ['zzzz', 'yz', 'yzz', 'yzzz'].alllMatches(pattern: r'z+');

  /// note that the c char is registered in both character classes
  // ['abc', 'cbcc', 'cdc', 'dd', 'ccaac', 'cccc', 'aa', 'cab'].alllMatches(pattern: r'([abc])*([cd])');

  /// What regular expression specifies the set of all alphabetic strings,
  /// upper and lower case, at least one char long?
  /// Notice that 'z z' match only partially
  // ['a', 'b', 'aa', 'ab', 'ba', 'aB', 'Ba', 'aa', 'zZz', 'z z'].alllMatches(pattern: r'[a-zA-Z]+');

  /// What regular expression specifies the set of all lowercase alphabetic
  /// strings ending in 'b'?
  // ['b', 'ab', 'cb', 'bb', 'aab', 'baab', 'flub', 'a', 'abc', 'abbB', 'APPLE', 'Beauty', 'beast' ].alllMatches(pattern: r'[a-z]b');

  /// What regular expression specifies the set of all strings at least one
  /// character long consisting only of a's and b's:
  // ['a', 'b', 'aa', 'bb', 'ab', 'aaa', 'bbb', 'babb', 'bbba'].alllMatches(pattern: r'[ab]+');

  /// What regular expression specifies the set of strings consisting only of a's and b's which
  /// start with at least one 'a' and end with at least one 'b':
  // ['ab', 'aab', 'abab', 'abbaabbbabaa', 'a', 'b', 'aa', 'bb', 'ba', 'bba', '' ].alllMatches(pattern: r'a[ab]*b');
  /// The characters inside brackets can occur in any order. This means there can
  /// be many equivalent expressions. For example, [wxyz], [xyzw], [yzwx] ... and
  /// so on are all equivalent.
  // ['ab', 'aab', 'abab', 'abbaabbbabaa', 'a', 'b', 'aa', 'bb', 'ba', 'bba', '' ].alllMatches(pattern: r'a[ba]*b');

  ///
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
