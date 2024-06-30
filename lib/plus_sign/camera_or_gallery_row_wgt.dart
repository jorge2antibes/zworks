// import 'package:ayayay/logics/cmd_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CameraOrGalleryRowWgt extends StatelessWidget {
  const CameraOrGalleryRowWgt({
    super.key,
    //todo
    // required this.state,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  // final CmdState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * .50,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(6),
      ),
      // alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              shape: const CircleBorder(),
              minimumSize: const Size(20, 20),
              padding: EdgeInsets.zero,
            ),
            onPressed: () async => print('CameraOrGalleryRowWgt: onPressed(): onLeftClickEvent()'),
            //todo
            // onPressed: () async => state.onLeftClickEvent(),
            child: SvgPicture.asset(
              'assets/svgs_at_things/gallery.svg',
              width: width * .25,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcATop),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              shape: const CircleBorder(),
              minimumSize: const Size(25, 25),
              padding: EdgeInsets.zero,
            ),
            onPressed: () async => print('CameraOrGalleryRowWgt: onPressed(): onRightClickEvent()'),
            //todo
            // onPressed: () async => state.onRightClickEvent(),
            child: SvgPicture.asset(
              'assets/svgs_at_things/camera.svg',
              width: width * .28,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcATop),
            ),
          ),
        ],
      ),
    );
  }
}
