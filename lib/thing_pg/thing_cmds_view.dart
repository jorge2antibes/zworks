
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

class ThingCmdsView extends StatelessWidget {
  const ThingCmdsView({
    super.key,
    required this.cmdsHeight,
    required this.cmdWidthHeight,
  });

  final double cmdsHeight;
  final double cmdWidthHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'assets/svgs_at_things/envelope_closed.svg',
              ),
            ),
          ),
          Center(
            child: Container(
              width: cmdWidthHeight,
              height: cmdWidthHeight,
              child: SvgPicture.asset(
                'assets/svgs_at_things/envelope_opened.svg',
              ),
            ),
          ),
          Center(
            child: Container(
              width: cmdWidthHeight,
              height: cmdWidthHeight,
              child: SvgPicture.asset(
                'assets/svgs_at_things/envelope_with_mail.svg',
              ),
            ),
          ),
          Center(
            child: Container(
              width: cmdWidthHeight,
              height: cmdWidthHeight,
              child: SvgPicture.asset(
                'assets/svgs_at_things/gallery.svg',
              ),
            ),
          ),
          Center(
            child: Container(
              width: cmdWidthHeight,
              height: cmdWidthHeight,
              child: SvgPicture.asset(
                'assets/svgs_at_things/camera.svg',
              ),
            ),
          ),
          Center(
            child: Container(
              width: cmdWidthHeight,
              height: cmdWidthHeight,
              child: SvgPicture.asset(
                'assets/svgs_at_things/messages.svg',
              ),
            ),
          ),
          Center(
            child: Container(
              width: cmdWidthHeight,
              height: cmdWidthHeight,
              child: SvgPicture.asset(
                'assets/svgs_at_things/edit.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
