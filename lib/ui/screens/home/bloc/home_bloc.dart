// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_jobs_showcase/core/repositories/project_repository.dart';
import 'package:freelancer_jobs_showcase/ui/screens/home/bloc/home_bloc_events.dart';
import 'package:freelancer_jobs_showcase/ui/screens/home/bloc/home_bloc_states.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final ProjectRepository projectRepository;

  HomeBloc({@required this.projectRepository})
      : assert(projectRepository != null);

  @override
  HomeBlocState get initialState => HomeInitial();

  @override
  Stream<HomeBlocState> mapEventToState(HomeBlocEvent event) async* {
    if (event is LoadActiveProjects) {
      try {        
        final response = await projectRepository.getActiveProjects();

        if (response.status == "success") {
          yield HomeSuccessLoadingProjects(projects: response.result);
        } else {
          yield HomeErrorLoadingProjects(
              error: "Error retrieving the active projects list.");
        }
      } catch (error) {
        yield HomeErrorLoadingProjects(error: error.toString());
      }
    }
  }
}
