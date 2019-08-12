
import 'dart:async';

import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {

  Carousel({
    Key key,
    this.images,
    this.initialIndex = 1,
    this.interval = 4,
    this.speed = 400,
    this.margin = EdgeInsets.zero,
    this.aspectRatio = 3,
    this.borderRadius = 10,
    this.indicatorBottom = 10,
    this.indicatorLeft = 0,
    this.indicatorRight = 0,
    this.indicatorColor = Colors.grey,
    this.indicatorSelectColor = Colors.white,
    this.indicatorSize = 6,
    this.indicatorSpace = 2,
  }) : super(key: key);

  final List<String> images;
  final int initialIndex;
  final int interval;
  final int speed;

  final EdgeInsetsGeometry margin;
  final double aspectRatio;
  final double borderRadius;

  final double indicatorBottom;
  final double indicatorLeft;
  final double indicatorRight;

  final Color indicatorColor;
  final Color indicatorSelectColor;
  final double indicatorSize;
  final double indicatorSpace;

  @override
  State<StatefulWidget> createState() {
    return _CarouselState();
  }
}

class _CarouselState extends State<Carousel> {
  
  Timer _timer; 
  PageController _pageController;
  int _currentIndex = 1;
  List<String> _addedImages = [];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _currentIndex = widget.initialIndex;

    if (widget.images.length > 0) {
      _setupTimer();
    }
    super.initState();
    _pageController = PageController(initialPage: 1);
    
    if (widget.images.length > 0) {
      _addedImages
        ..add(widget.images[widget.images.length - 1])
        ..addAll(widget.images)
        ..add(widget.images[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Stack(
        children: <Widget>[
          _buildPageView(),
          _buildIndicator()
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 && notification is ScrollStartNotification) {
          if (notification.dragDetails != null) {
            _timer.cancel();
          }
        } else if (notification is ScrollEndNotification) {
          _timer.cancel();
          _setupTimer();
        }
        return true;
      },
      child: widget.images.length > 0 
        ? PageView(
            physics: BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: _onPageViewPageChanged,
            children: _addedImages.map((item) {
              return Container(
                margin: widget.margin,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover
                  ),
                ),
              );
            }).toList(),
          )
        : Container()
    );
  }

  void _onPageViewPageChanged(int page) {
    int adjustIndex;
    
    if (page == _addedImages.length - 1) {
      adjustIndex = 1;
      Future.delayed(Duration(milliseconds: 200)).then((_){
        _pageController.jumpToPage(adjustIndex);
      });
    } else if (page == 0) {
      adjustIndex = _addedImages.length - 2;
        Future.delayed(Duration(milliseconds: 200)).then((_){
        _pageController.jumpToPage(adjustIndex);
      });
    } else {
      adjustIndex = page;
    }

    setState(() {
      _currentIndex = adjustIndex;
    });
  }

  Widget _buildIndicator() {
    return Positioned(
      bottom: widget.indicatorBottom,
      left: widget.indicatorLeft,
      right: widget.indicatorRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.images.asMap().map((i, v) {
          return MapEntry(
            i, 
            Container(
              width: 6,
              height: 6,
              margin: EdgeInsets.only(left: widget.indicatorSpace, right: widget.indicatorSpace),
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: _currentIndex == i + 1
                  ? widget.indicatorSelectColor
                  : widget.indicatorColor
              ),
            )
          );
        }).values.toList(),
      )
    );
  }
  
  void _setupTimer() {
    _timer = Timer.periodic(Duration(seconds: widget.interval), (_) {
      _pageController.animateToPage(
        _currentIndex + 1, 
        duration: Duration(milliseconds: widget.speed), 
        curve: Curves.easeOut
      );
    });
  }
  
}