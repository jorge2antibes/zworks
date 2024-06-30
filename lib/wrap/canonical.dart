

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('wrap canonical'),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 350,
            child: Wrap(
              spacing: 16.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: <Widget>[
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('AH')),
                  label: const Text('Hamilton'),
                ),
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('ML')),
                  label: const Text('Lafayette'),
                ),
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('HM')),
                  label: const Text('Mulligan'),
                ),
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('JL')),
                  label: const Text('Laurens'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
