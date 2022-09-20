/*
import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class Bloc<T> {
  final _stateController = StreamController<T>.broadcast();
  late T _state;

  T get state => _state;

  Stream<T> get observableState => _stateController.stream;

  @protected
  void changeState(T state) {
    _state = state;
    _stateController.sink.add(state);
  }

  void dispose() {
    _stateController.close();
  }
}
*/
