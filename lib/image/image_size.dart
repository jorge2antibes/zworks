import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// flutter run -d chrome --web-renderer html --target=lib/image/image_size.dart
void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  Future<ui.Image> _getImage() {
    Completer<ui.Image> completer = Completer<ui.Image>();
    // const NetworkImage('https://i.stack.imgur.com/lkd0a.png')
    //     .resolve(ImageConfiguration())
    //     .addListener(
    //       ImageStreamListener(
    //         (image, synchronousCall) {
    //           completer.complete(image.image);
    //         },
    //       ),
    //     );
    const AssetImage('assets/images/8.png')
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener(
            (image, synchronousCall) {
              completer.complete(image.image);
            },
          ),
        );
    return completer.future;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Dimensions Example"),
      ),
      body: Center(
        child: FutureBuilder<ui.Image>(
          future: _getImage(),
          builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
            if (snapshot.hasData) {
              ui.Image? image = snapshot.data;
              return Text('${image?.width}x${image?.height}',
                  style: Theme.of(context).textTheme.bodyMedium);
            } else {
              return Text('Loading...');
            }
          },
        ),
      ),
    );
  }
}
