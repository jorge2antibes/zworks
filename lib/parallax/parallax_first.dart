import 'package:flutter/material.dart';

void main() {
  runApp(TestParallax());
}

class TestParallax extends StatelessWidget {
  const TestParallax({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallax',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('parallax'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                width: MediaQuery.of(context).size.width,
                'assets/images/Asset 30@2x.png',
                fit: BoxFit.fitWidth,
              ),
              ParallaxWidget(
                movementFactor: 0.5, // Adjust movement factor as desired
                child: Container(
                  height: 200,
                  color: Colors.blueGrey.withOpacity(0.8),
                  child: const Text(
                    'This content moves faster!',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParallaxWidget extends StatelessWidget {
  final Widget child;
  final double movementFactor;

  ParallaxWidget({required this.child, required this.movementFactor});

  @override
  Widget build(BuildContext context) {
  double movement = 1;
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          // Calculate movement based on scroll position
          movement = (notification.scrollDelta! * movementFactor)!;
          return true;
        } else {
          return false;
        }
      },
      child: Stack(
        children: [
          Positioned(
            top: movement,
            child: child,
          ),
        ],
      ),
    );
  }
}
