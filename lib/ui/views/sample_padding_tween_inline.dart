// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

const Duration duration = const Duration(milliseconds: 1000);

class CustomAnimatedPaddingWidget extends ImplicitlyAnimatedWidget {
  final double targetPadding;
  final Widget child;

  CustomAnimatedPaddingWidget({
    @required this.child,
    Key key,
    @required this.targetPadding,
  }) : super(key: key, duration: duration);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return CustomAnimatedPaddingWidgetState();
  }
}

class CustomAnimatedPaddingWidgetState
    extends AnimatedWidgetBaseState<CustomAnimatedPaddingWidget> {
  Tween<double> _paddingTween;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_paddingTween.evaluate(animation)),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _paddingTween = visitor(
      _paddingTween,
      widget.targetPadding.toDouble(),
      (padding) => Tween<double>(begin: padding),
    );
  }
}
