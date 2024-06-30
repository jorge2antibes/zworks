import 'package:flutter/material.dart';

///https://widgettricks.substack.com/p/rule-2-sizes-go-up
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(150, 150)),
        child: const Icon(
          Icons.ac_unit,
          color: Colors.yellow,
        ),
      ),
    );

    // return MaterialApp(
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: Text("Container example"),
    //     ),
    //     body: Container(
    //       height: 220,
    //       width: 200,
    //       color: Colors.red,
    //       child: Text("i am inside a container!", style: TextStyle(fontSize: 30)),
    //     ),
    //   ),
    // );

    // return Center(
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints(
    //       minWidth: 20,
    //       maxWidth: 200,
    //       minHeight: 200,
    //       maxHeight: 400,
    //     ),
    //     child: Container(
    //       width: 20,
    //       height: 350,
    //       color: Colors.yellow,
    //     ),
    //   ),
    // );
  }
}
