import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:sbox1/this_thing_pg/this_thing_pg.dart';

import 'cover_image_wgt.dart';
import 'errors.dart';

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
