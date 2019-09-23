// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'package:freelancer_sdk/models/fl_project_result.dart';
import 'package:freelancer_sdk/models/fl_response.dart';
import 'package:http/http.dart';

// TODO: Soon to be migrated on freelancer_sdk
class ApiProvider {
  Client _client = Client();
  final _baseUrl = "https://freelancer.com/api";

  Future<FLResponse<FLProjectResult>> getActiveProjects() async {
    // TODO: Add pagination. Make limit dynamic
    final response =
        await _client.get('$_baseUrl/projects/0.1/projects/active?limit=50');

    if (response.statusCode == HttpStatus.ok) {
      return FLResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load request');
    }
  }
}
