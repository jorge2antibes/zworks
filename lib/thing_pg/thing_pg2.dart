import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:sbox1/thing_pg/constants.dart';
import 'package:sbox1/thing_pg/stacked_imgs_view.dart';
import 'package:sbox1/thing_pg/thing_cmds_view.dart';
import 'package:sbox1/thing_pg/thing_imgs_pgs.dart';

import 'cover_image_wgt.dart';

class ThingPg2 extends StatelessWidget with GetItMixin {
  ThingPg2({super.key});

  @override
  Widget build(BuildContext context) {
    // debugInvertOversizedImages = true;
    final imgAsset = 'assets/photos/5.jpg';
    final screenSize = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cmdsWidth = screenSize.width * .20;
    final cmdsHeight = cmdsWidth * 7;
    final cmdWidthHeight = screenSize.width * .10;
    final infoHeigh = screenSize.height * .25;

    debugPrint(
        'ThingPg2: screenSize. width: ${screenSize.width}, cmdsWidth: $cmdsWidth, cmdWidthHeight: $cmdWidthHeight');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenSize.height,
            flexibleSpace: ThingImgsPgs(
              imgAsset: imgAsset,
              cmdsWidth: cmdsWidth,
              infoHeigh: infoHeigh,
              cmdsHeight: cmdsHeight,
              cmdWidthHeight: cmdWidthHeight,
            ),
          ),
          SliverFillViewport(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Placeholder();
              },
              childCount: 2,
            ),
          ),
        ],
      ),
    );
  }
}