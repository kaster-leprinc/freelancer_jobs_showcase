// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:freelancer_jobs_showcase/core/repositories/project_repository.dart';

class HomeScreen extends StatefulWidget {
  final ProjectRepository projectRepository;

  const HomeScreen({Key key, this.projectRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  ProjectRepository get _projectRepository => widget.projectRepository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(),
        ),
      ),
    );
  }
}
