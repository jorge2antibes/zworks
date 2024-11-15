import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbox1/ayay_to_slivers/ayay0.dart';
import 'package:sbox1/ayay_to_slivers/extensions.dart';
import 'package:sbox1/ayay_to_slivers/for_valueNotifier_on_Set.dart';

///https://stackoverflow.com/questions/67597902/how-to-detect-if-an-image-is-vertical-or-horizontal
/// https://dartpad-workshops-io2021.web.app/getting_started_with_slivers
/// https://medium.com/make-android/save-your-memory-usage-by-optimizing-network-image-in-flutter-cbc9f8af47cd#:~:text=The%20method%20for%20resizing%20images,size%20specified%20in%20these%20properties.
void main() {
  debugInvertOversizedImages = true;
  bootstrap();
  runApp(Ayay1());
}

final goGet = GetIt.I;

void bootstrap() {
  goGet.registerSingleton<ImagesState>(ImagesState(<ThingImg>{}));
}

class Ayay1 extends StatelessWidget with GetItMixin {
  Ayay1({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final imagesState = watch<ImagesState, Set<ThingImg>>();
    final screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Ayay3',
      home: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: LimitedBox(
                    maxHeight: screenSize.height * .50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (imagesState.isNotEmpty)
                          LayoutBuilder(
                            builder: (context, constraints) {
                              print('constraints: $constraints');
                              return buildImageRefactored(
                                index: 0,
                                context: context,
                                thingImg: imagesState.elementAt(0),
                                constraints: constraints,
                              );
                            },
                          )
                        else
                          const Placeholder(
                            color: Colors.yellow,
                          ),
                        TextButton(
                          onPressed: () async {
                            final xFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            final uInt8List = await xFile!.readAsBytes();
                            final decodedImage =
                                await decodeImageFromList(uInt8List);
                            var decodeImageAspectRatio =
                                decodedImage.width / decodedImage.height;
                            final imagesState = goGet<ImagesState>();
                            final thingImage = ThingImg(
                                image: xFile,
                                aspectRatio: decodeImageAspectRatio);
                            imagesState.addOrReplaceAt(0, thingImage);
                            print(
                              '''decodedImage: 
                          name: ${xFile.name},
                          mimeType: ${xFile.mimeType},
                          index: 0, 
                          decodedImage.width: ${decodedImage.width}, 
                          decodedImage.height: ${decodedImage.height},
                          decodeImageAspectRatio: $decodeImageAspectRatio''',
                            );
                            print(imagesState.value.elementAt(0));
                          },
                          child: const Text('new img'),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: LimitedBox(
                    maxHeight: screenSize.height * .50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            print('constraints: $constraints');
                            print('ImageState: ${imagesState}');
                            if (imagesState.isNotEmpty &&
                                imagesState.length >= 2) {
                              return buildImageRefactored(
                                index: 1,
                                context: context,
                                thingImg: imagesState.elementAt(1),
                                constraints: constraints,
                              );
                            } else {
                              return const Placeholder(
                                color: Colors.red,
                              );
                            }
                          },
                        ),
                        if (imagesState.isNotEmpty && imagesState.length > 0)
                          TextButton(
                            onPressed: () async {
                              final xFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              final uInt8List = await xFile!.readAsBytes();
                              final decodedImage =
                                  await decodeImageFromList(uInt8List);
                              var decodeImageAspectRatio =
                                  decodedImage.width / decodedImage.height;
                              final imagesState = goGet<ImagesState>();
                              final thingImage = ThingImg(
                                  image: xFile,
                                  aspectRatio: decodeImageAspectRatio);
                              imagesState.addOrReplaceAt(1, thingImage);
                              print(
                                '''decodedImage: 
                                    name: ${xFile.name},
                                    mimeType: ${xFile.mimeType},
                                    index: 1, 
                                    decodedImage.width: ${decodedImage.width}, 
                                    decodedImage.height: ${decodedImage.height},
                                    decodeImageAspectRatio: $decodeImageAspectRatio''',
                              );
                              print(imagesState.value.elementAt(1));
                            },
                            child: const Text('new img'),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      print('constraints: $constraints');
                      print('ImageState: ${imagesState}');
                      if (imagesState.isNotEmpty && imagesState.length >= 3) {
                        return buildImageRefactored(
                          index: 2,
                          context: context,
                          thingImg: imagesState.elementAt(2),
                          constraints: constraints,
                        );
                      } else {
                        return const Placeholder(
                          color: Colors.blue,
                        );
                      }
                    },
                  ),
                  if (imagesState.isNotEmpty && imagesState.length > 1)
                    TextButton(
                      onPressed: () async {
                        final xFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        final uInt8List = await xFile!.readAsBytes();
                        final decodedImage =
                            await decodeImageFromList(uInt8List);
                        var decodeImageAspectRatio =
                            decodedImage.width / decodedImage.height;
                        final imagesState = goGet<ImagesState>();
                        final thingImage = ThingImg(
                            image: xFile, aspectRatio: decodeImageAspectRatio);
                        imagesState.addOrReplaceAt(2, thingImage);
                        print(
                          '''decodedImage: 
                                    name: ${xFile.name},
                                    mimeType: ${xFile.mimeType},
                                    index: 2, 
                                    decodedImage.width: ${decodedImage.width}, 
                                    decodedImage.height: ${decodedImage.height},
                                    decodeImageAspectRatio: $decodeImageAspectRatio''',
                        );
                        print(imagesState.value.elementAt(1));
                      },
                      child: const Text('new img'),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      print('constraints: $constraints');
                      print('ImageState: ${imagesState}');
                      if (imagesState.isNotEmpty && imagesState.length >= 4) {
                        return buildImageRefactored(
                          index: 3,
                          context: context,
                          thingImg: imagesState.elementAt(3),
                          constraints: constraints,
                        );
                      } else {
                        return const Placeholder(
                          color: Colors.green,
                        );
                      }
                    },
                  ),
                  if (imagesState.isNotEmpty && imagesState.length > 2)
                    TextButton(
                      onPressed: () async {
                        final xFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        final uInt8List = await xFile!.readAsBytes();
                        final decodedImage =
                            await decodeImageFromList(uInt8List);
                        var decodeImageAspectRatio =
                            decodedImage.width / decodedImage.height;
                        final imagesState = goGet<ImagesState>();
                        final thingImage = ThingImg(
                            image: xFile, aspectRatio: decodeImageAspectRatio);
                        imagesState.addOrReplaceAt(3, thingImage);
                        print(
                          '''decodedImage: 
                                    name: ${xFile.name},
                                    mimeType: ${xFile.mimeType},
                                    index: 3, 
                                    decodedImage.width: ${decodedImage.width}, 
                                    decodedImage.height: ${decodedImage.height},
                                    decodeImageAspectRatio: $decodeImageAspectRatio''',
                        );
                        print(imagesState.value.elementAt(1));
                      },
                      child: const Text('new img'),
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

class CoveredImage extends StatelessWidget {
  const CoveredImage({super.key, required this.thingImg});

  final ThingImg thingImg;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final constrainedWidth = constraints.maxWidth;
        final constrainedHeight = constraints.maxHeight;
        final constrainedAspectRatio = constrainedWidth / constrainedHeight;
        final imageFile = File(thingImg.image!.path);
        int? cacheWidth;
        int? cacheHeight;

        if (constrainedAspectRatio < 1) {
          cacheWidth = constrainedWidth.renderSize(context);
        } else if (constrainedAspectRatio > 1) {
          cacheHeight = constrainedHeight.renderSize(context);
        } else {
          cacheWidth = constrainedWidth.renderSize(context);
          cacheHeight = constrainedHeight.renderSize(context);
        }

        print('''CoveredImage:
            Geometries: 
            constrainedWidth: $constrainedWidth, 
            constrainedHeight: $constrainedHeight,
            chacheWidth: $cacheWidth, 
            chacheHeight: $cacheHeight,
            constrainedAspectRatio: $constrainedAspectRatio,
            thingImage.aspectRatio: ${thingImg.aspectRatio}
            ''');

        return Image.file(
          imageFile,
          fit: BoxFit.cover,
          width: constrainedWidth,
          height: constrainedHeight,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
        );
      },
    );
  }
}

///The size of the image displayed on the screen is determined by
/// the ‘width’ and ‘height’ properties, but the size of the rendered
/// image is determined by ‘cacheWidth’ and ‘cacheHeight’.
Image buildImageRefactored({
  required int index,
  required BuildContext context,
  required ThingImg thingImg,
  required BoxConstraints constraints,
}) {
  final constrainedWidth = constraints.maxWidth;
  final constrainedHeight = constraints.maxHeight;

  // The width the image should decode to and cache.
  // At least one of this and [height] must be non-null.
  int? cacheWidth;

  // The height the image should decode to and cache.
  // At least one of this and [width] must be non-null.
  int? cacheHeight;
  final image = thingImg.image!.path;
  final constrainedAspectRatio = constrainedWidth / constrainedHeight;

  if (constrainedAspectRatio < 1) {
    cacheWidth = constrainedWidth.renderSize(context);
  } else if (constrainedAspectRatio > 1) {
    cacheHeight = constrainedHeight.renderSize(context);
  } else {
    print('ERROR');
  }

  print('''BuildImageRefactored$index:
            Geometries: 
            constrainedWidth: $constrainedWidth, 
            constrainedHeight: $constrainedHeight,
            chacheWidth: $cacheWidth, 
            chacheHeight: $cacheHeight,
            constrainedAspectRatio: $constrainedAspectRatio,
            thingImage.aspectRatio: ${thingImg.aspectRatio}
            ''');

  return Image.file(
    File(image),
    width: constrainedWidth,
    height: constrainedHeight,
    fit: BoxFit.cover,
    cacheWidth: cacheWidth,
    cacheHeight: cacheHeight,
  );
}

///The size of the image displayed on the screen is determined by
/// the ‘width’ and ‘height’ properties, but the size of the rendered
/// image is determined by ‘cacheWidth’ and ‘cacheHeight’.
Image buildImage({
  required int index,
  required BuildContext context,
  required ThingImg thingImg,
  required BoxConstraints constraints,
}) {
  final constrainedWidth = constraints.maxWidth;
  final constrainedHeight = constraints.maxHeight;

  /// The width the image should decode to and cache.
  /// At least one of this and [height] must be non-null.
  int? cacheWidth;

  /// The height the image should decode to and cache.
  /// At least one of this and [width] must be non-null.
  int? cacheHeight;
  final image = thingImg.image!.path;
  final constrainedAspectRatio = constrainedWidth / constrainedHeight;

  if (thingImg.aspectRatio! < 1 && constrainedAspectRatio < 1) {
    ///NOT OK
    // cacheHeight = constrainedHeight.renderSize(context);
    ///OK
    cacheWidth = constrainedWidth.renderSize(context);

    ///OK
    // cacheHeight = constrainedWidth.renderSize(context);
    ///NOT OK
    // cacheWidth = constrainedHeight.renderSize(context);
  } else if (thingImg.aspectRatio! > 1 && constrainedAspectRatio < 1) {
    ///NOT OK
    // cacheHeight = constrainedHeight.renderSize(context);
    ///OK
    cacheWidth = constrainedWidth.renderSize(context);

    ///OK
    // cacheHeight = constrainedWidth.renderSize(context);
    ///NOT OK
    // cacheWidth = constrainedHeight.renderSize(context);
  } else if (thingImg.aspectRatio! > 1 && constrainedAspectRatio > 1) {
    ///OK
    cacheHeight = constrainedHeight.renderSize(context);

    ///NOT OK
    // cacheWidth = constrainedWidth.renderSize(context);
    ///NOT OK
    // cacheHeight = constrainedWidth.renderSize(context);
    ///OK
    // cacheWidth = constrainedHeight.renderSize(context);
  } else if (thingImg.aspectRatio! < 1 && constrainedAspectRatio > 1) {
    ///OK
    cacheHeight = constrainedHeight.renderSize(context);

    ///NOT OK
    // cacheWidth = constrainedWidth.renderSize(context);
    ///NOT OK
    // cacheHeight = constrainedWidth.renderSize(context);
    ///OK
    // cacheWidth = constrainedHeight.renderSize(context);
  } else {
    print('ERROR');
  }
  // if (thingImg.aspectRatio! < 1 && constrainedAspectRatio > 1) {
  //   ///NOT ok
  //   cacheHeight = constrainedHeight.renderSize(context);
  //   ///OK!!!
  //   // cacheHeight = constrainedWidth.renderSize(context);
  //   ///Ok too!!!
  //   // cacheWidth = constrainedWidth.renderSize(context);
  //   ///NOT ok
  //   // cacheWidth = constrainedHeight.renderSize(context);
  // } else {
  //   cacheWidth = constrainedWidth.renderSize(context);
  //   // cacheHeight = constrainedHeight.renderSize(context);
  // }

  print('''BuildImage$index:
            Geometries: 
            constrainedWidth: $constrainedWidth, 
            constrainedHeight: $constrainedHeight,
            chacheWidth: $cacheWidth, 
            chacheHeight: $cacheHeight,
            constrainedAspectRatio: $constrainedAspectRatio,
            thingImage.aspectRatio: ${thingImg.aspectRatio}
            ''');

  return Image.file(
    File(image),
    width: constrainedWidth,
    height: constrainedHeight,
    fit: BoxFit.cover,
    cacheWidth: cacheWidth,
    cacheHeight: cacheHeight,
  );
}

class ThingImg {
  final XFile? image;
  final double? aspectRatio;

  ThingImg({this.image, this.aspectRatio});

  @override
  String toString() {
    return '''ThingImg: image: ${image?.name}, aspectRatio: $aspectRatio''';
  }
}

class ImagesState extends ValueNotifier<Set<ThingImg>> with OnCollections {
  ImagesState(super.value);
}

mixin OnCollections<S extends Set<E>, E extends ThingImg> on ValueNotifier<S> {
  void add(E e) {
    value.add(e);
    notifyListeners();
  }

  /// add a thing to MyThingsState at index and notifies MyThingsVw
  void addAt(int index, E e) {
    var l = value.toList();
    l.insert(index, e);
    value = Set<E>.of(l) as S;
  }

  void addOrReplaceAt(int index, E e) {
    if (value.isNotEmpty && index < value.length) {
      var eAt = value.elementAt(index);
      value.remove(eAt);
      var l = value.toList();
      l.insert(index, e);
      value = Set<E>.of(l) as S;
    } else {
      value.add(e);
      notifyListeners();
    }
  }

  /// remove a thing from MyThingsState and notifies MyThingsVw
  void remove(E e) {
    value.remove(e);
    notifyListeners();
  }

  /// remove a thing from MyThingsState at index and notifies MyThingsVw
  void removeAt(int index) {
    var e = value.elementAt(index);
    value.remove(e);
    notifyListeners();
  }
}
