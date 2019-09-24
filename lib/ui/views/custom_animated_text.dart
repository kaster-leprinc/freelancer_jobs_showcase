// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

const Duration animatedHeaderTitleDuration = const Duration(milliseconds: 1000);

class FLCustomAnimatedHeaderTitle extends ImplicitlyAnimatedWidget {
  final String title;
  final Color targetColor;

  FLCustomAnimatedHeaderTitle(
      {@required this.title, Key key, @required this.targetColor})
      : super(key: key, duration: animatedHeaderTitleDuration);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return FLCustomAnimatedHeaderTitleState();
  }
}

class FLCustomAnimatedHeaderTitleState
    extends AnimatedWidgetBaseState<FLCustomAnimatedHeaderTitle> {
  // Default Tween
  ColorTween _colorTween;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Test',
      style: TextStyle(
        color: _colorTween.evaluate(animation),
        fontSize: 32,
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _colorTween = visitor(
      _colorTween,
      widget.targetColor,
      (color) => ColorTween(begin: color),
    );
  }
}
