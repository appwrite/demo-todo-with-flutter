import 'package:flutter/material.dart';

class HoverLiftAndRise extends StatefulWidget {
  const HoverLiftAndRise({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  _HoverLiftAndRiseState createState() => _HoverLiftAndRiseState();
}

class _HoverLiftAndRiseState extends State<HoverLiftAndRise>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onHover: (value) {
          if (value)
            _controller.forward();
          else
            _controller.reverse();
        },
        onTap: () {},
        child: _HoverLiftAndRiseAnimation(
          controller: _controller,
          child: widget.child,
        ),
      ),
    );
  }
}

class _HoverLiftAndRiseAnimation extends AnimatedWidget {
  const _HoverLiftAndRiseAnimation(
      {Key? key, required this.child, required AnimationController controller})
      : super(key: key, listenable: controller);

  final Widget child;

  static final _liftUp = Tween<double>(begin: 0, end: -10);
  static final _scale = Tween<double>(begin: 1.0, end: 1.2);
  @override
  Widget build(BuildContext context) {
    final controller = listenable as AnimationController;
    return Transform.scale(
      scale: _scale.animate(controller).value,
      child: Transform.translate(
        offset: Offset(0, _liftUp.animate(controller).value),
        child: child,
      ),
    );
  }
}
