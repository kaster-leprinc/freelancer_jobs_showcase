import 'package:flutter/material.dart';
import 'package:freelancer_jobs_showcase/ui/screens/home_screen.dart';

void main() => runApp(FreelancerJobsShowcaseApp());

class FreelancerJobsShowcaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freelancer Jobs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
