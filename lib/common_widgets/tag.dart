import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';

class Tag extends StatelessWidget {
  const Tag({super.key, required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: context.radiusFull),
      child: child,
    );
  }
}
