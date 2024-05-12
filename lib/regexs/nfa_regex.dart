import 'package:flutter/material.dart';

void main() {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nfa regex',
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
      appBar: AppBar(title: Text('nfa to regex tests'),),
      body: Placeholder(),
    );
  }
}
