import 'package:flutter/material.dart';
import 'package:sbox1/thing_pg/collapsable_img_wgt.dart';

class StackedImgsCollapsableView extends StatelessWidget {
  const StackedImgsCollapsableView({
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
    debugPrint('StackedImgsCollapsableViews: build(): index: $index, cmdsWidth: $rightPadding, infoHeight: $bottomPadding');
    return Stack(
      children: [
        Opacity(
          opacity: .2,
          child: CollapsableImgWgt.asset(
            imageAsset: imgAsset,
            wgtAspRat: WgtAspRat.vertical,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: rightPadding,
            bottom: bottomPadding,
          ),
          child: CollapsableImgWgt.asset(
            imageAsset: imgAsset,
            wgtAspRat: WgtAspRat.vertical,
          ),
        ),
      ],
    );
  }
}
