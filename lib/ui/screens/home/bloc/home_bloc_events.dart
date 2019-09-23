// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:equatable/equatable.dart';

abstract class HomeBlocEvent extends Equatable {
  HomeBlocEvent([List props = const []]) : super(props);
}

class LoadActiveProjects extends HomeBlocEvent {
  // TODO: Add oauth token here.
  @override
  String toString() => 'LoadActiveProjects';
}
