import 'package:flutter/material.dart';
import 'package:sbox1/regexs/regexp_dart_api.dart';

void main() {
  ['abc', 'bc', ''].hasMatch(pattern: r'a?bc');
  ['color', 'colour', 'colours', 'Color', 'colo r'].hasMatch(pattern: r'colou?r');
  ['computer', 'computers', 'computerx', 'computer '].hasMatch(pattern: r'computers?');
  ['computer', 'computers', 'computerx'].firstMatch(pattern: r'computers?');
  ['a1', '1', 'z9' ].hasMatch(pattern: r'[a-z]?[1-9]');
  ['Bed', 'Bead', 'Dead', 'aed', 'Ba?d', 'Ded', 'Bea'].hasMatch(pattern: r'[BD][ae][ae]?d');
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


