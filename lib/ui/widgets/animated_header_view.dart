// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class FLAnimatedHeader extends StatelessWidget {
  final BuildContext rootContext;
  final bool isShowingDefaultActionBar;
  final String title;

  const FLAnimatedHeader({Key key, this.rootContext, this.isShowingDefaultActionBar, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 500),
      firstCurve: Curves.fastOutSlowIn,
      secondCurve: Curves.fastOutSlowIn,
      firstChild: Container(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(top: 32, left: 16, bottom: 12),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      secondChild: Container(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      crossFadeState: isShowingDefaultActionBar
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }
}
