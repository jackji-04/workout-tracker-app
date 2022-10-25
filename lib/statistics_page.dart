import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/time_planner.dart';
import 'database_helper.dart';
import 'main.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  StatsPageState createState() => StatsPageState();
}

class StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getDarkTheme(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(toolbarHeight: 15.4),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.asset('stats.png'),
            ],
          ),
        ),
      ),
    );
  }
}
