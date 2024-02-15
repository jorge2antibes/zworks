import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sbox1/ayay_to_slivers/extensions.dart';

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
            imageNetwork!,
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
