import 'package:flutter/material.dart';

///https://www.youtube.com/watch?v=xGMa_m90xWA
void main() {
  runApp(TestParallax());
}

class TestParallax extends StatefulWidget {
  TestParallax({super.key});

  @override
  State<TestParallax> createState() => _TestParallaxState();
}

class _TestParallaxState extends State<TestParallax> {
  double top30 = 0;
  double top0 = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallax',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('parallax'),
        ),
        body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            print('NotificationListener<ScrollUpdateNotification>: notification.dragDetails: ${notification.dragDetails}');
            print('NotificationListener<ScrollUpdateNotification>: notification.scrollDelta: ${notification.scrollDelta}');
            // whatever setState() or rebuild must be done before returning true, otherwise the ui update is not executed
            setState(() {
              top30 -= notification.scrollDelta! / 1.3;
              top0 -= notification.scrollDelta! / 1.6;
            });
            if (notification.scrollDelta != null) {
              return true;
            }
            return true;
          },
          child: Stack(
            children: [
              ///parallax background
              ParallaxBackground(top: top30, asset: 'assets/images/Asset 30@2x.png'),
              ParallaxBackground(top: top0, asset: 'assets/images/0.png'),
              ///parallax foreground composed by viewport and the main container.
              SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    ///this will create a transparent window that will act as a viewport over the parallaxed images
                    const SizedBox(height: 350),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: const Color(0xff372d3b),
                      alignment: Alignment.center,
                      child: Text(
                        'Parallax effect',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParallaxBackground extends StatelessWidget {
  const ParallaxBackground({super.key, required this.asset, this.top});

  final double? top;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 350,
        child: Image(
          image: AssetImage(asset),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
