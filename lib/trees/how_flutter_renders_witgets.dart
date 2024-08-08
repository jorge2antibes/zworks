import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

var text = 'some text here';

void main() {
  debugPaintSizeEnabled = true;
  runApp(TestRendering());
}

class TestRendering extends StatelessWidget {
  TestRendering({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    debugPrint('TestRendering: build(): screemSize: $screenSize');
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(primaryColor: Colors.blue),
      theme: ThemeData.light().copyWith(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test auto rebuild basics'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(color: Colors.green, child: Text('Hello world')),
            );
          },
        ),
      ),
    );
  }
}
