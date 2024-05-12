import 'package:flutter/material.dart';
import 'package:sbox1/mainori.dart';

/// This widget introduces a [MaterialApp], [Scaffold] and [PageView] with two pages
/// using the default constructor. Both pages contain an [ElevatedButton] allowing you
/// to animate the [PageView] using a [PageController].
/// I have also added another PageView (which is a copy of the first one) with
/// Horizontal scrolling. This seems to work at the level of button actions, however,
/// when I'm in the second element of the second PageView i.e. at previous button, a
/// scrolling up takes me to the previous button of the first page Not to the next
/// button of the second page as it should
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'basic PageController',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyPageView(),
    );
  }
}

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

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
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          children: <Widget>[
            ColoredBox(
              color: Colors.red,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
            ),
            ColoredBox(
              color: Colors.blue,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Text('Previous'),
                ),
              ),
            ),
            // PageView(
            //   scrollDirection: Axis.horizontal,
            //   controller: _pageController1,
            //   children: <Widget>[
            //     ColoredBox(
            //       color: Colors.red,
            //       child: Center(
            //         child: ElevatedButton(
            //           onPressed: () {
            //             if (_pageController1.hasClients) {
            //               _pageController1.animateToPage(
            //                 1,
            //                 duration: const Duration(milliseconds: 200),
            //                 curve: Curves.easeInOut,
            //               );
            //             }
            //           },
            //           child: const Text('Next horizontal'),
            //         ),
            //       ),
            //     ),
            //     ColoredBox(
            //       color: Colors.blue,
            //       child: Center(
            //         child: ElevatedButton(
            //           onPressed: () {
            //             if (_pageController1.hasClients) {
            //               _pageController1.animateToPage(
            //                 0,
            //                 duration: const Duration(milliseconds: 200),
            //                 curve: Curves.easeInOut,
            //               );
            //             }
            //           },
            //           child: const Text('Previous'),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
