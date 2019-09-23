// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:freelancer_sdk/models/fl_project.dart';
import 'package:freelancer_sdk/models/fl_project_result.dart';

class ActiveJobsListView extends StatefulWidget {
  final FLProjectResult flProjectResult;

  const ActiveJobsListView({Key key, this.flProjectResult}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AbstractJobsListviewState();
  }
}

class AbstractJobsListviewState extends State<ActiveJobsListView> {
  List<FLProject> get _projects => widget.flProjectResult.projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _projects.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(_projects[index].seoUrl);
      },
    );
  }
}
