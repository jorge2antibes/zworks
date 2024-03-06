import 'package:flutter/material.dart';
import 'package:sbox1/thing_pg/thing_pg0.dart';
import 'package:sbox1/thing_pg/thing_pg1.dart';
import 'package:sbox1/thing_pg/thing_pg2.dart';
import 'package:sbox1/thing_pg/thing_pg3.dart';

void main() {


  runApp(ThingApp());
}

class ThingApp extends StatelessWidget {
  const ThingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: ThingPg3(),
      // home: ThingPg2(),
      // home: ThingPg1(),
      // home: ThingPg0(),
    );
  }
}
