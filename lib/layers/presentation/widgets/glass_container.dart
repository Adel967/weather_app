import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.withBorder,
      required this.child,
      this.borderRadius,
      this.padding});

  final double width;
  final double height;
  final bool withBorder;
  final Widget child;
  final BorderRadius? borderRadius;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 0),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.2)
            ],
          ),
          border: withBorder
              ? Border.all(color: Colors.white.withOpacity(0.23), width: 2)
              : null),
      child: child,
    );
  }
}
