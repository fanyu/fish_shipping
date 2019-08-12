
import 'package:fish_shopping/FishApp/Refresh/refresh_child.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as Math;

typedef Future<Null> RefresherCallback();

enum RefreshState {
  drag,
  ready,
  loading,
  success,
  error,
}

class RefreshWidgetController extends ValueNotifier<double> {
  RefreshWidgetController(double value) 
    : _state = ValueNotifier(RefreshState.drag), super(0.0);

  final ValueNotifier<RefreshState> _state;

  // State: get set
  RefreshState get state => _state.value;
  set state(RefreshState state) {
    _state.value = state;
  }

  bool get loading => _state.value == RefreshState.loading;

  @override
  double get value => super.value;

  @override
  set value(double newValue) {
    if (loading) {
      return;
    }
    super.value = newValue;
  }
  
  @override
  dispose() {
    _state.dispose();
    super.dispose();
  }

  onSuccess() {
    this.state = RefreshState.success;
  }

  onError(e) {
    _state.value = RefreshState.error;
  }

  addStateListener(VoidCallback updateState) {
    _state.addListener(updateState);
  }

  removeStateListener(VoidCallback updateState) {
    _state.removeListener(updateState);
  }
}


typedef RectTween CreateTween(RefreshWidget widget);

RectTween createTweenForHeader(RefreshWidget widget) {
  return RectTween(
    begin: Rect.fromLTRB(0, -widget.height, 0, 0),
    end: Rect.fromLTRB(0, 300, 0, 0)
  );
}

RectTween createTweenForFooter(RefreshWidget widget) {
  return RectTween(
    begin: Rect.fromLTRB(0, 0, 0, widget.height),
    end: Rect.fromLTRB(0, 0, 0, -300)
  );
}

class RefreshWidget extends StatefulWidget {

  final double height;
  final double maxOffset = 300;
  final RefreshChildBuilder childBuilder;
  final RefreshWidgetController controller;              
  final CreateTween createTween;
  final AlignmentGeometry alignment;

  RefreshWidget({
    this.height,
    this.controller,
    this.childBuilder,
    this.createTween,
    this.alignment
  }) : assert(controller != null);

  @override
  State<StatefulWidget> createState() {
    return _RefreshWidgetState();
  }
  
}

class _RefreshWidgetState extends State<RefreshWidget> with TickerProviderStateMixin {
  
  // 改变 widget 高度
  AnimationController _animationController;
  Animation<Rect> _animation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _animation = widget.createTween(widget).animate(_animationController);
  }

  @override
  void didChangeDependencies() {
    widget.controller.addListener(_updateValue);
    widget.controller.addStateListener(_updateState);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RelativePositionedTransition(
      size: Size(0, 0),
      rect: _animation,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return Align(
            alignment: widget.alignment,
            child: SizedBox(
              height: widget.height,
              child: widget.childBuilder(context, widget.controller),
            ),
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(RefreshWidget oldWidget) {
    // 重新添加监听
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_updateValue);
      oldWidget.controller.removeStateListener(_updateState);
      widget.controller.addListener(_updateValue);
      widget.controller.addStateListener(_updateState);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateValue);
    widget.controller.removeStateListener(_updateState);
    super.dispose();
  }
  
  // value 改变后更新高度
  _updateValue() {
    double value = Math.min(widget.controller.value, widget.height) / (widget.maxOffset + widget.height);
    _animationController.value = value;
  }

  // state 改变后更新高度
  _updateState() {
    switch (widget.controller.state) {
      case RefreshState.drag:        
        break;
      
      case RefreshState.loading: {
        double value = widget.height / (widget.maxOffset + widget.height);
        _animationController
          .animateTo(value, duration: Duration(milliseconds: 300), curve: Curves.ease)
          .whenComplete((){});
        break;
      }

      case RefreshState.ready:
        break;
      
      case RefreshState.error:
      case RefreshState.success:
         _animationController
          .animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.ease)
          .whenComplete((){});
        break;

      default:
        break;
    }
  }

}