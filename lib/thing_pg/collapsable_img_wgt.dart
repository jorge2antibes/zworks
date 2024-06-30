import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sbox1/ayay_to_slivers/extensions.dart';

enum WgtAspRat {
  vertical,
  Horizontal,
}

/// The size of the image displayed on the screen is determined by
/// the ‘width’ and ‘height’ properties, but the size of the rendered
/// image is determined by the ‘cacheWidth’ which is the width the image
/// should decode to and cache and, the ‘cacheHeight’ which is the height
/// the image should decode to and cache.
class CollapsableImgWgt extends StatelessWidget {
  CollapsableImgWgt.file(
      {super.key,
      required this.imageFile,
      required this.wgtAspRat,
      this.gestureTabCallback})
      : imageNetwork = null,
        imageAsset = null;

  CollapsableImgWgt.network(
      {super.key,
      required this.imageNetwork,
      required this.wgtAspRat,
      this.gestureTabCallback})
      : imageFile = null,
        imageAsset = null;

  CollapsableImgWgt.asset(
      {super.key,
      required this.imageAsset,
      required this.wgtAspRat,
      this.gestureTabCallback})
      : imageNetwork = null,
        imageFile = null;

  final File? imageFile;
  final String? imageNetwork;
  final String? imageAsset;
  final WgtAspRat wgtAspRat;
  final GestureTapCallback? gestureTabCallback;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final constrainedWidth = constraints.maxWidth;
        final constrainedHeight = constraints.maxHeight;
        final constrainedAspectRatio = constrainedWidth / constrainedHeight;
        int? cacheWidth;
        int? cacheHeight;

        print('''CollapsableImgWgt:
            Constrains:
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
        if (wgtAspRat == WgtAspRat.vertical) {
          cacheWidth = constrainedWidth.renderSize(context);
        } else {
          cacheHeight = constrainedHeight.renderSize(context);
        }

        print('''CollapsableImgWgt:
            Geometries: 
            constrainedWidth: $constrainedWidth, 
            constrainedHeight: $constrainedHeight,
            chacheWidth: $cacheWidth, 
            chacheHeight: $cacheHeight,
            constrainedAspectRatio: $constrainedAspectRatio,
            ''');

        if (imageFile != null) {
          return InkWell(
            onTap: gestureTabCallback,
            child: Image.file(
              imageFile!,
              fit: wgtAspRat == WgtAspRat.vertical
                  ? BoxFit.fitHeight
                  : BoxFit.fitWidth,
              width: constrainedWidth,
              height: constrainedHeight,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
            ),
          );
        } else if (imageNetwork != null) {
          return InkWell(
            onTap: gestureTabCallback,
            child: Image.network(
              imageNetwork!,
              fit: wgtAspRat == WgtAspRat.vertical
                  ? BoxFit.fitHeight
                  : BoxFit.fitWidth,
              width: constrainedWidth,
              height: constrainedHeight,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
            ),
          );
        } else if (imageAsset != null) {
          return InkWell(
            onTap: gestureTabCallback,
            child: Image.asset(
              imageAsset!,
              fit: wgtAspRat == WgtAspRat.vertical
                  ? BoxFit.fitHeight
                  : BoxFit.fitWidth,
              width: constrainedWidth,
              height: constrainedHeight,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
            ),
          );
        } else {
          throw Exception(
              'CollapsableImgWgt: neither Image.file nor Image.network nor Image.asset');
        }
      },
    );
  }
}
