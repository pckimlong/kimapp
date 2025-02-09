import 'package:flutter/material.dart';

class BouncingWidget extends StatefulWidget {
  final Widget child;
  final double scale;
  final bool isEnabled;

  const BouncingWidget({super.key, required this.child, this.scale = 0.95, this.isEnabled = true});

  @override
  _BouncingWidgetState createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget> with SingleTickerProviderStateMixin {
  late Animation<double>? _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 70),
    );
    _scale = Tween<double>(begin: 1.0, end: widget.scale)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        if (widget.isEnabled) _controller.forward();
      },
      onPointerUp: (PointerUpEvent event) {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scale!,
        child: widget.child,
      ),
    );
  }
}
