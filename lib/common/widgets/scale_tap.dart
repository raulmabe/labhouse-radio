import 'package:flutter/material.dart';

class ScaleOnTap extends StatefulWidget {
  const ScaleOnTap({
    super.key,
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.forceScale = false,
    this.duration = const Duration(milliseconds: 100),
    this.factorScale = .97,
    this.behavior = HitTestBehavior.deferToChild,
  });
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;

  final HitTestBehavior behavior;

  final bool forceScale;
  final double factorScale;
  final Duration duration;
  @override
  _ScaleOnTapState createState() => _ScaleOnTapState();
}

class _ScaleOnTapState extends State<ScaleOnTap>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);

    _scale = Tween<double>(
      begin: 1,
      end: 1,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mustScale = widget.onTap != null || widget.forceScale;

    if (!mustScale) return widget.child;

    return Listener(
      onPointerDown: _onTapDown,
      onPointerUp: _onTapUp,
      onPointerCancel: _onTapUp,
      behavior: widget.behavior,
      child: GestureDetector(
        behavior: widget.behavior,
        onTap: widget.onTap,
        onDoubleTap: widget.onDoubleTap,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scale.value,
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }

  void _onTapDown(_) => animate(widget.factorScale);
  void _onTapUp(_) => animate(1);

  void animate(double scale) {
    _animationController.stop();

    _scale = Tween<double>(begin: _scale.value, end: scale).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController
      ..reset()
      ..forward();
  }
}
