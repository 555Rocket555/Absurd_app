import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class BrutalistCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Offset shadowOffset;

  const BrutalistCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.cream,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16,
    this.shadowOffset = const Offset(4, 4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.obsidian, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.obsidian,
            offset: shadowOffset,
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
