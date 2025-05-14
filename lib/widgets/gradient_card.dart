import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double opacity;
  final bool hasBorder;

  const GradientCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.opacity = 0.1,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        border: hasBorder ? Border.all(color: Colors.white.withOpacity(0.3)) : null,
      ),
      child: child,
    );
  }
} 