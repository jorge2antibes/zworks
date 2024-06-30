import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'animated_svg_icon_lib.dart';

class AnimatedSvgIconWgt extends StatefulWidget {
  const AnimatedSvgIconWgt({
    super.key,
    required this.pictures,
    this.size,
    this.clockwise,
    this.isActive,
    this.duration,
    this.onTap,
  });

  final List<List<Widget>> pictures;
  final double? size;
  final bool? clockwise;
  final bool? isActive;
  final Duration? duration;
  final void Function()? onTap;

  @override
  State<AnimatedSvgIconWgt> createState() => _AnimatedSvgIconWgtState();
}

class _AnimatedSvgIconWgtState extends State<AnimatedSvgIconWgt> {
  late final SvgController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimatedSvgTxtIconController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSvgTxtIcon(
      clockwise: widget.clockwise ?? true,
      duration: widget.duration ?? Duration(milliseconds: 500),
      isActive: widget.isActive ?? true,
      onTap: widget.onTap ?? () {},
      svgSize: widget.size ?? 24,
      controller: controller,
      children: widget.pictures,
    );
  }
}
