import 'package:flutter/material.dart';

extension ImageExtension on num {
  int renderSize(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final dimensionLength = (this * devicePixelRatio).round();
    print('ImageExtension: renderSize: devicePixelRatio: $devicePixelRatio, dimensionLength: $dimensionLength');
    return dimensionLength;
  }
}