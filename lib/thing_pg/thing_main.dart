import 'package:flutter/material.dart';
import 'package:sbox1/thing_pg/thing_pg.dart';

void main() {


  runApp(ThingApp());
}

class ThingApp extends StatelessWidget {
  const ThingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: ThingPg(),
    );
  }
}
