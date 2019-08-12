
import 'package:fish_shopping/FishApp/Refresh/refresh_local.dart';
import 'package:fish_shopping/FishApp/Refresh/refresh_widget.dart';
import 'package:flutter/material.dart';


typedef RefreshChild RefreshChildBuilder(BuildContext context, RefreshWidgetController controller);

abstract class RefreshChild extends StatefulWidget {
  final RefreshWidgetController controller;

  RefreshChild({this.controller});

  @override
  State<StatefulWidget> createState();
}

class DefaultRefreshChild extends RefreshChild {
  final bool showState;
  final bool showLastUpdate;
  final Widget icon;
  final DefaultRefreshLocal local;
  final bool up;

  DefaultRefreshChild({
    RefreshWidgetController controller,
    this.showState: true,
    this.showLastUpdate: true,
    this.icon,
    DefaultRefreshLocal local,
    this.up: true,
  })  : this.local = local == null ? DefaultRefreshLocal.zh() : local,
        super(controller: controller);

  @override
  State<StatefulWidget> createState() {
    return _DefaultRefreshState();
  }
}

class _DefaultRefreshState extends State<DefaultRefreshChild> with TickerProviderStateMixin {
  
  AnimationController _animation;
  Tween<double> _tween;
  DateTime _lastUpdate;
  RefreshState _state = RefreshState.drag;
  
  @override
  void initState() {
    super.initState();

    _animation = AnimationController(vsync: this);
    _tween = Tween<double>(
      begin: 0.0,
      end: 1.0,
    );
    _tween.animate(_animation);
    _lastUpdate = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    widget.controller.addStateListener(_updateState);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String stateText;
    switch (_state) {
      case RefreshState.loading:
        stateText = widget.local.loading;
        break;
      case RefreshState.ready:
        stateText = widget.local.releaseToRefresh;
        break;
      case RefreshState.drag:
      case RefreshState.success:
        stateText = (widget.up
          ? widget.local.pullDownToRefresh
          : widget.local.pullUpToRefresh);
        break;
      case RefreshState.error:
        stateText = widget.local.error;
        break;
    }

    List<Widget> texts = [];
    TextStyle style = Theme.of(context).textTheme.body1;
    if (widget.showState) {
      texts.add(
        Text(
          stateText,
          style: style,
        ),
      );
    }

    if (widget.showLastUpdate) {
      texts.add(
        Text(
          "${widget.local.lastUpdate} ${_formateDate()}",
          style: style,
        )
      );
    }

    Widget text = texts.length > 0
      ? Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: texts,
          ),
        )
      : null;

    List<Widget> row = [
    _state == RefreshState.loading
      ? SizedBox(
          width: 20.0,
          height: 20.0, 
          child: CircularProgressIndicator()
        )
      : RotationTransition(
          turns: _animation,
          child: widget.icon,
        ),
    ];

    if (text != null) {
      row.add(text);
    }

    return Container(
      //width: MediaQuery.of(context).size.width,
      //height: 100,
      color: Colors.red,
      child:
    Row(
      mainAxisSize: MainAxisSize.min,
      children: row,
    ));
  }

  @override
  void didUpdateWidget(RefreshChild oldWidget) {
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeStateListener(_updateState);
      widget.controller.addStateListener(_updateState);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.removeStateListener(_updateState);
    super.dispose();
  }

  // helper 
  void _updateState() {
    switch (widget.controller.state) {
      case RefreshState.ready: {
        _rotate(0.5, true);
        break;
      }
      case RefreshState.drag: {
        _rotate(0.0, true);
        break;
      }
      case RefreshState.loading:
        break;
      case RefreshState.success:
        break;
      case RefreshState.error:
        break;
    }

    setState(() {
      _state = widget.controller.state;
    });
  }

  void _rotate(double value, bool releaseToRefresh) {
    _animation
      .animateTo(value, duration: Duration(milliseconds: 200), curve: Curves.ease)
      .whenComplete(() {});
  }

  String _formateDate() {
    DateTime time = _lastUpdate;
    return " ${_twoDigist(time.hour)}:${_twoDigist(time.minute)}";
  }

  static String _twoDigist(int num) {
    if (num < 10) return "0$num";
    return num.toString();
  }
}