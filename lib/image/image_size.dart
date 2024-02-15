import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// flutter run -d chrome --web-renderer html --target=lib/image/image_size.dart
void main() {
  debugInvertOversizedImages = true;
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  Future<ui.Image> _getImage(String img) {
    Completer<ui.Image> completer = Completer<ui.Image>();

    // NetworkImage(img).resolve(ImageConfiguration()).addListener(
    AssetImage(img).resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (imgInfo, synchronousCall) {
          final bytes = imgInfo.sizeBytes;
          completer.complete(imgInfo.image);
        },
      ),
    );
    return completer.future;
  }

  Future<ImageInfo> _getImgInfo(String img) {
    final completer = Completer<ImageInfo>();

    // NetworkImage(img)
    AssetImage(img)
        // const AssetImage(img)
        .resolve(const ImageConfiguration())
        .addListener(
      ImageStreamListener(
        (imgInfo, synchronousCall) {
          completer.complete(imgInfo);
        },
      ),
    );
    return completer.future;
  }

  // final pathToImage = 'https://i.stack.imgur.com/lkd0a.png';
  final pathToImage = 'assets/images/20240131_103828.jpg';

  // final pathToImage =
  //     'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/assets/header.jpeg';

  // final pathToImage =
  //     'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/assets/day_0.jpeg';

  // final pathToImage = 'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/assets/day_1.jpeg';
  // final pathToImage = 'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/assets/day_2.jpeg';
  // final pathToImage = 'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/assets/day_3.jpeg';
  // final pathToImage = 'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/assets/day_4.jpeg';
  // final pathToImage = 'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/assets/day_5.jpeg';
  // final pathToImage = 'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/assets/day_6.jpeg';

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Dimensions Example"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          /// https://medium.com/@xrolediamond/writing-optimal-flutter-code-pt1-networkimage-vs-image-network-and-when-to-use-them-48e9cc5e0d1b
          Image(
            image: Image.asset(
              pathToImage,
              cacheWidth: (screenSize.width * devicePixelRatio).round(),
            ).image,
            // image: AssetImage(pathToImage),
            // image: NetworkImage(pathToImage),
            height: screenSize.height,
            fit: BoxFit.cover,
          ),
          // Image(image: NetworkImage(pathToImage), fit: BoxFit.cover, builder),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<ui.Image>(
                  future: _getImage(pathToImage),
                  builder:
                      (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                    if (snapshot.hasData) {
                      ui.Image? image = snapshot.data;
                      return Text(
                          'width: ${image?.width} x height: ${image?.height},',
                          style: Theme.of(context).textTheme.bodyMedium);
                    } else {
                      return Text('Loading...');
                    }
                  },
                ),
                FutureBuilder<ImageInfo>(
                  future: _getImgInfo(pathToImage),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final imgInfo = snapshot.data;
                      final sizeBytes = imgInfo?.sizeBytes;
                      final sizeBytesString =
                          NumberFormat('###,###,000').format(sizeBytes);
                      return Text('Bytes: $sizeBytesString');
                    }
                    return Text('Loading image info...');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
