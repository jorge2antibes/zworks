import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:sbox1/thing_pg/stacked_imgs_view.dart';
import 'package:sbox1/thing_pg/thing_cmds_view.dart';

import 'cover_image_wgt.dart';

class ThingPg extends StatelessWidget with GetItMixin {
  ThingPg({super.key});

  @override
  Widget build(BuildContext context) {
    // debugInvertOversizedImages = true;
    final imgAsset = 'assets/photos/5.jpg';
    final screenSize = MediaQuery.of(context).size;
    final cmdsWidth = screenSize.width * .20;
    final cmdsHeight = cmdsWidth * 7;
    final cmdWidthHeight = screenSize.width * .10;
    final infoHeigh = screenSize.height * .25;

    debugPrint(
        'ThingPg: screenSize. width: ${screenSize.width}, cmdsWidth: $cmdsWidth, cmdWidthHeight: $cmdWidthHeight');

    return Scaffold(
      body: Stack(
        children: [
          StackedImgsView(
            imgAsset: imgAsset,
            cmdsWidth: cmdsWidth,
            infoHeigh: infoHeigh,
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
      ),
    );
  }
}
