
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'rt_image_resolver.dart';

class RTImageSpan extends TextSpan {
  
  RTImageSpan(
    this.imageProvider, {
    this.imageWidth = 14.0,
    this.imageHeight = 14.0,
    this.margin,
    GestureRecognizer recognizer,
  })  : imageResolver = RTImageResolver(imageProvider),
        super(
            style: TextStyle(
                color: Colors.transparent,
                letterSpacing:
                    imageWidth + (margin == null ? 0 : margin.horizontal),
                height: 1,
                fontSize: (imageHeight / 1.15) +
                    (margin == null ? 0 : margin.vertical)),
            text: "\u200B",
            children: [],
            recognizer: recognizer);

  final double imageWidth;
  final double imageHeight;
  final EdgeInsets margin;
  final ImageProvider imageProvider;
  final RTImageResolver imageResolver;

  void updateImageConfiguration(BuildContext context) {
    imageResolver.updateImageConfiguration(context, imageWidth, imageHeight);
  }

  double get width => imageWidth + (margin == null ? 0 : margin.horizontal);

  double get height => imageHeight + (margin == null ? 0 : margin.vertical);
}
