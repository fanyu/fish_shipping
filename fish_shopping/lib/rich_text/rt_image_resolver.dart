
import 'package:flutter/material.dart';
import 'dart:ui' as ui show Image;

typedef ImageResolverListener = void Function(ImageInfo imageInfo, bool synchronousCall);

class RTImageResolver {
  
  RTImageResolver(this.imageProvider);

  final ImageProvider imageProvider;
  ImageStream _imageStream;
  ImageConfiguration _imageConfiguration;
  ui.Image image;
  ImageResolverListener _listener;

  /// 因为ImageSpan没法获取到BuildContext，所以从外部设置
  void updateImageConfiguration(BuildContext context, double width, double height) {
    _imageConfiguration = createLocalImageConfiguration(
      context,
      size: Size(width, height),
    );
  }

  void resolve(ImageResolverListener listener) {
    assert(_imageConfiguration != null);

    final ImageStream oldImageStream = _imageStream;
    _imageStream = imageProvider.resolve(_imageConfiguration);
    assert(_imageStream != null);

    this._listener = listener;

    if (_imageStream.key != oldImageStream?.key) {
      oldImageStream?.removeListener(ImageStreamListener(_handleImageChanged));
      _imageStream.addListener(ImageStreamListener(_handleImageChanged));
    }
  }

  void addListening() {
    if (this._listener != null) {
      _imageStream?.addListener(ImageStreamListener(_handleImageChanged));
    }
  }

  void stopListening() {
    _imageStream?.removeListener(ImageStreamListener(_handleImageChanged));
  }

  // 通知回调
  void _handleImageChanged(ImageInfo imageInfo, bool synchronousCall) {
    image = imageInfo.image;
    _listener?.call(imageInfo, synchronousCall);
  }

}