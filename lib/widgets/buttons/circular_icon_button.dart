import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

/// A reusable circular button widget with an SVG icon
class CircularIconButton extends StatefulWidget {
  const CircularIconButton({
    super.key,
    required this.iconPath,
    required this.onTap,
    this.size = AppConstants.circularButtonSize,
    this.backgroundColor = AppColors.buttonBackground,
    this.iconSize = 22.4,
    this.padding = AppConstants.smallPadding,
    this.showVisualFeedbackOnly = false,
  });

  final String iconPath;
  final VoidCallback onTap;
  final double size;
  final Color backgroundColor;
  final double iconSize;
  final double padding;
  final bool showVisualFeedbackOnly; // New parameter to control behavior

  @override
  State<CircularIconButton> createState() => _CircularIconButtonState();
}

class _CircularIconButtonState extends State<CircularIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _colorAnimation =
        ColorTween(
          begin: widget.backgroundColor,
          end: AppColors.buttonBackgroundPressed,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
        if (widget.showVisualFeedbackOnly) {
          // Show visual feedback but don't execute the callback
          HapticFeedback.lightImpact(); // Add haptic feedback
        } else {
          // Execute the normal callback
          widget.onTap();
        }
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(widget.padding),
                child: SvgPicture.asset(
                  widget.iconPath,
                  width: widget.iconSize,
                  height: widget.iconSize,
                  colorFilter: ColorFilter.mode(
                    AppColors.iconColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
