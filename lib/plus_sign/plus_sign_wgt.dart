import 'dart:math';

//todo
// import 'package:ayayay/logics/plus_sign.dart';
// import 'package:ayayay/logics/plus_sign_state.dart';
// import 'package:ayayay/uis/widgets/camera_or_gallery_row_wgt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:sbox1/plus_sign/camera_or_gallery_row_wgt.dart';

class PlusSignWgt extends StatefulWidget with GetItStatefulWidgetMixin {
  PlusSignWgt(
      {super.key,
        //todo
      // required this.state,
      this.width = 120,
      this.height = 200,
      this.color});

  final Color? color;
  //todo
  // final PlusSignState state;
  final double width;
  final double height;

  @override
  State<PlusSignWgt> createState() => _PlusSignWgtState();
}

class _PlusSignWgtState extends State<PlusSignWgt>
    with GetItStateMixin, SingleTickerProviderStateMixin {
  late AnimationController plusAnimationController;

  @override
  void initState() {
    super.initState();

    plusAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    //todo
    // widget.state.notifyController(controller: plusAnimationController);
  }

  @override
  void dispose() {
    plusAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //todo
    // var plusSign = watch<PlusSignState, PlusSign>(target: widget.state);
    // var color = plusSign.cmdsOn ? Colors.red : widget.color ?? Colors.white;
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(children: [
        if (true)
          //todo
          // if (plusSign.cmdsOn)
          CameraOrGalleryRowWgt(
            //todo
            // state: widget.state.cmdState(inamed: widget.state.value.inamed),
            width: widget.width,
            height: widget.height,
          ),
        Positioned(
          left: widget.width * .10,
          right: widget.width * .10,
          bottom: widget.height * .01,
          height: widget.height * .50,
          child: UnconstrainedBox(
            child: AnimatedBuilder(
              animation: plusAnimationController,
              builder: (context, child) {
                var radAnimation = pi / 4 * plusAnimationController.value;
                return ElevatedButtonTheme(
                  data: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(
                        widget.width * .10,
                      ),
                      shape: CircleBorder(),
                      backgroundColor: Colors.black45,
                    ),
                  ),
                  child: Transform.rotate(
                    angle: radAnimation,
                    // angle: rotationAngle,
                    child: ElevatedButton(
                      onPressed: () => print('PlusSignWgt: onPressed(): pressed'),
                      //todo
                      // onPressed: plusSign.plusIsEnabled
                      //     ? widget.state.onPressPlus
                      //     : null,
                      child: SvgPicture.asset(
                        'assets/svgs/plus.svg',
                        width: widget.width * .20,
                        height: widget.height * .20,
                        //todo
                        // colorFilter: ColorFilter.mode(
                        //   plusSign.cmdsOn
                        //       ? Colors.red
                        //       : widget.color ?? Colors.white,
                        //   // color,
                        //   BlendMode.srcATop,
                        // ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
