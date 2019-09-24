// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

const Duration duration = const Duration(milliseconds: 1000);

class CustomAnimatedBoxColorWidget extends ImplicitlyAnimatedWidget {
  final Color targetColor;
  final Widget child;

  CustomAnimatedBoxColorWidget({
    @required this.child,
    Key key,
    @required this.targetColor,
  }) : super(key: key, duration: duration);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return CustomAnimatedBoxColorWidgetState();
  }
}

class CustomAnimatedBoxColorWidgetState
    extends AnimatedWidgetBaseState<CustomAnimatedBoxColorWidget> {
  BoxFadeTween _boxFadeTween;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _boxFadeTween.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _boxFadeTween = visitor(
      _boxFadeTween,
      widget.targetColor,
      (color) => BoxFadeTween(begin: color),
    );
  }
}

class BoxFadeTween extends Tween<Color> {
  Color middle = Colors.white;
  final Color begin;
  final Color end;

  BoxFadeTween({this.begin, this.end}) : super(begin: begin, end: end);

  @override
  Color lerp(double t) {
    if (t < 0.5) {
      return Color.lerp(begin, middle, t * 2);
    } else {
      return Color.lerp(middle, end, (t - 0.5) * 2);
    }
  }
}
