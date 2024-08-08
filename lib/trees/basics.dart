import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

var text = 'some text here';

void main() {
  debugPaintSizeEnabled = true;
  runApp(TestRebuild());
}

class TestRebuild extends StatelessWidget {
  TestRebuild({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    debugPrint('TextRebuild: build(): screemSize: $screenSize');
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(primaryColor: Colors.blue),
      theme: ThemeData.light().copyWith(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test auto rebuild basics'),
        ),
        body: Center(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text),
              Container(
                color: Colors.purpleAccent,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
