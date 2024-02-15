import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precache0',
      theme: ThemeData.dark(),
      home: PrecacheVw(),
    );
  }
}

class PrecacheVw extends StatelessWidget {
  const PrecacheVw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {

          },
          child: Text('some text'),
        ),
      ),
    );
  }
}


/// todo: be implemented after information gathered
// precacheImage(provider, context);
// Image.memory(bytes)