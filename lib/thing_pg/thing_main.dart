import 'package:flutter/material.dart';
import 'package:sbox1/thing_pg/thing_pg0.dart';
import 'package:sbox1/thing_pg/thing_pg1.dart';

void main() {


  runApp(ThingApp());
}

class ThingApp extends StatelessWidget {
  const ThingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      // home: ThingPg0(),
      home: ThingPg1(),
    );
  }
}
