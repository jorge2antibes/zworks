import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(context),
      home: ReOrderStack(),
    );
  }
}

class ReOrderStack extends StatelessWidget {
  const ReOrderStack({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final reverse = true;

    return Scaffold(
      body: Stack(
        children: [
          GridView.builder(
            //removes the gap created by status bar height
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: screenSize.width / screenSize.height,
            ),
            itemCount: images.length,
            reverse: reverse,
            itemBuilder: (context, index) {
              if (index < 2) {
                return Container(
                  color: Colors.transparent,
                );
              }
              return Image.asset(
                images.elementAt(index),
                fit: BoxFit.cover,
              );
            },
          ),
          IgnorePointer(
            ignoring: true,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: screenSize.width / screenSize.height,
              ),
              itemCount: images.length,
              reverse: !reverse,
              itemBuilder: (context, index) {
                if (index < 2) {
                  return Container(
                    color: Colors.transparent,
                  );
                }
                return Image.asset(
                  images.elementAt(index),
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final images = <String>{
  'assets/images/0.png',
  'assets/images/1.png',
  'assets/images/2.png',
  'assets/images/3.png',
  'assets/images/4.png',
  'assets/images/5.png',
  'assets/images/6.png',
  'assets/images/7.png',
};

///https://pub.dev/packages/google_fonts
///https://www.flutterbeads.com/change-theme-text-color-in-flutter/#:~:text=of%20adding%20color-,Steps%20to%20change%20theme%20text%20color%20in%20Flutter,the%20color%20of%20your%20choice.
ThemeData _buildTheme(BuildContext context) {
  var baseTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    useMaterial3: true,
    primarySwatch: Colors.yellow,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.poiretOneTextTheme(baseTheme.textTheme),
    // textTheme: GoogleFonts.juraTextTheme(baseTheme.textTheme),
  );
}
