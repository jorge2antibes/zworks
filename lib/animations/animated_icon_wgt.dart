import 'package:flutter/material.dart';

///https://flexiple.com/app/advanced-flutter-animations/
class AnimatedIconWgt extends StatefulWidget {
  final IconData iconData;
  final Alignment? alignment;
  final Color? color;

  const AnimatedIconWgt({
    super.key,
    required this.iconData,
    this.alignment = Alignment.center,
    this.color = Colors.white54,
  });

  @override
  State<AnimatedIconWgt> createState() => _AnimatedIconWgtState();
}

class _AnimatedIconWgtState extends State<AnimatedIconWgt> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _sizeTween = Tween<double>(begin: 0, end: 10);
  late Animation<double> _sizeAnimation;

  // late ColorTween _colorAnimation;
  late Future<TickerFuture> futureAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    );
    _sizeAnimation = _sizeTween.animate(_controller);
    //* listens on the animation and rebuilds with every tick by the ticker
    _controller.addListener(() {
      setState(() {});
    });
    //* animation is embedded inside the future, delayed by xSeconds
    futureAnimation = Future.delayed(
      const Duration(seconds: 1),
      () => _controller.forward(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment!,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: FutureBuilder(
          future: futureAnimation,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //* futureAnimation kicks off and returns the animated widget while the animation plays
              return FutureBuilder(
                //* futureAnimation will kicks whenComplete future when it completes
                future: snapshot.data?.whenComplete(() => {}),
                builder: (context, snapshot) {
                  //* the future completes => the animation has ended, so I return the empty Container
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container();
                  }
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) => Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(_sizeAnimation.value, _sizeAnimation.value),
                      child: Icon(
                        widget.iconData,
                        color: widget.color,
                      ),
                    ),
                  );
                },
              );
            }
            //* while futureAnimation is not playing returns empty Container
            return Container();
          },
        ),
      ),
    );
  }
}
