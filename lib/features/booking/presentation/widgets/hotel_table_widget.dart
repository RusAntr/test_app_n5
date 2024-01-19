import 'package:flutter/material.dart';

/// Extracted UI widget. Made for [TableRow]
class HotelTableWidget extends StatelessWidget {
  const HotelTableWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.showDivider,
  });

  /// Text displayed on top
  final String title;

  /// Text displayed below [title]
  final String subtitle;

  /// Whether to show divider below [subtitle]
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),

                /// Subtitle
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),

            /// Forward icon
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: showDivider
              ? Theme.of(context).colorScheme.onSurface.withOpacity(0.15)
              : Colors.transparent,
        )
      ],
    );
  }
}
