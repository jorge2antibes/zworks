import 'package:flutter/material.dart';

/// https://www.youtube.com/watch?v=F6WJAvRWbPo
///https://medium.com/@mustafatahirhussein/accessing-widgets-size-and-position-in-flutter-7ecc61b80c3e
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(primaryColorDark: Colors.blue),
      home: TheTest(),
    );
  }
}

class TheTest extends StatelessWidget {
  const TheTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dynamic aligment of image'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items.elementAt(index);
          ///type 'Null' is not a subtype of type 'RenderBox' in type cast
          // return SingleImg(img: items.elementAt(index));
        },
      ),
    );
  }
}

/// To get the size/position of a widget on screen, you can use GlobalKey to get its BuildContext to
/// then find the RenderBox of that specific widget, which will contain its global position and rendered size.
/// There is just one thing to be careful of: That context may not exist if the widget is not rendered.
/// Which can cause a problem with ListView as widgets are rendered only if they are potentially visible.
/// Another problem is that you can't get a widget's RenderBox during the build call as the
/// widget hasn't been rendered yet.
/// But what if I need to get the size during the build! What can I do?
/// There's one cool widget that can help: Overlay and its OverlayEntry. They are used to
/// display widgets on top of everything else (similar to the stack).
/// But the coolest thing is that they are on a different build flow; they are built after regular widgets.
/// That have one super cool implication: OverlayEntry can have a size that depends on widgets
/// of the actual widget tree.
/// Okay. But don't OverlayEntry requires to be rebuilt manually?
/// Yes, they do. But there's another thing to be aware of: ScrollController, passed to
/// a Scrollable, is a listenable similar to AnimationController.
/// Which means you could combine an AnimatedBuilder with a ScrollController. It would have
/// the lovely effect to rebuild your widget automatically on a scroll.
/// Perfect for this situation, right?
/// Combining everything into an example:
/// In the following example, you'll see an overlay that follows a widget inside a ListView and shares the same height.
class SingleImg extends StatelessWidget {
   SingleImg({required this.globalKey, required this.img}): super(key: globalKey);

  final String img;
  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context) {
    final RenderBox? renderObject = globalKey.currentContext?.findRenderObject() as RenderBox?;
    final offsetY = renderObject?.localToGlobal(Offset.zero).dy ?? 0;
    final deviceHeight = MediaQuery.of(context).size.height;
    final relativePosition = offsetY / deviceHeight;
    return Image.asset(
      height: 300,
      fit: BoxFit.contain,
      img,
    );
  }
}

///type 'Null' is not a subtype of type 'RenderBox' in type cast
// final items = <String>{
//   'assets/photos/0.jpg',
//   'assets/photos/1.jpg',
//   'assets/photos/2.jpg',
//   'assets/photos/3.jpg',
//   'assets/photos/4.jpg',
//   'assets/photos/5.jpg',
//   'assets/photos/6.jpg',
//   'assets/photos/7.jpg',
// };

final items = <Widget>{
  SingleImg(globalKey: GlobalKey(), img: 'assets/photos/0.jpg'),
  SingleImg(globalKey: GlobalKey(), img: 'assets/photos/1.jpg'),
  SingleImg(globalKey: GlobalKey(), img: 'assets/photos/2.jpg'),
  // SingleImg(globalKey: GlobalKey(), img: 'assets/photos/3.jpg'),
  // SingleImg(globalKey: GlobalKey(), img: 'assets/photos/4.jpg'),
  // SingleImg(globalKey: GlobalKey(), img: 'assets/photos/5.jpg'),
  // SingleImg(globalKey: GlobalKey(), img: 'assets/photos/6.jpg'),
  // SingleImg(globalKey: GlobalKey(), img: 'assets/photos/7.jpg'),
};
