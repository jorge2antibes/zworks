import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// whith this lab I was trying to find a way to pass a dynamically decided/selected
/// contributing widget to its receptor widget in a way that the contributing widget
/// will be partially and dynamically configure so it have to way to be
/// invoked in the receptor to be finally fully configured.
/// In deed, the receptor will provide a configuration parameter to the contributing
/// widget dynamically while in the building process
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Receptor(
      /// anonymous function that accepts a double and returns a Widget
      contributor: (d) => Contributor(width: d),
    );
  }
}

class Contributor extends StatelessWidget {
  const Contributor({super.key, required this.width});

  /// dynamically defined parameter at the receptor widget
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: 300,
        child: const Placeholder(
          color: Colors.blue,
        ),
      ),
    );
  }
}

class Receptor extends StatelessWidget {
  const Receptor({super.key, required this.contributor});

  final Widget Function(double) contributor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            const Placeholder(
              color: Colors.purple,
            ),
            contributor(300),
          ],
        ),
      ),
    );
  }
}
