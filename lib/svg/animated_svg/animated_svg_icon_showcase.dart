import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sbox1/svg/animated_svg/animated_svg_icon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animated svg encapsulated'),
        ),
        body: Scaffold(
          body: Center(
            child: AnimatedSvgTxtIconShowcase(
              pictures: [
                [
                  SvgPicture.asset(
                    'assets/svgs_at_things/envelope_closed.svg',
                  ),
                ],
                [
                  SvgPicture.asset(
                    'assets/svgs_at_things/envelope_with_mail.svg',
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedSvgTxtIconShowcase extends StatefulWidget {
  const AnimatedSvgTxtIconShowcase({
    super.key,
    required this.pictures,
    this.svgSize,
    this.clockwise,
    this.isActive,
    this.duration,
    this.onTap,
  });

  final List<List<Widget>> pictures;
  final double? svgSize;
  final bool? clockwise;
  final bool? isActive;
  final Duration? duration;
  final void Function()? onTap;

  @override
  State<AnimatedSvgTxtIconShowcase> createState() => _AnimatedSvgTxtIconShowcaseState();
}

class _AnimatedSvgTxtIconShowcaseState extends State<AnimatedSvgTxtIconShowcase> {
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
      children: widget.pictures,
      clockwise: widget.clockwise ?? true,
      duration: widget.duration ?? Duration(milliseconds: 500),
      isActive: widget.isActive ?? true,
      onTap: widget.onTap ?? () {},
      svgSize: widget.svgSize ?? 24,
      controller: controller,
    );
  }
}
