import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/time_planner.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<TimePlannerTask> tasks = [];

  void showExercise() {}
  void addDate(BuildContext context, TimePlannerDateTime time, int duration,
      String exercise) {
    List<Color?> colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.lime,
    ];

    setState(() {
      tasks.add(
        TimePlannerTask(
          color: colors[Random().nextInt(colors.length)],
          dateTime: time,
          minutesDuration: duration,
          daysDuration: 1,
          onTap: () {
            showExercise();
          },
          child: Text(
            exercise,
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime day1 = DateTime.now();
    return MaterialApp(
      theme: getDarkTheme(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to Today's Todo!"),
          centerTitle: true,
        ),
        body: Center(
          child: TimePlanner(
            startHour: 6,
            endHour: 23,
            style: TimePlannerStyle(
              cellHeight: 80,
              cellWidth: 300,
              showScrollBar: true,
            ),
            headers: [
              TimePlannerTitle(
                date: DateFormat.yMd().format(day1),
                title: DateFormat.EEEE().format(day1),
              ),
            ],
            tasks: tasks,
          ),
        ),
      ),
    );
  }
}
