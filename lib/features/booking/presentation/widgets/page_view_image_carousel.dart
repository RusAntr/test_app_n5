import 'package:flutter/material.dart';

/// Custom image carousel widget with page indicators
class PageViewImageCarousel extends StatefulWidget {
  const PageViewImageCarousel({super.key, required this.imageUrls});

  /// Links to images
  final List<String?> imageUrls;

  @override
  State<PageViewImageCarousel> createState() => _PageViewImageCarouselState();
}

class _PageViewImageCarouselState extends State<PageViewImageCarousel> {
  /// Index of a current page/photo
  int _currentPhoto = 0;

  /// Sets color of page indicators to be progressively lighter
  double _gradientValue(index) =>
      (widget.imageUrls.length * 0.1 / (index + 1)).clamp(0, 1).toDouble();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Page view with images
        PageView(
          onPageChanged: (value) {
            setState(() {
              _currentPhoto = value;
            });
          },
          controller: PageController(),
          children: List.generate(
            widget.imageUrls.length,
            (index) => Image.network(
              widget.imageUrls[index]!,
              width: 300,
              fit: BoxFit.cover,
              frameBuilder: (
                context,
                child,
                frame,
                wasSynchronouslyLoaded,
              ) =>
                  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: child,
                ),
              ),
            ),
          ),
        ),

        /// Page indicators
        Align(
          alignment: const Alignment(0, 0.9),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.imageUrls.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    Icons.circle,
                    color: index == _currentPhoto
                        ? Colors.black
                        : Colors.black.withOpacity(
                            _gradientValue(index),
                          ),
                    size: 8,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
