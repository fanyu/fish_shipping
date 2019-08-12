

import 'package:fish_shopping/rich_text/rt_image_span.dart';
import 'package:flutter/rendering.dart';

class RTRenderParagraph extends RenderParagraph {
    RTRenderParagraph(TextSpan text,
      {
        TextAlign textAlign,
        TextDirection textDirection,
        bool softWrap,
        TextOverflow overflow,
        double textScaleFactor,
        int maxLines,
        Locale locale
      })
      : super(
          text,
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          locale: locale,
        );

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    text.visitChildren((InlineSpan span){
      if (span is RTImageSpan) {
        span.imageResolver.addListening();
      }
      return true;
    });
    // text.children.forEach((textspan){
    //   if (textspan is ImageSpan) {
    //     textspan.imageResolver.addListening();
    //   }
    // });
  }

  @override
  void detach() {
    super.detach();
    text.visitChildren((InlineSpan span){
    if (span is RTImageSpan) {
      span.imageResolver.stopListening();
    }
    return true;
    });

    // text.children.forEach((textSpan){
    //   if (textSpan is ImageSpan) {
    //     textSpan.imageResolver.stopListening();
    //   }
    // });
  }
  
  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    paintImageSpan(context, offset);
  }

  void paintImageSpan(PaintingContext context, Offset offset) {
    // reset origi point
    final Canvas canvas = context.canvas;
    final Rect bounds = offset & size;
    canvas.save();

    int textOffset = 0;
    for (TextSpan span in text.children) {
      if (span is RTImageSpan) {
        // top-center of imagespan 
        Offset offsetForCaret = getOffsetForCaret(TextPosition(offset: textOffset), bounds);
        if (textOffset == 0) {
          offsetForCaret = Offset(0, offsetForCaret.dy);
        }
        // ignore overflow
        if (textOffset != 0 && offsetForCaret.dx == 0 && offsetForCaret.dy == 0) {
          return;
        }
        // top-left point of imageSpan, first text is always (0,0)
        Offset topLeftOffset = Offset(
          offset.dx + offsetForCaret.dx - (textOffset == 0 ? 0 : span.width / 2), 
          offset.dy + offsetForCaret.dy
        );
        // wating image to ready
        if (span.imageResolver.image == null) {
          span.imageResolver.resolve((imageInfo, synchronousCall) {
            if (synchronousCall) {
              paintImage(
                canvas: canvas,
                rect: topLeftOffset & Size(span.width, span.height),
                image: span.imageResolver.image,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center
              );
            } else {
              if (owner == null || !owner.debugDoingPaint) {
                markNeedsPaint();
              }
            }
          });
          // add offset
          textOffset += span.toPlainText().length;
          continue;
        } 
        // image is ready, and pain image 
        paintImage(
          canvas: canvas,
          rect: topLeftOffset & Size(span.width, span.height),
          image: span.imageResolver.image,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center
        );
      }
      // not iamge span, just add offset
      textOffset += span.toPlainText().length;
    }
    canvas.restore();
  }

}