import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  debugInvertOversizedImages = true;
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final heith = screenSize.height;

    print('width: $width');
    print('height: $heith');

    return MaterialApp(
      title: 'Single image big',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Container(
                  // width: 1600,
                  height: 5200,
                  child: CoverImage.asset(imageAsset: 'assets/images/12.png'),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: Colors.purple,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff26004d),
                    // Colors.white,
                    Color(0xff5900b3),
                  ],
                  // tileMode: TileMode.clamp,
                ),
              ),
              width: 803,
              height: 276,
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/Asset 18@2x.png',
                cacheWidth: (803 * 5.33).round(),
                cacheHeight: (276 * 5.33).round(),
              ),
              // child: CoverImage.asset(
              //   imageAsset: 'assets/images/Asset 11@2x.png',
              //   // imageAsset: 'assets/images/dialog.png',
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The size of the image displayed on the screen is determined by
/// the ‘width’ and ‘height’ properties, but the size of the rendered
/// image is determined by the ‘cacheWidth’ which is the width the image
/// should decode to and cache and, the ‘cacheHeight’ which is the height
/// the image should decode to and cache.
class CoverImage extends StatelessWidget {
  CoverImage.file({super.key, required this.imageFile})
      : imageNetwork = null,
        imageAsset = null;

  CoverImage.network({super.key, required this.imageNetwork})
      : imageFile = null,
        imageAsset = null;

  CoverImage.asset({super.key, required this.imageAsset})
      : imageNetwork = null,
        imageFile = null;

  final File? imageFile;
  final String? imageNetwork;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final constrainedWidth = constraints.maxWidth;
        final constrainedHeight = constraints.maxHeight;
        final constrainedAspectRatio = constrainedWidth / constrainedHeight;
        int? cacheWidth;
        int? cacheHeight;

        if (constrainedAspectRatio < 1) {
          cacheWidth = constrainedWidth.renderSize(context);
          // cacheWidth = 1200;
          // cacheHeight = 20014;
        } else if (constrainedAspectRatio > 1) {
          cacheHeight = constrainedHeight.renderSize(context);
        } else {
          cacheWidth = constrainedWidth.renderSize(context);
          cacheHeight = constrainedHeight.renderSize(context);
        }

        print('''CoverImage:
            Geometries: 
            constrainedWidth: $constrainedWidth, 
            constrainedHeight: $constrainedHeight,
            chacheWidth: $cacheWidth, 
            chacheHeight: $cacheHeight,
            constrainedAspectRatio: $constrainedAspectRatio,
            ''');

        if (imageFile != null) {
          return Image.file(
            imageFile!,
            fit: BoxFit.cover,
            width: constrainedWidth,
            height: constrainedHeight,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
          );
        } else if (imageNetwork != null) {
          return Image.network(
            imageNetwork!,
            fit: BoxFit.cover,
            width: constrainedWidth,
            height: constrainedHeight,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
          );
        } else if (imageAsset != null) {
          return Image.asset(
            imageAsset!,
            fit: BoxFit.cover,
            width: constrainedWidth,
            height: constrainedHeight,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
          );
        } else {
          throw Exception('neither Image.file nor Image.network');
        }
      },
    );
  }
}

extension ImageExtension on num {
  int renderSize(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final dimensionLength = (this * devicePixelRatio).round();
    print(
        'ImageExtension: renderSize: devicePixelRatio: $devicePixelRatio, dimensionLength: $dimensionLength');
    return dimensionLength;
  }
}
