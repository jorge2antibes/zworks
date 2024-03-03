import 'package:flutter/material.dart';
import 'package:sbox1/thing_pg/cover_image_wgt.dart';

class StackedImgsView extends StatelessWidget {
  const StackedImgsView({
    super.key,
    required this.index,
    required this.imgAsset,
    required this.rightPadding,
    required this.bottomPadding,
  });

  final int index;
  final String imgAsset;
  final double rightPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    debugPrint('StackedImgsViews: build(): index: $index, cmdsWidth: $rightPadding, infoHeight: $bottomPadding');
    return Stack(
      children: [
        Opacity(
          opacity: .2,
          child: CoverImageWgt.asset(
            imageAsset: imgAsset,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: rightPadding,
            bottom: bottomPadding,
          ),
          child: CoverImageWgt.asset(
            imageAsset: imgAsset,
          ),
        ),
      ],
    );
  }
}
