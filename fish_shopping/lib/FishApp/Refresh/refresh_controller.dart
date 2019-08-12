
import 'package:flutter/foundation.dart';

class RefreshController extends ValueNotifier<int> {
  
  static const int HEADER_START_REFRESH = 1;
  static const int HEADER_END_REFRESH = 2;
  static const int FOOTER_START_REFRESH = 3;
  static const int FOOTER_END_REFRESH = 4;

  RefreshController() : super(0);

  startHeaderRefresh() {
    _ensureHasListener();
    value = HEADER_START_REFRESH;
  }

  startFooterRefresh() {
    _ensureHasListener();
    value = FOOTER_START_REFRESH;
  }

  endHeaderRefresh() {
    _ensureHasListener();
    value = HEADER_END_REFRESH;
  }

  endFooterRefresh() {
    _ensureHasListener();
    value = FOOTER_END_REFRESH;
  }

  _ensureHasListener() {
    assert(
      hasListeners,
      "Must has listeners"
    );
  }
}