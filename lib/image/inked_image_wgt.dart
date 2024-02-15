import 'dart:io';

import 'package:flutter/material.dart';

/// This is a solution to avoid the app bugged down while sliding myThings view
/// (apparently for memory problems)
/// Normally I should pass to the Ink.image an ImageProvider i.e. image:
/// FileImage(File(imgPath)), But that does not provide cache's
/// functionalities to the image. The ImageProvider by itself does not
/// configure image caches for efficiency. The solution must be to create
/// an ImageProvider out of the Image.file() widget which will be
/// passed back to the Ink.image with cacheHeight or cacheWidth configure.
/// i.e. image: Image.file(...cacheHeight...).image as image provider.
/// See dead code bellow
class InkedImageWgt extends StatelessWidget {
  const InkedImageWgt({
    super.key,
    required this.imgPath,
    this.fit,
    this.onTap,
    this.child,
  });

  final String imgPath;
  final BoxFit? fit;
  final void Function()? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink.image(
        fit: fit,
        image: Image.file(
          File(imgPath),
          cacheHeight: 1000,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('InkedImageWgt: error: ${error}');
            debugPrintStack(stackTrace: stackTrace);
            return const Placeholder(color: Colors.blue);
          },
        ).image,
        child: InkWell(
          onTap: onTap ?? () => debugPrint('InkedImageWgt: build(): InkWell.onTap() called! but no ontap function as parameter'),
          child: child,
        ),
      ),
    );
  }
}
