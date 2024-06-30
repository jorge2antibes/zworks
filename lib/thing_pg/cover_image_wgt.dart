import 'dart:io';

import 'package:sbox1/thing_pg/extensions.dart';
import 'package:flutter/material.dart';

/// The size of the image displayed on the screen is determined by
/// the ‘width’ and ‘height’ properties, but the size of the rendered
/// image is determined by the ‘cacheWidth’ which is the width the image
/// should decode to and cache and, the ‘cacheHeight’ which is the height
/// the image should decode to and cache.
class CoverImageWgt extends StatelessWidget {
  const CoverImageWgt.file(
      {super.key, required this.imageFile, this.gestureTabCallback})
      : imageNetwork = null,
        imageAsset = null;

  const CoverImageWgt.network(
      {super.key, required this.imageNetwork, this.gestureTabCallback})
      : imageFile = null,
        imageAsset = null;

  const CoverImageWgt.asset(
      {super.key, required this.imageAsset, this.gestureTabCallback})
      : imageNetwork = null,
        imageFile = null;

  final File? imageFile;
  final String? imageNetwork;
  final String? imageAsset;
  final GestureTapCallback? gestureTabCallback;

  @override
  Widget build(BuildContext context) {
    // debugInvertOversizedImages = true;

    return LayoutBuilder(
      builder: (context, constraints) {
        final constrainedWidth = constraints.maxWidth;
        final constrainedHeight = constraints.maxHeight;
        final constrainedAspectRatio = constrainedWidth / constrainedHeight;
        int? cacheWidth;
        int? cacheHeight;

        print('''CoverImageWgt:
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

        if (constrainedAspectRatio < 1) {
          cacheWidth = constrainedWidth.renderSize(context);
        } else if (constrainedAspectRatio > 1) {
          cacheHeight = constrainedHeight.renderSize(context);
        } else {
          cacheWidth = constrainedWidth.renderSize(context);
          cacheHeight = constrainedHeight.renderSize(context);
        }

        print('''CoverImageWgt:
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
              fit: BoxFit.cover,
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
              fit: BoxFit.cover,
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
              fit: BoxFit.cover,
              width: constrainedWidth,
              height: constrainedHeight,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
            ),
          );
        } else {
          throw Exception(
              'CoverImageWgt: neither Image.file nor Image.network nor Image.asset');
        }
      },
    );
  }
}
