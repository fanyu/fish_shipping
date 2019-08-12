
import 'dart:io';

import 'package:fish_shopping/FishApp/Refresh/refresh_child.dart';
import 'package:fish_shopping/FishApp/Refresh/refresh_controller.dart';
import 'package:flutter/material.dart';
import 'refresh_widget.dart';

typedef Widget RefreshScrollViewBuilder(BuildContext context, {ScrollController controller, ScrollPhysics physics});
typedef void StateHandler(ScrollNotification notification);

bool checkChild(Widget src) {
  switch (src.runtimeType) {
    case GridView:
    case SingleChildScrollView:
    case ListView:
      return true;
  }
  return false;
}

class Refresh extends StatefulWidget {
  // 刷新回调
  final RefresherCallback onHeaderRefresh;
  final RefresherCallback onFooterRefresh; 
  // 滚动控制 
  final RefreshController controller;
  final ScrollController scrollController;
  // 
  final RefreshScrollViewBuilder childBuilder;
  final ScrollPhysics physics;
  final Widget child;

  Refresh({
    Key key,
    this.childBuilder,
    this.scrollController,
    this.onHeaderRefresh,
    this.child,
    this.controller,
    this.physics,
    this.onFooterRefresh})
    : super(key: key) {
      if (child != null) {
        assert(
          checkChild(child),
          "child must be GridView,SingleChildScrollView,ListView,"
          "if you want to put scrollview into another container, please use Refresh.builder instead"
        );
      }

      if (childBuilder == null && child == null) {
        throw new Exception("childBuild or child must not be both null");
      }
  }

  static ScrollPhysics createScrollPhysics(ScrollPhysics src) {
    if (Platform.isAndroid) {
      ScrollPhysics physics = AlwaysScrollableScrollPhysics().applyTo(BouncingScrollPhysics());
      if (src != null) {
        return physics.applyTo(src);
      }
      return physics;
    }
    return src;
  }
  
  @override
  State<StatefulWidget> createState() {
    return new _RefreshState();
  }
  
}

class _RefreshState extends State<Refresh> with TickerProviderStateMixin {
  
  double _headerRefreshOffset = 50.0;
  double _footerRefreshOffset = 50.0;

  RefreshWidgetController _headerValue;
  RefreshWidgetController _footerValue;

  _RefreshHeaderHandler _headerHandler;
  _RefreshFooterHandler _footerHandler;
  _RefreshHandler _refreshHandler;

  ScrollController scrollController;
  StateHandler _handler;
  
  bool _isAnimation = false;
  bool _animationComplete = false;

  @override
  void initState() {
    super.initState();
    _handler = _end;
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }
  
  @override
  void didChangeDependencies() {
    _updateState();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Refresh oldWidget) {
    _updateState();
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildWidget() {
    // listener 包裹传入的滚动视图, 并且监听其滚动
    Widget notificationListener = NotificationListener(
      child: widget.child == null
           ? widget.childBuilder(context, controller: scrollController, physics: Refresh.createScrollPhysics(widget.physics))
           : _cloneChild(widget.child),
      onNotification: _handleScrollNotification,
    );

    List<Widget> children = [];

    // 添加滚动视图
    children.add(notificationListener);

    // 添加 header
    if (widget.onHeaderRefresh != null) {
      children.add(
        RefreshWidget(
          height: _headerRefreshOffset,
          controller: _headerValue,
          createTween: createTweenForHeader,
          alignment: Alignment.topCenter,
          childBuilder: (BuildContext context, RefreshWidgetController controller) {
            return DefaultRefreshChild(
              controller: controller,
              icon: Icon(Icons.arrow_downward),
              up: true,
            );
          },
        )
      );
    }

    // 添加 footer 
    if (widget.onFooterRefresh != null) {
      children.add(
        RefreshWidget(
          height: _footerRefreshOffset,
          controller: _footerValue,
          createTween: createTweenForFooter,
          alignment: Alignment.bottomCenter,
          childBuilder: (BuildContext context, RefreshWidgetController controller) {
            return DefaultRefreshChild(
              controller: controller,
              icon: Icon(Icons.arrow_upward),
              up: false,
            );
          }
        )
      );
    }

    return Stack(
      key: widget.key,
      children: children,
    );
  }

  // 监听视图滚动
  bool _handleScrollNotification(ScrollNotification notification) {
    _handler(notification);
    return false;
  }

  // 复制一份滚动视图
  Widget _cloneChild(Widget src) {
    switch(src.runtimeType) {
      case GridView: {
        GridView gridView = src as GridView;
        return GridView.custom(
          gridDelegate: gridView.gridDelegate,
          childrenDelegate: gridView.childrenDelegate,
          controller: scrollController,
          physics: Refresh.createScrollPhysics(gridView.physics),
          key: gridView.key,
          scrollDirection: gridView.scrollDirection,
        );
      }
      case ListView: {
        ListView listView = src as ListView;
        return ListView.custom(
          childrenDelegate: listView.childrenDelegate,
          controller: scrollController,
          physics: Refresh.createScrollPhysics(listView.physics),
          key: listView.key,
          scrollDirection: listView.scrollDirection,
        );
      }
      case SingleChildScrollView: {
        SingleChildScrollView listView = src as SingleChildScrollView;
        return SingleChildScrollView(
          controller: scrollController,
          physics: Refresh.createScrollPhysics(listView.physics),
          key: listView.key,
          scrollDirection: listView.scrollDirection,
        );
      }
      default: return null;
    }
  }

  // 获取滚动视图
  ScrollController _tryGetControllerFrom(Widget src) {
    switch (src.runtimeType) {
      case GridView:
      case ListView:
        return (src as BoxScrollView).controller;
      
      case SingleChildScrollView:
        return (src as SingleChildScrollView).controller;
      
      default: 
        return null;
    }
  }

  void _updateState() {
    // 是 header
    if (widget.onHeaderRefresh != null) {
      // 初始化 _headerValue
      if (_headerValue == null) {
        _headerValue = RefreshWidgetController(0);
      }
      // 重置 _headerHandler
      if (_headerHandler == null || _headerHandler.callback != widget.onHeaderRefresh) {
        _headerHandler = _RefreshHeaderHandler(
          controller: _headerValue,
          callback: widget.onHeaderRefresh,
          offset: _headerRefreshOffset
        );
      }
    } else {
      // 重置 header
      if (_headerValue != null) {
        _headerValue.dispose();
      }
      _headerHandler = null;
    }

    // 是 footer
    if (widget.onFooterRefresh != null) {
      if (_footerValue == null) {
        _footerValue = RefreshWidgetController(0);
      }
      if (_footerHandler == null || _footerHandler.callback != widget.onFooterRefresh) {
        _footerHandler = _RefreshFooterHandler(
          controller: _footerValue,
          callback: widget.onFooterRefresh,
          offset: _footerRefreshOffset
        );
      }
    } else {
      if (_footerValue != null) {
        _footerValue.dispose();
      }
      _footerHandler = null;
    }

    // 初始化 scrollController
    ScrollController controller = widget.scrollController;
    if (controller == null && widget.child != null) {
      controller = _tryGetControllerFrom(widget.child);
    } 

    if (controller == null) {
      if (this.scrollController == null) {
        this.scrollController = ScrollController();
      }
    } else {
      this.scrollController = controller;
    }

  }

  void _scrollTo(double offset) {
    if (_isAnimation) { return; }
    
    if (_animationComplete) {
      scrollController.jumpTo(offset);
    } else {
      _isAnimation = true;
      scrollController
        .animateTo(offset, duration: Duration(milliseconds: 300), curve: Curves.ease)
        .whenComplete((){
          _isAnimation = false;
          _animationComplete = true;
      });
    }
  }

  void _loading(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      assert(_refreshHandler != null);
      _scrollTo(_refreshHandler.getScrollOffset(notification.metrics));
    } else if (notification is ScrollStartNotification) {
      ScrollStartNotification startNotification = notification;
      if (startNotification.dragDetails != null) {
        _handler = _drag;
      }
    }
  }

  void _end(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      if (notification.dragDetails != null) {
        _handler = _drag;
        _animationComplete = false;
      }
    }
  }

  void _drag(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      ScrollMetrics metrics = notification.metrics;
      if (notification.dragDetails != null) {
        double moveValue;
        // 判断是 header or footer
        if (_headerHandler != null && (moveValue = _headerHandler.getRefreshWidgetMoveValue(metrics)) > 0) {
          _refreshHandler = _headerHandler;
        } else if (_footerHandler != null && (moveValue = _footerHandler.getRefreshWidgetMoveValue(metrics)) > 0) {
          _refreshHandler = _footerHandler;
        } else {
          _refreshHandler = null;
        }
        // 更新controller 的 state and value
        if (_refreshHandler != null) {
          if (_refreshHandler.isReady(moveValue)) {
            _refreshHandler.changeState(RefreshState.ready);
          } else {
            _refreshHandler.changeState(RefreshState.drag);
          }
          _refreshHandler.controller.value = moveValue;
        }

      } else {
        if (_refreshHandler != null && 
            _refreshHandler.isReady(_refreshHandler.getRefreshWidgetMoveValue(metrics))) {
          _enterLoading(_refreshHandler, metrics);
          _isAnimation = false;
          _animationComplete = false;
          _handler = _loading;
          return;
        }
        _handler = _end;
      }
    }
  }

  void _enterLoading(_RefreshHandler _refreshHandler, ScrollMetrics metrics) async {
    double maxExtent;
    
    if (_refreshHandler == _footerHandler) {
      maxExtent = scrollController.position.maxScrollExtent; 
    }

    try {
      await _refreshHandler.loading(metrics);
      _refreshHandler.controller.onSuccess();
    } catch (e) {
      _refreshHandler.controller.onError(e);
    } finally {
      if (_refreshHandler == _footerHandler) {
        scrollController.jumpTo(maxExtent - _footerRefreshOffset * 2);
      }
      _refreshHandler = null;
      _handler = _end;
    }
  }
}


//  _RefreshHandler 

abstract class _RefreshHandler {
  final RefreshWidgetController controller;
  final RefresherCallback callback;
  final double offset;

  _RefreshHandler({this.controller, this.callback, this.offset});

  RefreshState _state = RefreshState.drag;

  double getScrollOffset(ScrollMetrics metrics);
  double getRefreshWidgetMoveValue(ScrollMetrics metrics);
  void cancel(ScrollMetrics metrics);

  Future<Null> loading(ScrollMetrics metrics) {
    changeState(RefreshState.loading);
    dynamic result = callback();
    assert(
      result is Future,
      "In this version,the call back must return a Future.value(null),  "
      "\n If the app is doing some working in the closure, the closure must define like this : "
      " \n Future<Null> onHeaderRefresh()  async {\n"
      "  await network.doSomeWork(); return new Future.value(null);"
      "\n } ");
    {
      result.whenComplete(() {
        changeState(RefreshState.drag);
      });
    }
    return result;
  }

  bool isReady(double moveValue) {
    return moveValue > offset;
  }

  void changeState(RefreshState currentState) {
    if (_state != currentState) {
      _state = currentState;
      controller.state = _state;
    }
  }
}

class _RefreshHeaderHandler extends _RefreshHandler {
  _RefreshHeaderHandler({
    RefreshWidgetController controller,
    RefresherCallback callback,
    double offset: 50.0
  }) : super(controller: controller, callback: callback, offset: offset);

  @override
  double getScrollOffset(ScrollMetrics metrics) {
    return -offset;
  }

  @override
  void cancel(ScrollMetrics metrics) {
    controller.value = metrics.pixels;
  }

  @override
  double getRefreshWidgetMoveValue(ScrollMetrics metrics) {
    return -metrics.pixels;
  }
}

class _RefreshFooterHandler extends _RefreshHandler {
  _RefreshFooterHandler({
    RefreshWidgetController controller,
    RefresherCallback callback,
    double offset: 50.0
  }) : super(controller: controller, callback: callback, offset: offset);

  @override
  double getScrollOffset(ScrollMetrics metrics) {
    return metrics.maxScrollExtent + offset;
  }

  @override
  double getRefreshWidgetMoveValue(ScrollMetrics metrics) {
    return metrics.pixels - metrics.maxScrollExtent;
  }

  @override
  void cancel(ScrollMetrics metrics) {
    controller.value = metrics.pixels;
  }
}