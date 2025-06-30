import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

/// A responsive text widget that shows "Read More" for long text
class ExpandableText extends StatefulWidget {
  const ExpandableText({
    Key? key,
    required this.text,
    this.initialText,
    this.maxLines = 3,
    this.readMoreText = 'Read More',
    this.readLessText = 'Read Less',
    this.textStyle,
    this.linkStyle,
    this.animation = true,
  }) : super(key: key);

  final String text;
  final String? initialText; // Optional initial text to show when collapsed
  final int maxLines;
  final String readMoreText;
  final String readLessText;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;
  final bool animation;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.textStyle ?? AppTextStyles.description;
    final linkStyle = widget.linkStyle ?? AppTextStyles.readMore;

    return LayoutBuilder(
      builder: (context, constraints) {
        // If we have initial text, use it to determine if we need "Read More"
        final textToMeasure = widget.initialText ?? widget.text;

        // Create a TextPainter to measure text
        final span = TextSpan(text: textToMeasure, style: textStyle);
        final textPainter = TextPainter(
          text: span,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);

        // Check if we need "Read More" button
        // If we have initialText, we always show "Read More" (assuming full text is longer)
        // If we don't have initialText, check if the main text overflows
        final needsReadMore =
            widget.initialText != null || textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.animation
                ? AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: _buildText(textStyle, linkStyle, needsReadMore),
                  )
                : _buildText(textStyle, linkStyle, needsReadMore),
          ],
        );
      },
    );
  }

  Widget _buildText(
    TextStyle textStyle,
    TextStyle linkStyle,
    bool needsReadMore,
  ) {
    if (!needsReadMore) {
      // If no "Read More" is needed, show the text as is
      return Text(widget.text, style: textStyle);
    }

    return RichText(
      text: TextSpan(
        style: textStyle,
        children: [
          TextSpan(
            text: _isExpanded
                ? widget.text
                : (widget.initialText ?? _getTruncatedText(textStyle)),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              onTap: _toggle,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  _isExpanded ? widget.readLessText : widget.readMoreText,
                  style: linkStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTruncatedText(TextStyle textStyle) {
    // Create a text span with "Read More" to account for its space
    final readMoreSpan = TextSpan(
      text: ' ${widget.readMoreText}',
      style: widget.linkStyle ?? AppTextStyles.readMore,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        style: textStyle,
        children: [
          TextSpan(text: widget.text),
          readMoreSpan,
        ],
      ),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: double.infinity);

    if (textPainter.didExceedMaxLines) {
      // Binary search to find the optimal cut-off point
      int low = 0;
      int high = widget.text.length;
      String bestFit = '';

      while (low <= high) {
        int mid = (low + high) ~/ 2;
        String candidate = widget.text.substring(0, mid);

        final testPainter = TextPainter(
          text: TextSpan(
            style: textStyle,
            children: [
              TextSpan(text: '$candidate...'),
              readMoreSpan,
            ],
          ),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );
        testPainter.layout(maxWidth: double.infinity);

        if (!testPainter.didExceedMaxLines) {
          bestFit = candidate;
          low = mid + 1;
        } else {
          high = mid - 1;
        }
      }

      // Find word boundary
      if (bestFit.isNotEmpty) {
        final lastSpace = bestFit.lastIndexOf(' ');
        if (lastSpace > bestFit.length * 0.8) {
          // Only break at word if it's near the end
          bestFit = bestFit.substring(0, lastSpace);
        }
      }

      return '$bestFit...';
    }

    return widget.text;
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (widget.animation) {
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }
}
