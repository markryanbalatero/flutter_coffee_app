import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

/// A responsive heart button that toggles between filled and unfilled states
class HeartButton extends StatefulWidget {
  const HeartButton({
    Key? key,
    required this.onTap,
    required this.isFavorite,
    this.size = AppConstants.circularButtonSize,
    this.backgroundColor = AppColors.textWhite,
    this.iconSize = 22.4,
    this.padding = AppConstants.smallPadding,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isFavorite;
  final double size;
  final Color backgroundColor;
  final double iconSize;
  final double padding;

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(HeartButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFavorite != oldWidget.isFavorite) {
      if (widget.isFavorite) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        // Add a small bounce animation for feedback
        if (widget.isFavorite) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          shape: BoxShape.circle,
          boxShadow: widget.isFavorite
              ? [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.padding),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: widget.isFavorite ? _scaleAnimation.value : 1.0,
                child: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: widget.iconSize,
                  color: widget.isFavorite ? Colors.red : Colors.grey[600],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
