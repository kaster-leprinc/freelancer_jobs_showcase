// Copyright 2019 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:freelancer_jobs_showcase/ui/screens/detail/job_detail_screen.dart';
import 'package:freelancer_sdk/models/fl_budget.dart';
import 'package:freelancer_sdk/models/fl_currency.dart';
import 'package:freelancer_sdk/models/fl_project.dart';
import 'package:freelancer_sdk/models/fl_project_result.dart';

typedef void OnScrollCallback(double offset);

class FLActiveJobsListView extends StatefulWidget {
  final OnScrollCallback onScrollCallback;
  final FLProjectResult flProjectResult;

  const FLActiveJobsListView({
    Key key,
    this.flProjectResult,
    this.onScrollCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FLAbstractJobsListviewState();
  }
}

class FLAbstractJobsListviewState extends State<FLActiveJobsListView>
    with SingleTickerProviderStateMixin {
  OnScrollCallback get _onScrollCallback => widget.onScrollCallback;
  ScrollController _scrollController;
  List<FLProject> get _projects => widget.flProjectResult.projects;

  // Explicit Animations
  AnimationController _animationController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _onScrollCallback(_scrollController.offset);
    });

    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      itemCount: _projects.length,
      itemExtent: 125,
      itemBuilder: (BuildContext context, int index) {
        var count = _projects.length;
        var animation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(
              (1 / count) * index,
              1.0,
              curve: Curves.bounceInOut,
            ),
          ),
        );
        _animationController.forward();
        return AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: animation,
              child: Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  50 * (1.0 - animation.value),
                  0.0,
                ),
                child: _buildJobsItemView(_projects[index]),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildJobsItemView(FLProject project) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Material(
        elevation: 12.0,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobDetailScreen(
                  project: project,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(16),
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
