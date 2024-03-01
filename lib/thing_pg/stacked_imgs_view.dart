import 'package:flutter/material.dart';
import 'package:sbox1/thing_pg/cover_image_wgt.dart';

class StackedImgsView extends StatelessWidget {
  const StackedImgsView({
    super.key,
    required this.imgAsset,
    required this.cmdsWidth,
    required this.infoHeigh,
  });

  final String imgAsset;
  final double cmdsWidth;
  final double infoHeigh;

  @override
  Widget build(BuildContext context) {
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
            right: cmdsWidth,
            bottom: infoHeigh,
          ),
          child: CoverImageWgt.asset(
            imageAsset: imgAsset,
          ),
        ),
      ],
    );
  }
}
