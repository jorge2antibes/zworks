import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:sbox1/this_thing_pg/cover_image_wgt.dart';
import 'package:sbox1/this_thing_pg/errors.dart';
import 'package:sbox1/this_thing_pg/this_thing_pg.dart';

final thingImages = <String>{
  'assets/photos/0.jpg',
  'assets/photos/1.jpg',
  'assets/photos/2.jpg',
};

final goGet = GetIt.instance;

class ScaleState extends ValueNotifier<bool> {
  /// Notice that here I'm using super._scaleIn as initial argument. However, the real parameter name is _value in ValueNotifier
  /// It is a curiosity to me, it seems that I can use whatever name I want as an argument to the constructor of the super class
  ScaleState(super._scaleIn);

  bool get scaleIn => value = true;

  bool get scaleOut => value = false;

  bool get couldScaleIn => value == false ? true : false;

  bool get couldScaleOut => value == true ? true : false;

  void set scaleIn(bool newVal) => value = newVal;
}

void main() {
  goGet.registerLazySingleton<ScaleState>(() => ScaleState(false));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'implicit scale animation',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.purple),
      home: TheTest(),
    );
  }
}

class TheTest extends StatelessWidget {
  const TheTest({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('implicit scale animation'),
      ),
      body: GestureDetector(
        onTap: () => goGet<ScaleState>().scaleIn,
        child: ThisThingImgsVw(images: thingImages, imgWidth: screenSize.width * .80, imgHeight: screenSize.height * .75),
      ),
    );
  }
}

class ThisThingImgsVw extends StatefulWidget with GetItStatefulWidgetMixin {
  ThisThingImgsVw({
    super.key,
    required this.images,
    required this.imgWidth,
    required this.imgHeight,
  });

  final Set<String> images;
  final double imgWidth;
  final double imgHeight;

  @override
  State<ThisThingImgsVw> createState() => _ThisThingImgsVwState();
}

class _ThisThingImgsVwState extends State<ThisThingImgsVw> with SingleTickerProviderStateMixin, GetItStateMixin<ThisThingImgsVw> {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var shouldScale = watch<ScaleState, bool>();

    return PageView.builder(
      itemCount: widget.images.length,
      itemBuilder: (context, index) {
        final imgName = widget.images.isNotEmpty ? widget.images.elementAt(index) : throw NoLocalImgsError();
        // print('ThisThingImgsVw: build(): imagePath: $imgPath');
        // print('ThisThingImgsVw: build(): imageFile: $imgFile');
        return Stack(
          children: [
            Opacity(
              opacity: .5,
              child: CoverImageWgt.asset(
                alignment: Alignment.topLeft,
                imageAsset: imgName,
              ),
            ),
            AnimatedScale(
              alignment: Alignment.topLeft,
              duration: const Duration(milliseconds: 270),
              scale: shouldScale ? .75 : 1.0,
              child: Container(
                width: widget.imgWidth,
                height: widget.imgHeight,
                child: CoverImageWgt.asset(
                  imageAsset: imgName,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
