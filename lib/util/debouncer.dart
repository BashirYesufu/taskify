import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  late final int milliseconds;
  Timer? _timer;

  Debouncer({ required this.milliseconds });

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  dispose(){
    _timer?.cancel();
    _timer = null;
  }

}