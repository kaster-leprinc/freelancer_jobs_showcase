// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:freelancer_sdk/models/fl_budget.dart';
import 'package:freelancer_sdk/models/fl_currency.dart';
import 'package:freelancer_sdk/models/fl_project.dart';

class JobDetailScreen extends StatefulWidget {
  static String heroTag = "JobItem";
  final FLProject project;

  const JobDetailScreen({Key key, this.project}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return JobDetailScreenState();
  }
}

class JobDetailScreenState extends State<JobDetailScreen> {
  FLProject get project => widget.project;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: SingleChildScrollView(
                child: Material(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _buildBudgetView(
                                project.type,
                                project.currency,
                                project.budget,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              project.title,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              project.previewDescription,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TODO: Make base util function
  String _buildBudgetView(String type, FLCurrency currency, FLBudget budget) {
    if (type == "hourly") {
      if (budget.maximum == 0) {
        return '${currency.sign}${budget.minimum}/hr';
      } else {
        return '${currency.sign}${budget.minimum}/hr-${currency.sign}${budget.maximum}/hr';
      }
    } else {
      if (budget.maximum == 0) {
        return '${currency.sign}${budget.minimum}';
      } else {
        return '${currency.sign}${budget.minimum}-${currency.sign}${budget.maximum}';
      }
    }
  }
}
