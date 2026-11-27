import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class BrutalistButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final IconData? icon;
  final bool fullWidth;

  const BrutalistButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.fullWidth = true,
  });

  @override
  State<BrutalistButton> createState() => _BrutalistButtonState();
}

class _BrutalistButtonState extends State<BrutalistButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onPressed != null;
    final Color bgColor = !isEnabled
        ? AppColors.obsidian.withValues(alpha: 0.35)
        : (widget.isPrimary ? AppColors.obsidian : AppColors.cream);
    final Color fgColor = !isEnabled
        ? AppColors.cream.withValues(alpha: 0.75)
        : (widget.isPrimary ? AppColors.cream : AppColors.obsidian);

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled
          ? (_) {
              setState(() => _isPressed = false);
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: widget.fullWidth ? double.infinity : null,
        transform: Matrix4.translationValues(
          _isPressed ? 2.5 : 0,
          _isPressed ? 2.5 : 0,
          0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isEnabled
                ? AppColors.obsidian
                : AppColors.obsidian.withValues(alpha: 0.4),
            width: 2.5,
          ),
          boxShadow: isEnabled && !_isPressed
              ? const [
                  BoxShadow(
                    color: AppColors.obsidian,
                    offset: Offset(4, 4),
                    blurRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: fgColor, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: TextStyle(
                color: fgColor,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
