// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_jobs_showcase/core/repositories/project_repository.dart';
import 'package:freelancer_jobs_showcase/ui/screens/home/bloc/bloc.dart';

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

  @override
  void initState() {
    super.initState();

    _homeBloc = HomeBloc(projectRepository: _projectRepository);
    _homeBloc.dispatch(LoadActiveProjects());
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
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      height: size.height,
                      width: size.width,
                      child: ListView.builder(
                        itemCount: state.projects.projects.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(state.projects.projects[index].seoUrl);
                        },
                      ),
                    ),
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
