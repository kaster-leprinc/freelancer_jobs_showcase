// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_sdk/models/fl_project_result.dart';

abstract class HomeBlocState extends Equatable {
  HomeBlocState([List props = const []]) : super(props);
}

class HomeInitial extends HomeBlocState {
  @override
  String toString() => 'HomeInitial';
}

class HomeSuccessLoadingProjects extends HomeBlocState {
  final FLProjectResult projects;

  HomeSuccessLoadingProjects({@required this.projects}) : super([projects]);

  @override
  String toString() => 'HomeSuccessLoadingProjects { projects: $projects }';
}

class HomeErrorLoadingProjects extends HomeBlocState {
  final String error;

  HomeErrorLoadingProjects({@required this.error}) : super([error]);

  @override
  String toString() => 'HomeErrorLoadingProjects { error: $error }';
}
