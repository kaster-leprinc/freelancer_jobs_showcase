// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

const Duration duration = const Duration(milliseconds: 1000);

class CustomAnimatedTextWidget extends ImplicitlyAnimatedWidget {
  final String title;
  final EdgeInsets targetPadding;
  final Color targetColor;

  CustomAnimatedTextWidget({
    Key key,
    @required this.title,
    @required this.targetPadding,
    @required this.targetColor,
  }) : super(key: key, duration: duration);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return CustomAnimatedTextWidgetState();
  }
}

class CustomAnimatedTextWidgetState
    extends AnimatedWidgetBaseState<CustomAnimatedTextWidget> {
  ColorTween _colorTween;
  EdgeInsetsTween _edgeInsetsTween;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _edgeInsetsTween.evaluate(animation),
      child: Text(
        widget.title,
        style: TextStyle(
          color: _colorTween.evaluate(animation),
        ),
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

    _edgeInsetsTween = visitor(
      _edgeInsetsTween,
      widget.targetPadding,
      (padding) => EdgeInsetsTween(begin: padding),
    );
  }
}
