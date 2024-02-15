import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbox1/ayay_to_slivers/extensions.dart';
import 'package:sbox1/sinusoidals/package/flutter_sinusoidals.dart';

///https://stackoverflow.com/questions/67597902/how-to-detect-if-an-image-is-vertical-or-horizontal
/// https://dartpad-workshops-io2021.web.app/getting_started_with_slivers
/// https://medium.com/make-android/save-your-memory-usage-by-optimizing-network-image-in-flutter-cbc9f8af47cd#:~:text=The%20method%20for%20resizing%20images,size%20specified%20in%20these%20properties.
void main() {
  // debugInvertOversizedImages = true;
  // debugImageOverheadAllowance = 1;
  // bootstrap();
  runApp(const Ayay1());
}

class Ayay1 extends StatefulWidget {
  const Ayay1({super.key});

  @override
  State<Ayay1> createState() => _Ayay1State();
}

class _Ayay1State extends State<Ayay1> {
  late final MediaQueryData mediaQueryData;

  @override
  void initState() {
    super.initState();
    mediaQueryData = MediaQueryData.fromView(
        WidgetsFlutterBinding.ensureInitialized()
            .platformDispatcher
            .views
            .single);
    print('''MediaQueryData:
    width: ${mediaQueryData.size.width}, 
    height: ${mediaQueryData.size.height}, 
    dpr: ${mediaQueryData.devicePixelRatio}, 
    displayFeatures: ${mediaQueryData.displayFeatures},
    ''');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = mediaQueryData.size;
    final windowWidth = screenSize.width;
    final windowHeight = screenSize.height;
    final windowAspectRatio = windowWidth / windowHeight;
    final devicePixelRatio = mediaQueryData.devicePixelRatio;

    final expandedHeight = screenSize.height * .30;
    final toolbarHeight = screenSize.height * .16;
    final collapsedHeight = 250.0;

    print('''metrics: 
    windowWidth: $windowWidth,
    windowHeight: $windowHeight,
    windowAspectRatio: $windowAspectRatio,
    devicePixelRatio from context: $devicePixelRatio,
    expandedHeight: ${expandedHeight},
    toolbarHeight: ${toolbarHeight},
    collapsedHeight: ${collapsedHeight},
    ''');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      scrollBehavior: const ConstantScrollBehavior(),
      title: 'Ayay1',
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.blue.withOpacity(.1),
            ),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: false,
                  floating: true,
                  collapsedHeight: collapsedHeight,
                  expandedHeight: expandedHeight,
                  toolbarHeight: toolbarHeight,
                  leadingWidth: 600,
                  backgroundColor: Colors.blue.withOpacity(.2),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 40, top: 30),
                    child: Text(
                      '"Complexity emerges from virtue and beauty. Complication in the other hand, from mediocrity"',
                      style: GoogleFonts.poiretOne(
                          fontSize: 30, color: Colors.white54),
                    ),
                  ),
                  // title: Text('sine test\\'),
                  // actions: [
                  //   Padding(
                  //     padding: const EdgeInsets.only(
                  //       top: 120,
                  //       right: 100,
                  //       // bottom: 60,
                  //     ),
                  //     child: Text(
                  //       'JC',
                  //       style: GoogleFonts.abel(fontSize: 60),
                  //     ),
                  //   ),
                  // ],
                  // bottom: PreferredSize(
                  //   // important: height must be zero so the parallax effect can take place
                  //   preferredSize: Size(windowWidth, 0),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 450, bottom: 10),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         Container(
                  //           width: 200,
                  //           child: const Text(
                  //             'Experience',
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: const Text(
                  //             'Languages/frameworks',
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 200,
                  //           child: const Text(
                  //             'Education',
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // bottom: PreferredSize(
                  //   preferredSize: Size(windowWidth, 0),
                  //   child: Sinusoidal(
                  //     reverse: true,
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         color: Colors.purple,
                  //         border: Border(bottom: BorderSide(color: Colors.white, width: 2))
                  //       ),
                  //       // color: Colors.purple,
                  //       height: 30,
                  //     ),
                  //   ),
                  // ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    stretchModes: [StretchMode.blurBackground],
                    expandedTitleScale: 2,
                    collapseMode: CollapseMode.parallax,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              print(
                                '''contrains AppBar: CircleAvatar():
                            hasBoundedWidth: ${constraints.hasBoundedWidth},
                            hasBoundedHeight:${constraints.hasBoundedHeight},
                            hasInfiniteWidth: ${constraints.hasInfiniteWidth},
                            hasInfiniteHeight: ${constraints.hasInfiniteHeight},
                            hasTightWidth: ${constraints.hasTightWidth},
                            hasTightHeight: ${constraints.hasTightHeight},
                            smallest: ${constraints.smallest},
                            biggest: ${constraints.biggest},
                            minWidth: ${constraints.minWidth},
                            maxWidth: ${constraints.maxWidth},
                            minHeight: ${constraints.minHeight},
                            maxHeight: ${constraints.maxHeight},
                            isNormalized: ${constraints.isNormalized},
                            isTight: ${constraints.isTight},
                            isSatisfiedBy:${constraints.isSatisfiedBy(const Size(0, 0))}''',
                              );
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Container(
                                  // color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 100),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                          child: CircleAvatar(
                                            radius: constraints.maxWidth * .05,
                                            backgroundImage: Image.asset(
                                              'assets/images/20240131_103828.jpg',
                                              // fit: BoxFit.fill,
                                              cacheWidth: 400,
                                              // cacheHeight: 202,
                                            ).image,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              // color: Colors.blue,
                                              width: 80,
                                              height: 20,
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Experience',
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              // color: Colors.yellow,
                                              width: 80,
                                              height: 20,
                                              child: const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Languages',
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              // color: Colors.blue,
                                              width: 80,
                                              height: 20,
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Experience',
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Text(
                              'Jorge Carbonell',
                              style: GoogleFonts.abel(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // background: Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: 60,
                    //     bottom: 60,
                    //     left: 1100,
                    //   ),
                    //   child: LayoutBuilder(
                    //     builder: (context, constraints) {
                    //       print(
                    //         '''contrains AppBar:
                    //         hasBoundedWidth: ${constraints.hasBoundedWidth},
                    //         hasBoundedHeight:${constraints.hasBoundedHeight},
                    //         hasInfiniteWidth: ${constraints.hasInfiniteWidth},
                    //         hasInfiniteHeight: ${constraints.hasInfiniteHeight},
                    //         hasTightWidth: ${constraints.hasTightWidth},
                    //         hasTightHeight: ${constraints.hasTightHeight},
                    //         smallest: ${constraints.smallest},
                    //         biggest: ${constraints.biggest},
                    //         minWidth: ${constraints.minWidth},
                    //         maxWidth: ${constraints.maxWidth},
                    //         minHeight: ${constraints.minHeight},
                    //         maxHeight: ${constraints.maxHeight},
                    //         isNormalized: ${constraints.isNormalized},
                    //         isTight: ${constraints.isTight},
                    //         isSatisfiedBy:${constraints.isSatisfiedBy(const Size(0, 0))}''',
                    //       );
                    //       return CircleAvatar(
                    //         backgroundImage: Image.asset(
                    //           'assets/images/20240131_103828.jpg',
                    //           // fit: BoxFit.fill,
                    //           cacheWidth: 400,
                    //           // cacheHeight: 202,
                    //         ).image,
                    //       );
                    //     },
                    //   ),
                    // ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Sinusoidal(
                        reverse: true,
                        model: const SinusoidalModel(
                          formular: WaveFormular.travelling,
                          amplitude: 12, frequency: .5,
                          waves: 0.5,
                        ),
                        child: Center(
                          child: Container(
                            color: Colors.blue.withOpacity(.2),
                            height: 25,
                          ),
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          print(
                            '''contrains Background:
                            hasBoundedWidth: ${constraints.hasBoundedWidth},
                            hasBoundedHeight:${constraints.hasBoundedHeight},
                            hasInfiniteWidth: ${constraints.hasInfiniteWidth},
                            hasInfiniteHeight: ${constraints.hasInfiniteHeight},
                            hasTightWidth: ${constraints.hasTightWidth},
                            hasTightHeight: ${constraints.hasTightHeight},
                            smallest: ${constraints.smallest},
                            biggest: ${constraints.biggest},
                            minWidth: ${constraints.minWidth},
                            maxWidth: ${constraints.maxWidth},
                            minHeight: ${constraints.minHeight},
                            maxHeight: ${constraints.maxHeight},
                            isNormalized: ${constraints.isNormalized},
                            isTight: ${constraints.isTight},
                            isSatisfiedBy:${constraints.isSatisfiedBy(const Size(0, 0))}''',
                          );
                          return Image.asset(
                            'assets/images/13_1.png',
                            fit: BoxFit.fitHeight,
                            cacheWidth: 1400,
                            // cacheHeight: (5200).round(),
                          );
                        },
                      )
                    ],
                  ),
                  // itemExtent: 5200,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final goGet = GetIt.I;

// void bootstrap() {
//   goGet.registerSingleton<MyImages>(MyImages(<ThingImg>{}));
//
//   goGet.registerSingleton<PeopleImages>(PeopleImages(<ThingImg>{}));
// }

class ThingImg {
  final XFile? image;
  final double? aspectRatio;

  ThingImg({this.image, this.aspectRatio});

  @override
  String toString() {
    return '''ThingImg: image: $image, aspectRatio: $aspectRatio''';
  }
}

// class MyImages extends ValueNotifier<Set<ThingImg>> with OnCollections {
//   MyImages(super.value);
// }
//
// class PeopleImages extends ValueNotifier<Set<ThingImg>> with OnCollections {
//   PeopleImages(super.value);
// }

const double heightPercent = .46;

// class MyBeaches extends StatelessWidget with GetItMixin {
//   MyBeaches({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
//     final watchedImages = watch<MyImages, Set<ThingImg>>();
//
//     print('devidePixelRatio: $devicePixelRatio');
//
//     return SliverAppBar(
//       expandedHeight: screenSize.height * heightPercent,
//       stretch: true,
//       flexibleSpace: CustomScrollView(
//         cacheExtent: screenSize.width * devicePixelRatio,
//         scrollDirection: Axis.horizontal,
//         slivers: [
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                 ThingImg? thingImg;
//
//                 if (index < watchedImages.length) {
//                   thingImg = watchedImages.elementAt(index);
//                   print(watchedImages.elementAt(index));
//                 }
//
//                 return Container(
//                   width: screenSize.width * .50,
//                   child: Stack(
//                     //this is the trick so stack can stretch
//                     fit: StackFit.passthrough,
//                     children: [
//                       if (watchedImages.isNotEmpty &&
//                           index < watchedImages.length)
//                       // Placeholder()
//                         LayoutBuilder(
//                           builder: (context, constraints) => buildImage(
//                               context: context,
//                               thingImg: thingImg!,
//                               constraints: constraints),
//                         )
//                       else
//                         Placeholder(),
//                       if (index <= watchedImages.length)
//                         Center(
//                           child: TextButton(
//                             onPressed: () async {
//                               XFile? xFile;
//                               if (index.isEven) {
//                                 xFile = await ImagePicker()
//                                     .pickImage(source: ImageSource.gallery);
//                                 var stopWatch = Stopwatch()..start();
//                                 var decodedImage = await decodeImageFromList(
//                                     await xFile!.readAsBytes());
//                                 stopWatch.stop();
//                                 var decodeImageAspectRatio =
//                                 (decodedImage.width / decodedImage.height);
//                                 final imagesState = goGet<MyImages>();
//                                 imagesState.addOrReplaceAt(
//                                   index,
//                                   ThingImg(
//                                       image: xFile,
//                                       aspectRatio: decodeImageAspectRatio),
//                                 );
//                                 print(
//                                   '''decodedImage: ${xFile.name},
//                                      index: $index,
//                                      timeEllapsed: ${stopWatch.elapsedMilliseconds}ms,
//                                      decodedImage.width: ${decodedImage.width},
//                                      decodedImage.height: ${decodedImage.height},
//                                      decodeImageAspectRatio: $decodeImageAspectRatio''',
//                                 );
//                                 print(imagesState.value.elementAt(index));
//                               } else {
//                                 xFile = await ImagePicker()
//                                     .pickImage(source: ImageSource.camera);
//                                 var stopWatch = Stopwatch()..start();
//                                 var decodedImage = await decodeImageFromList(
//                                     await xFile!.readAsBytes());
//                                 stopWatch.stop();
//                                 var decodeImageAspectRatio =
//                                     decodedImage.width / decodedImage.height;
//                                 final images = goGet<MyImages>();
//                                 images.addOrReplaceAt(
//                                   index,
//                                   ThingImg(
//                                       image: xFile,
//                                       aspectRatio: decodeImageAspectRatio),
//                                 );
//                                 print(
//                                   '''decodedImage: ${xFile.name},
//                                     index: $index,
//                                     timeEllapsed: ${stopWatch.elapsedMilliseconds}ms,
//                                     decodedImage.width: ${decodedImage.width},
//                                     decodedImage.height: ${decodedImage.height},
//                                     decodeImageAspectRatio: $decodeImageAspectRatio''',
//                                 );
//                               }
//                             },
//                             child: Text('newImage'),
//                           ),
//                         ),
//                     ],
//                   ),
//                 );
//               },
//               childCount: _kDummyData.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

///https://medium.com/make-android/save-your-memory-usage-by-optimizing-network-image-in-flutter-cbc9f8af47cd#:~:text=The%20method%20for%20resizing%20images,size%20specified%20in%20these%20properties.
// class OtherPeopleBeaches extends StatelessWidget with GetItMixin {
//   OtherPeopleBeaches({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final watchedImages = watch<PeopleImages, Set<ThingImg>>();
//
//     return SliverGrid.builder(
//       itemCount: _kDummyData.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: screenSize.width / screenSize.height,
//       ),
//       itemBuilder: (context, index) {
//         ThingImg? thingImg;
//
//         if (index < watchedImages.length) {
//           thingImg = watchedImages.elementAt(index);
//           print(watchedImages.elementAt(index));
//         }
//         return Stack(
//           fit: StackFit.passthrough,
//           children: [
//             if (watchedImages.isNotEmpty && index < watchedImages.length)
//             // Placeholder()
//               LayoutBuilder(
//                 builder: (context, constraints) => buildImage(
//                     context: context,
//                     thingImg: thingImg!,
//                     constraints: constraints),
//               )
//             else
//
//             ///The size of the image displayed on the screen is determined by
//             /// the ‘width’ and ‘height’ properties, but the size of the rendered
//             /// image is determined by ‘cacheWidth’ and ‘cacheHeight’.
//               Placeholder(),
//             if (index <= watchedImages.length)
//               Center(
//                 child: TextButton(
//                   onPressed: () async {
//                     XFile? xFile;
//                     if (index.isEven) {
//                       xFile = await ImagePicker()
//                           .pickImage(source: ImageSource.gallery);
//                       var stopWatch = Stopwatch()..start();
//                       final uInt8List = await xFile!.readAsBytes();
//                       var decodedImage = await decodeImageFromList(uInt8List);
//                       stopWatch.stop();
//                       var decodeImageAspectRatio =
//                       (decodedImage.width / decodedImage.height);
//                       final imagesState = goGet<PeopleImages>();
//                       imagesState.addOrReplaceAt(
//                         index,
//                         ThingImg(
//                             image: xFile, aspectRatio: decodeImageAspectRatio),
//                       );
//                       print(
//                         '''decodedImage:
//                         name: ${xFile.name},
//                         mimeType: ${xFile.mimeType},
//                         index: $index,
//                         timeEllapsed: ${stopWatch.elapsedMilliseconds}ms,
//                         decodedImage.width: ${decodedImage.width},
//                         decodedImage.height: ${decodedImage.height},
//                         decodeImageAspectRatio: $decodeImageAspectRatio''',
//                       );
//                       print(imagesState.value.elementAt(index));
//                     } else {
//                       ///todo: uncomment
//                       // xFile = await ImagePicker()
//                       //     .pickImage(source: ImageSource.camera);
//                       ///todo: remove
//                       xFile = await ImagePicker()
//                           .pickImage(source: ImageSource.gallery);
//                       var stopWatch = Stopwatch()..start();
//                       final uInt8List = await xFile!.readAsBytes();
//                       var decodedImage = await decodeImageFromList(uInt8List);
//                       stopWatch.stop();
//                       var decodeImageAspectRatio =
//                           decodedImage.width / decodedImage.height;
//                       final imagesState = goGet<PeopleImages>();
//                       imagesState.addOrReplaceAt(
//                         index,
//                         ThingImg(
//                             image: xFile, aspectRatio: decodeImageAspectRatio),
//                       );
//                       print(
//                         '''decodedImage:
//                         name: ${xFile.name},
//                         mimeType: ${xFile.mimeType},
//                         index: $index,
//                         timeEllapsed: ${stopWatch.elapsedMilliseconds}ms,
//                         decodedImage.width: ${decodedImage.width},
//                         decodedImage.height: ${decodedImage.height},
//                         decodeImageAspectRatio: $decodeImageAspectRatio''',
//                       );
//                       print(imagesState.value.elementAt(index));
//                     }
//                   },
//                   child: Text('newImage'),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }

Image buildImage({
  required BuildContext context,
  required ThingImg thingImg,
  required BoxConstraints constraints,
}) {
  final width = constraints.maxWidth;
  final height = constraints.maxHeight;
  int? cacheWidth;
  int? cacheHeight;
  final image = thingImg.image!.path;

  if (thingImg.aspectRatio! > 1) {
    ///NOT ok
    // cacheHeight = height.renderSize(context);
    ///OK!!!
    // cacheHeight = width.renderSize(context);
    ///Ok too!!!
    // cacheWidth = width.renderSize(context);
    ///NOT ok
    cacheWidth = height.renderSize(context);
  } else {
    cacheWidth = width.renderSize(context);
    // cacheHeight = height.renderSize(context);
  }

  print('''BuildImage:
            Geometries: 
            width: $width, 
            height: $height,
            chacheWidth: $cacheWidth, 
            chacheHeight: $cacheHeight,
            aspectRatio: ${thingImg.aspectRatio}
            ''');

  return Image.file(
    File(image),
    width: width,
    height: height,
    fit: BoxFit.cover,
    cacheWidth: cacheWidth,
    cacheHeight: cacheHeight,
  );
}

// --------------------------------------------
// Below this line are helper classes and data.

const String baseAssetURL =
    'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/';
const String headerImage = '${baseAssetURL}assets/header.jpeg';

const Map<int, DailyForecast> _kDummyData = {
  0: DailyForecast(
    id: 0,
    imageId: '${baseAssetURL}assets/day_0.jpeg',
  ),
  1: DailyForecast(
    id: 1,
    imageId: headerImage,
  ),
  2: DailyForecast(
    id: 2,
    imageId: '${baseAssetURL}assets/day_2.jpeg',
  ),
  3: DailyForecast(
    id: 3,
    imageId: headerImage,
  ),
  4: DailyForecast(
    id: 4,
    imageId:
        'https://plus.unsplash.com/premium_photo-1680740103993-21639956f3f0?q=80&w=1588&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  5: DailyForecast(
    id: 5,
    imageId: headerImage,
  ),
  6: DailyForecast(
    id: 6,
    imageId: '${baseAssetURL}assets/day_6.jpeg',
  ),
  7: DailyForecast(
    id: 7,
    imageId: headerImage,
  ),
  8: DailyForecast(
    id: 8,
    imageId: '${baseAssetURL}assets/day_1.jpeg',
  ),
  9: DailyForecast(
    id: 9,
    imageId: '${baseAssetURL}assets/day_3.jpeg',
  ),
  10: DailyForecast(
    id: 10,
    imageId: '${baseAssetURL}assets/day_5.jpeg',
  ),
};

class Server {
  static List<DailyForecast> getDailyForecastList() =>
      _kDummyData.values.toList();

  static DailyForecast getDailyForecastByID(int id) {
    assert(id >= 0 && id <= _kDummyData.length - 1);
    return _kDummyData[id]!;
  }
}

class DailyForecast {
  const DailyForecast({
    required this.id,
    required this.imageId,
  });

  final int id;
  final String imageId;
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.iOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
