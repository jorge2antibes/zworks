import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbox1/mainori.dart';
import 'package:sbox1/stack_reordering/stack_reorder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final images = <ImageView>[
      const ImageView(color: Colors.red),
      const ImageView(color: Colors.black),
      const ImageView(color: Colors.blue),
    ];
    return MaterialApp(
      title: 'basic PageController',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyPageView(images: images),
    );
  }
}

class MyPageView extends StatefulWidget {
  const MyPageView({super.key, required this.images});

  final List<ImageView> images;

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();
  final PageController _pageController1 = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    _pageController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            /// I could also use the builder constructor for more heavy build of widgets list
            PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: widget.images,
            ),
            const Center(
              child: Text('SOMTETEXT'),
            ),
            Positioned(
              right: 20,
              top: 100,
              width: 70,
              height: 200,
              child: Column(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        if (_pageController.hasClients) {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.bounceInOut,
                          );
                        }
                      },
                      child: const Placeholder(
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Placeholder(color: color);
  }
}
