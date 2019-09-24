// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_jobs_showcase/core/repositories/project_repository.dart';
import 'package:freelancer_jobs_showcase/ui/screens/home/bloc/bloc.dart';
import 'package:freelancer_jobs_showcase/ui/views/active_jobs_listview.dart';
import 'package:freelancer_jobs_showcase/ui/views/custom_animated_text.dart';

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
  HomeBloc _homeBloc;
  bool _isShowingDefaultActionBar = true;

  // Triggers
  bool _isTriggerChanged = false;
  Color _targetTitleColor = Colors.black;
  double _targetPadding = 0;
  

  @override
  void initState() {
    _homeBloc = HomeBloc(projectRepository: _projectRepository);
    _homeBloc.dispatch(LoadActiveProjects());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        builder: (context) {
          return _homeBloc;
        },
        child: BlocBuilder<HomeBloc, HomeBlocState>(
          builder: (BuildContext context, state) {
            if (state is HomeSuccessLoadingProjects) {
              return SafeArea(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: size.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 32,
                            left: 16,
                            bottom: 12,
                          ),
                          child: Text(
                            "Jobs",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 32,
                            left: 16,
                            bottom: 12,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (_isTriggerChanged) {
                                setState(() {
                                  _isTriggerChanged = false;
                                  _targetTitleColor = Colors.black;
                                  _targetPadding = 0;
                                });
                              } else {
                                setState(() {
                                  _isTriggerChanged = true;
                                  _targetTitleColor = Colors.blue;
                                  _targetPadding = 20;
                                });
                              }
                            },
                            child: FLCustomAnimatedHeaderTitle(
                              title: 'Jobs',
                              targetColor: _targetTitleColor,
                              targetPadding: _targetPadding,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FLActiveJobsListView(
                          flProjectResult: state.projects,
                          onScrollCallback: (offset) {
                            if (offset > 100) {
                              setState(() {
                                _isShowingDefaultActionBar = false;
                              });
                            } else {
                              setState(() {
                                _isShowingDefaultActionBar = true;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is HomeErrorLoadingProjects) {
              return Center(
                child: Text('Error encountered while retrieving data.'),
              );
            } else {
              return Center(
                child: Text('No data available.'),
              );
            }
          },
        ),
      ),
    );
  }
}
