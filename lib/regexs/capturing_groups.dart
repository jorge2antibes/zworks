import 'package:flutter/material.dart';

void main() {
capturejorge(['jorge', 'orge', 'rge', 'ge', 'e', 'jorg', 'jor', 'jo', 'j']);
  capturejorge2(['jorge', 'orge', 'rge', 'ge', 'e', 'jorg', 'jor', 'jo', 'j']);
  runApp(MyApp());
}

void capturejorge(List<String> strings) {
  print('///// capturejorge(): strings: $strings');

  final regex = RegExp(r'(((((j)o)r)g)e)');
  print('capturejorge(): regex: $regex');

  strings.forEach(
        (input) {
      final match = regex.firstMatch(input);
      if (match != null) {
        print('capturejorge(): match.input: ${match.input}');
        print('capturejorge(): match.groupeCount: ${match.groupCount}');
        print('capturejorge(): match.start-end: ${match.start}-${match.end}');
        print('capturejorge(): match.group(0): ${match.group(0)}');
        match.groupCount > 0 ? print('capturejorge(): match.group(1): ${match.group(1)}') : null;
        match.groupCount > 1 ? print('capturejorge(): match.group(2): ${match.group(2)}') : null;
        match.groupCount > 2 ? print('capturejorge(): match.group(3): ${match.group(3)}') : null;
        match.groupCount > 3 ? print('capturejorge(): match.group(4): ${match.group(4)}') : null;
        match.groupCount > 4 ? print('capturejorge(): match.group(5): ${match.group(5)}') : null;
      } else {
        print('capturejorge(): NO MATCH on input: $input');
      }
    },
  );
}

void capturejorge2(List<String> strings) {
  print('///// capturejorge2(): strings: $strings');

  final regex = RegExp(r'(j(o(r(g(e)))))');
  print('capturejorge2(): regex: $regex');

  strings.forEach(
        (input) {
      final match = regex.firstMatch(input);
      if (match != null) {
        print('capturejorge2(): match.input: ${match.input}');
        print('capturejorge2(): match.groupeCount: ${match.groupCount}');
        print('capturejorge2(): match.start-end: ${match.start}-${match.end}');
        print('capturejorge2(): match.group(0): ${match.group(0)}');
        match.groupCount > 0 ? print('capturejorge2(): match.group(1): ${match.group(1)}') : null;
        match.groupCount > 1 ? print('capturejorge2(): match.group(2): ${match.group(2)}') : null;
        match.groupCount > 2 ? print('capturejorge2(): match.group(3): ${match.group(3)}') : null;
        match.groupCount > 3 ? print('capturejorge2(): match.group(4): ${match.group(4)}') : null;
        match.groupCount > 4 ? print('capturejorge2(): match.group(5): ${match.group(5)}') : null;
      } else {
        print('capturejorge2(): NO MATCH on input: $input');
      }
    },
  );
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