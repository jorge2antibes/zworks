import 'package:flutter/material.dart';
import 'package:sbox1/thing_pg/stacked_imgs_collapsable_view.dart';
import 'package:sbox1/thing_pg/thing_cmds_view.dart';

import 'constants.dart';

class ThingImgsCmdsPgs extends StatelessWidget {
  const ThingImgsCmdsPgs({
    super.key,
    required this.imgAsset,
    required this.cmdsWidth,
    required this.infoHeigh,
    required this.cmdsHeight,
    required this.cmdWidthHeight,
  });

  final String imgAsset;
  final double cmdsWidth;
  final double infoHeigh;
  final double cmdsHeight;
  final double cmdWidthHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: maxImgsItemCount,
          itemBuilder: (context, index) {
            return StackedImgsCollapsableView(
              index: index,
              imgAsset: imgAsset,
              rightPadding: cmdsWidth,
              bottomPadding: infoHeigh,
            );
          },
        ),
        Positioned(
          width: cmdsWidth - (cmdsWidth * .35),
          right: cmdsWidth * .16,
          bottom: 250,
          child: ThingCmdsView(
            cmdsHeight: cmdsHeight,
            cmdWidthHeight: cmdWidthHeight,
          ),
        ),
      ],
    );
  }
}
