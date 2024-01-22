import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbox1/ayay_to_slivers/extensions.dart';
import 'package:sbox1/ayay_to_slivers/for_valueNotifier_on_Set.dart';

///https://stackoverflow.com/questions/67597902/how-to-detect-if-an-image-is-vertical-or-horizontal
/// https://dartpad-workshops-io2021.web.app/getting_started_with_slivers
/// https://medium.com/make-android/save-your-memory-usage-by-optimizing-network-image-in-flutter-cbc9f8af47cd#:~:text=The%20method%20for%20resizing%20images,size%20specified%20in%20these%20properties.
void main() {
  debugInvertOversizedImages = true;
  bootstrap();
  runApp(const Ayay1());
}

class Ayay1 extends StatelessWidget {
  const Ayay1({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      scrollBehavior: const ConstantScrollBehavior(),
      title: 'Ayay1',
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomScrollView(
              slivers: [
                MyBeaches(),
                OtherPeopleBeaches(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final goGet = GetIt.I;

void bootstrap() {
  goGet.registerSingleton<MyImages>(MyImages(<ImgPicked>{}));

  goGet.registerSingleton<PeopleImages>(PeopleImages(<ImgPicked>{}));
}

class ImgPicked {
  final XFile? image;
  final double? aspectRatio;

  ImgPicked({this.image, this.aspectRatio});

  @override
  String toString() {
    return '''ImgPicked: image: $image, aspectRatio: $aspectRatio''';
  }
}

class MyImages extends ValueNotifier<Set<ImgPicked>> with OnCollections {
  MyImages(super.value);
}

class PeopleImages extends ValueNotifier<Set<ImgPicked>> with OnCollections {
  PeopleImages(super.value);
}

const double heightPercent = .46;

class MyBeaches extends StatelessWidget with GetItMixin {
  MyBeaches({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final myImages = watch<MyImages, Set<ImgPicked>>();

    print('devidePixelRatio: $devicePixelRatio');

    return SliverAppBar(
      expandedHeight: screenSize.height * heightPercent,
      stretch: true,
      flexibleSpace: CustomScrollView(
        cacheExtent: screenSize.width * devicePixelRatio,
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final DailyForecast dailyForecast =
                    Server.getDailyForecastByID(index);
                return Container(
                  width: screenSize.width * .50,
                  child: Stack(
                    //this is the trick so stack can stretch
                    fit: StackFit.passthrough,
                    children: [
                      Image.network(
                        // cacheWidth: screenSize.width.cacheSize(context),
                        // cacheHeight: screenSize.height.cacheSize(context),
                        dailyForecast.imageId,
                        fit: BoxFit.cover,
                      ),
                      Placeholder(),
                    ],
                  ),
                );
              },
              childCount: _kDummyData.length,
            ),
          ),
        ],
      ),
    );
  }
}

///https://medium.com/make-android/save-your-memory-usage-by-optimizing-network-image-in-flutter-cbc9f8af47cd#:~:text=The%20method%20for%20resizing%20images,size%20specified%20in%20these%20properties.
class OtherPeopleBeaches extends StatelessWidget with GetItMixin {
  OtherPeopleBeaches({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final watchedImages = watch<PeopleImages, Set<ImgPicked>>();

    return SliverGrid.builder(
      itemCount: _kDummyData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: screenSize.width / screenSize.height,
      ),
      itemBuilder: (context, index) {
        final DailyForecast dailyForecast = Server.getDailyForecastByID(index);
        final width = screenSize.width / 2;
        final height = screenSize.height / 2;
        final cacheWidth = width.renderSize(context);
        final cacheHeight = height.renderSize(context);
        final imageFile = File(watchedImages.elementAt(index).image!.path);
        final imageAspectRatio = watchedImages.elementAt(index).aspectRatio;

        print('''Geometries: 
            devicePixelRatio: $devicePixelRatio, 
            index: $index, 
            width: $width, 
            height: $height,
            chacheWidth: $cacheWidth, 
            chacheHeight: $cacheHeight''');

        if (index < watchedImages.length) {
          print(watchedImages.elementAt(index));
        }
        return Stack(
          fit: StackFit.passthrough,
          children: [
            if (watchedImages.isNotEmpty && index < watchedImages.length)
              // Placeholder()
              LayoutBuilder(
                builder: (context, constraints) => catchImage(
                    context: context,
                    image: imageFile,
                    aspectRatio: imageAspectRatio!,
                    constraints: constraints),
              )
            else

              ///The size of the image displayed on the screen is determined by
              /// the ‘width’ and ‘height’ properties, but the size of the rendered
              /// image is determined by ‘cacheWidth’ and ‘cacheHeight’.
              Image.network(
                // width: width,
                // height: height,
                // cacheWidth: 360.cacheSize(context),
                // cacheHeight: 718.cacheSize(context),
                // cacheHeight: 718,
                // cacheWidth: cacheWidth.round(),
                // cacheHeight: cacheHeight.round(),
                dailyForecast.imageId,
                fit: BoxFit.cover,
              ),
            if (index == watchedImages.length)
              Center(
                child: TextButton(
                  onPressed: () async {
                    XFile? xFile;
                    if (index.isEven) {
                      xFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      var stopWatch = Stopwatch()..start();
                      var decodedImage =
                          await decodeImageFromList(await xFile!.readAsBytes());
                      stopWatch.stop();
                      var decodeImageAspectRatio =
                          (decodedImage.width / decodedImage.height);
                      final imagesState = goGet<PeopleImages>();
                      imagesState.addOrReplaceAt(
                        index,
                        ImgPicked(
                            image: xFile, aspectRatio: decodeImageAspectRatio),
                      );
                      print(
                        '''decodedImage: ${xFile.name}, 
                      index: $index, 
                      timeEllapsed: ${stopWatch.elapsedMilliseconds}ms, 
                      decodedImage.width: ${decodedImage.width}, 
                      decodedImage.height: ${decodedImage.height},
                      decodeImageAspectRatio: $decodeImageAspectRatio''',
                      );
                      print(imagesState.value.elementAt(index));
                    } else {
                      xFile = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      var stopWatch = Stopwatch()..start();
                      var decodedImage =
                          await decodeImageFromList(await xFile!.readAsBytes());
                      stopWatch.stop();
                      var decodeImageAspectRatio =
                          decodedImage.width / decodedImage.height;
                      final images = goGet<PeopleImages>();
                      images.addOrReplaceAt(
                        index,
                        ImgPicked(
                            image: xFile, aspectRatio: decodeImageAspectRatio),
                      );
                      print(
                        '''decodedImage: ${xFile.name}, 
                      index: $index, 
                      timeEllapsed: ${stopWatch.elapsedMilliseconds}ms, 
                      decodedImage.width: ${decodedImage.width}, 
                      decodedImage.height: ${decodedImage.height},
                      decodeImageAspectRatio: $decodeImageAspectRatio''',
                      );
                    }
                  },
                  child: Text('newImage'),
                ),
              ),
          ],
        );
      },
    );
  }
}

Image catchImage({
  required BuildContext context,
  required File image,
  required double aspectRatio,
  required BoxConstraints constraints,
}) {
  final width = constraints.maxWidth;
  final height = constraints.maxHeight;
  int? cacheWidth;
  int? cacheHeight;

  if (aspectRatio > 0) {
    cacheHeight = height.renderSize(context);
  } else {
    cacheWidth = width.renderSize(context);
  }

  return Image.file(
    image,
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
