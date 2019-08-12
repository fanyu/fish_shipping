import 'package:fish_shopping/rich_text/rt_image_span.dart';
import 'package:fish_shopping/rich_text/rt_richtext_wrapper.dart';
import 'package:flutter/cupertino.dart';

class RTRichText extends Text {
  final List<TextSpan> textSpanList;
  
  RTRichText(
    this.textSpanList, 
    {
      Key key,
      TextStyle style,
      TextAlign textAlign = TextAlign.start,
      TextDirection textDirection,
      bool softWrap = true,
      TextOverflow overflow = TextOverflow.clip,
      double textScaleFactor = 1.0,
      int maxLines,
      Locale locale,
    }
  ) : super("",
            style: style,
            textAlign: textAlign,
            textDirection: textDirection,
            softWrap: softWrap,
            overflow: overflow,
            textScaleFactor: textScaleFactor,
            maxLines: maxLines,
            locale: locale);

  List<TextSpan> extractAllNestedChildren(TextSpan textSpan) {
    if (textSpan.children == null || textSpan.children.length == 0) {
      return [textSpan];
    }
    List<TextSpan> childrenSpan = [];
    textSpan.children.forEach((child) {
      childrenSpan.addAll(extractAllNestedChildren(child));
    });
    return childrenSpan;
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle effectiveTextStyle = style;
    if (style == null || style.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (MediaQuery.boldTextOverride(context)) {
      effectiveTextStyle = effectiveTextStyle.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    TextSpan textSpan = TextSpan(
      style: effectiveTextStyle,
      text: "",
      children: extractAllNestedChildren(
       TextSpan(
         style: effectiveTextStyle,
         text: "",
         children: textSpanList
       ) 
      )
    );
    // create image configuration 
    textSpan.children.forEach((span){
      if (span is RTImageSpan) {
        span.updateImageConfiguration(context);
      }
    });

    Widget result = RTRichTextWrapper(
      text: textSpan,
      textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap ?? defaultTextStyle.softWrap,
      overflow: overflow ?? defaultTextStyle.overflow,
      textScaleFactor: textScaleFactor ?? defaultTextStyle.maxLines,
    );

    if (semanticsLabel != null) {
      result = Semantics(
        textDirection: textDirection,
        label: semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        )
      );
    }

    return result;
  }
}