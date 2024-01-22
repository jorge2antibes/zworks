import 'package:flutter/material.dart';

extension ImageExtension on num {
  int renderSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}