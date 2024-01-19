import 'package:flutter/material.dart';

/// Extracted UI widget. Used in [TableRow] on BookingScreenView
class TextTableWidget extends StatelessWidget {
  const TextTableWidget({
    super.key,
    required this.text,
    required this.isTitle,
    this.textAlign = TextAlign.left,
    this.extraStyle,
  });

  /// The text displayed in a row of a table
  final String text;

  /// Whether the [text] is a title and is displayed in the first row
  final bool isTitle;

  /// Where does text align. Optional parameter
  /// Defaults to [TextAlign.left] if not specified
  final TextAlign? textAlign;

  /// Extra text style for text in the second column
  final TextStyle? extraStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        textAlign: textAlign,
        style: isTitle
            ? Theme.of(context).textTheme.bodyMedium
            : extraStyle ?? Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
