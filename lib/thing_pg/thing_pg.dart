import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import 'cover_image_wgt.dart';

class ThingPg extends StatelessWidget with GetItMixin {
  ThingPg({super.key});

  @override
  Widget build(BuildContext context) {
    // debugInvertOversizedImages = true;
    final imgAsset = 'assets/photos/5.jpg';
    final screenSize = MediaQuery.of(context).size;
    final cmdsWidth = screenSize.width * .20;
    final cmdsHeight = cmdsWidth * 5;
    final cmdWidthHeight = screenSize.width * .12;
    final infoHeigh = screenSize.height * .25;

    debugPrint(
        'ThingPg: screenSize. width: ${screenSize.width}, cmdsWidth: $cmdsWidth, cmdWidthHeight: $cmdWidthHeight');

    return Scaffold(
      body: Stack(
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
          Positioned(
            width: cmdsWidth - (cmdsWidth * .35),
            right: cmdsWidth * .16,
            bottom: 250,
            child: Container(
              width: 50,
              height: cmdsHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: cmdWidthHeight,
                      height: cmdWidthHeight,
                      child: SvgPicture.asset(
                        'assets/svgs/envelope_closed.svg',
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: cmdWidthHeight,
                      height: cmdWidthHeight,
                      child: SvgPicture.asset(
                        'assets/svgs/envelope_opened.svg',
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: cmdWidthHeight,
                      height: cmdWidthHeight,
                      child: SvgPicture.asset(
                        'assets/svgs/envelope_with_mail.svg',
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: cmdWidthHeight,
                      height: cmdWidthHeight,
                      child: SvgPicture.asset(
                        'assets/svgs/gallery.svg',
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: cmdWidthHeight,
                      height: cmdWidthHeight,
                      child: SvgPicture.asset(
                        'assets/svgs/camera.svg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
