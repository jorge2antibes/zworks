import 'package:flutter/material.dart';
import 'package:sbox1/cvs/cv0.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SandBox(),
    );
  }
}

class SandBox extends StatelessWidget {
  const SandBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          print('''Constrains:
          minWidth: ${constraints.minWidth}, 
          maxWidth: ${constraints.maxWidth},
          minHeight: ${constraints.minHeight},
          maxHeight: ${constraints.maxHeight},
          isNormalized: ${constraints.isNormalized},
          isTight: ${constraints.isTight},
          hasTightWidth: ${constraints.hasTightWidth},
          hasTightHeight: ${constraints.hasTightHeight},
          hasInfiniteWidth: ${constraints.hasInfiniteWidth},
          hasInfiniteHeight: ${constraints.hasInfiniteHeight},
          hasBoundedWidth: ${constraints.hasBoundedWidth},
          hasBoundedHeight: ${constraints.hasBoundedHeight},
           ''');
          return Center(
            child: InkWell(
              onTap: () => print('onTap(): tapped'),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  print('''Constrains:
                minWidth: ${constraints.minWidth}, 
                  maxWidth: ${constraints.maxWidth},
                  minHeight: ${constraints.minHeight},
                  maxHeight: ${constraints.maxHeight},
                  isNormalized: ${constraints.isNormalized},
                  isTight: ${constraints.isTight},
                  hasTightWidth: ${constraints.hasTightWidth},
                  hasTightHeight: ${constraints.hasTightHeight},
                  hasInfiniteWidth: ${constraints.hasInfiniteWidth},
                  hasInfiniteHeight: ${constraints.hasInfiniteHeight},
                  hasBoundedWidth: ${constraints.hasBoundedWidth},
                  hasBoundedHeight: ${constraints.hasBoundedHeight},
                   ''');
                  return CoverImage.asset(imageAsset: 'assets/photos/1.jpg');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
