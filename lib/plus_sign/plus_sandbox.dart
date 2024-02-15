import 'package:flutter/material.dart';
import 'package:sbox1/plus_sign/plus_sign_wgt.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: PlusContainer(),
    );
  }
}

class PlusContainer extends StatelessWidget {
  const PlusContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white38,
        child: PlusSignWgt(
          height: 50,
          width: 100,
        ),
      ),
    );
  }
}
