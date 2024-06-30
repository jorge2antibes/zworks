import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// {@template animated_svg}
/// [AnimatedSvgTxtIcon] Widget
///
/// Flutter package for displaying and animating Scalable Vector Graphics 1.1
/// files.
///
/// ```dart
/// AnimatedSvgTxtIcon(
///   controller: AnimatedSvgTxtIconController(),
///   size: 80,
///   children: [
///     SvgPicture.asset('assets/play.svg'),
///     SvgPicture.asset('assets/pause.svg'),
///   ],
/// )
/// ```
/// {@endtemplate}
class AnimatedSvgTxtIcon extends StatefulWidget {
  /// {@macro animated_svg}
  const AnimatedSvgTxtIcon({
    required this.controller,
    required this.children,
    super.key,
    this.onTap,
    this.svgSize = 24.0,
    this.sizePercent = 20.0,
    this.duration = const Duration(milliseconds: 500),
    this.clockwise = true,
    this.isActive = true,
  })  : assert(children.length == 2, _kRequiredChildrenAssertMessage);

  /// A [controller] class that provides full control over the SVGs.
  final SvgController controller;

  /// A list of SVGs required to draw and animate.
  ///
  /// Only two [children] are required therefore more or less than number of
  /// SVGs will throw an error.
  final List<List<Widget>> children;

  /// [onTap] Function that provides you the ability to control tap action.
  ///
  /// With this function, you can easily assign tasks to the widget.
  final void Function()? onTap;

  /// A variable to determine the [svgSize] of the AnimatedSvgTxtIcon.
  ///
  /// Default value is 24.0.
  final double svgSize;

  /// A variable to determine the percentage of  [svgSize] that will be assigned to
  /// text part
  /// Default value is 20
  final double sizePercent;

  /// A variable to determine the [duration] of the animation.
  ///
  /// Default value is Duration(milliseconds: 500).
  final Duration duration;

  /// A variable to determine the direction of the animation.
  ///
  /// Default value is true.
  final bool clockwise;

  /// A variable to set the state of the widget.
  ///
  /// Default value is true.
  final bool isActive;

  @override
  State<AnimatedSvgTxtIcon> createState() => _AnimatedSvgTxtIconState();
}

class _AnimatedSvgTxtIconState extends State<AnimatedSvgTxtIcon> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Initializing the controller and adding listener.
    widget.controller
      ..init(AnimationController(vsync: this, duration: widget.duration))
      ..addListener(listener);
  }

  /// [listener] method for [SvgController]
  ///
  /// This will help to update the state.
  void listener() {
    if (!mounted) return;

    setState(() {});
  }

  @override
  void dispose() {
    // Removing listener and dispose
    widget.controller
      ..removeListener(listener)
      ..dispose();

    super.dispose();
  }

  /// [onTap] Tasks
  ///
  /// [onTap] parameter of [AnimatedSvgTxtIcon] will also be executed,
  /// if it is not null.
  void onTap() {
    if (!widget.isActive) return; //No active so do not execute
    if (widget.controller.isAnimating) return; // It is animating thus, do not execute

    widget.onTap?.call(); // yes, call it

    if (widget.controller.isCompleted) {
      widget.controller.reverse(); // switch to initial state
    } else {
      widget.controller.forward(); // switch to triggered state
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: drawSvgTxtBoxes(),
      ),
    );
  }

  /// Get values from [SvgController] and return list of [SvgTxtBox].
  List<Widget> drawSvgTxtBoxes() {
    final children = <Widget>[];
    final controllerValueX = widget.controller.value;
    final controllerValueY = 1.0 - widget.controller.value;
    final angleX = math.pi / 180.0 * (180.0 * controllerValueX);
    final angleY = math.pi / 180.0 * (180.0 * controllerValueY);

    //
    if (controllerValueX == 1.0 && controllerValueY == 0.0) {
      children.add(
        //opaque
        SvgTxtBox(
          svgPicOrText: widget.children[0][0],
          angle: widget.clockwise ? -angleY : angleY,
          opacity: controllerValueX,
          svgSize: widget.svgSize,
          sizePercent: widget.sizePercent,
        ),
      );
      if (widget.children[0].length == 2) {
        children.add(
          //opaque
          SvgTxtBox(
            svgPicOrText: widget.children[0][1],
            angle: widget.clockwise ? -angleY : angleY,
            opacity: controllerValueX,
            svgSize: widget.svgSize,
            sizePercent: widget.sizePercent,
          ),
        );
      }
    } else {
      children.add(
        //visible
        SvgTxtBox(
          svgPicOrText: widget.children[1][0],
          angle: widget.clockwise ? angleX : -angleX,
          opacity: controllerValueY,
          svgSize: widget.svgSize,
          sizePercent: widget.sizePercent,
        ),
      );
      if (widget.children[1].length == 2) {
        children.add(
          //visible
          SvgTxtBox(
            svgPicOrText: widget.children[1][1],
            angle: widget.clockwise ? angleX : -angleX,
            opacity: controllerValueY,
            svgSize: widget.svgSize,
            sizePercent: widget.sizePercent,
          ),
        );
      }
    }

    if (controllerValueX == 0.0 && controllerValueY == 1.0) {
      children.add(
        //opaque
        SvgTxtBox(
          svgPicOrText: widget.children[1][0],
          angle: widget.clockwise ? angleX : -angleX,
          opacity: controllerValueY,
          svgSize: widget.svgSize,
          sizePercent: widget.sizePercent,
        ),
      );
      if (widget.children[1].length == 2) {
        children.add(
          //opaque
          SvgTxtBox(
            svgPicOrText: widget.children[1][1],
            angle: widget.clockwise ? angleX : -angleX,
            opacity: controllerValueY,
            svgSize: widget.svgSize,
            sizePercent: widget.sizePercent,
          ),
        );
      }
    } else {
      children.add(
        //visible
        SvgTxtBox(
          svgPicOrText: widget.children[0][0],
          angle: widget.clockwise ? -angleY : angleY,
          opacity: controllerValueX,
          svgSize: widget.svgSize,
          sizePercent: widget.sizePercent,
        ),
      );
      if (widget.children[0].length == 2) {
        children.add(
          //visible
          SvgTxtBox(
            svgPicOrText: widget.children[0][1],
            angle: widget.clockwise ? -angleY : angleY,
            opacity: controllerValueX,
            svgSize: widget.svgSize,
            sizePercent: widget.sizePercent,
          ),
        );
      }
    }

    return children;
  }
}

/// {@template svg_box}
/// [SvgTxtBox] Widget
///
/// StatelessWidget to create single SvgBox with required
/// angle, opacity and size.
/// {@endtemplate}
@visibleForTesting
class SvgTxtBox extends StatelessWidget {
  /// {@macro svg_box}
  const SvgTxtBox({
    required this.svgPicOrText,
    required this.angle,
    required this.opacity,
    required this.svgSize,
    required this.sizePercent,
    super.key,
  });

  /// A variable to determine the [svgPicOrText] of the SvgBox.
  ///
  /// This [SvgPicture] will be converted into [SvgTxtBox] with
  /// the expected angle, opacity and size.
  final Widget svgPicOrText;

  /// A variable to determine the [angle] of the SvgBox.
  final double angle;

  /// A variable to determine the [opacity] of the SvgBox.
  final double opacity;

  /// A variable to determine the [svgSize] of the SvgBox.
  final double svgSize;

  /// A variable to determine the percentage of [svgSize] that will apply to the
  /// container of Text().
  final double sizePercent;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Opacity(
        opacity: opacity,
        child: SizedBox(
          height: svgSize,
          width: svgSize,
          child: svgPicOrText is SvgPicture
              ? FittedBox(
                  child: svgPicOrText,
                )
              : Container(
                  alignment: Alignment.topCenter,
                  width: sizePercent,
                  height: sizePercent,
                  child: svgPicOrText,
                ),
        ),
      ),
    );
  }
}

/// Assertion message to show required children count.
const _kRequiredChildrenAssertMessage =
    'AnimatedSvgTxtIcon: It is required to provide only 2 SvgPicture and 0 or 1 background widget as children!';

/// [SvgController]
///
/// A controller class that provides full control over the SVGs.
abstract class SvgController {
  /// A getter that provides the current [value] of the controller.
  double get value;

  /// A getter that returns true if the animation is running.
  bool get isAnimating;

  /// A getter that returns true if the animation is completed.
  bool get isCompleted;

  /// A method to initialize SvgController.
  ///
  /// This needs to be called before everything else.
  void init(AnimationController controller);

  /// A method to run animation in the [forward] direction.
  bool forward();

  /// A method to run animation in the [reverse] direction.
  bool reverse();

  /// A method to add a [listener] to the controller.
  void addListener(void Function() listener);

  /// A method to remove a [listener] from the controller.
  void removeListener(void Function() listener);

  /// A method to [dispose] SvgController.
  ///
  /// Do not forget to call this method when you are done with this controller!
  /// A suggested place to call this method would be the "dispose" method of
  /// the StatefulWidget.
  void dispose();
}

/// {@template animated_svg_controller}
/// [AnimatedSvgTxtIconController]
///
/// A controller class that provides full control over the SVGs.
/// {@endtemplate}
class AnimatedSvgTxtIconController implements SvgController {
  /// {@macro animated_svg_controller}
  AnimatedSvgTxtIconController();

  /// An animation controller
  AnimationController? _controller;

  @override
  double get value => _controller != null ? _controller!.value : 0.0;

  @override
  bool get isAnimating {
    if (_controller == null) return false;

    return _controller!.value > 0.0 && _controller!.value < 1.0;
  }

  @override
  bool get isCompleted => _controller?.value == 1.0;

  @override
  void init(AnimationController controller) {
    if (_controller != null) return;

    _controller = controller;
  }

  @override
  bool forward() {
    if (_controller == null) return false;

    _controller!.forward();
    return true;
  }

  @override
  bool reverse() {
    if (_controller == null) return false;

    _controller!.reverse();
    return true;
  }

  @override
  void addListener(void Function() listener) {
    if (_controller == null) return;

    _controller!.addListener(listener);
  }

  @override
  void removeListener(void Function() listener) {
    if (_controller == null) return;

    _controller!.removeListener(listener);
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
      _controller = null;
    }
  }
}
