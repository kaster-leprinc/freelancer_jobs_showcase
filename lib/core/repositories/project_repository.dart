// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:freelancer_jobs_showcase/core/api/api.dart';
import 'package:freelancer_sdk/models/fl_project_result.dart';
import 'package:freelancer_sdk/models/fl_response.dart';

class ProjectRepository {
  // TODO: Add to dependency injection if necessary
  final ApiProvider _apiProvider = ApiProvider();

  Future<FLResponse<FLProjectResult>> getActiveProjects() async {
    return await _apiProvider.getActiveProjects();
  }
}
