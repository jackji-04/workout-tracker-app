import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/time_planner.dart';
import 'database_helper.dart';
import 'main.dart';

bool mainFirst = true;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<TimePlannerTask> tasks = [];

  void showExercise() {}
  void addDate(BuildContext context, TimePlannerDateTime time, int duration, String exercise) {
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
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Clicked on event')));
          },
          child: Text(
            exercise,
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
        ),
      );
    });

    if(!mainFirst) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Added exercise!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper.instance;
    if(mainFirst) {
      void addQueryData() async {
        final allRows = await dbHelper.queryAllRows();
        for(int i = 0; i < allRows.length; i++) {
          String asStr = allRows[i].toString();
          int mo = int.parse(asStr.substring(7,9));
          int day = int.parse(asStr.substring(10,12));
          int hr = int.parse(asStr.substring(13,15));
          int min = int.parse(asStr.substring(16,18));
          int dur = int.parse(asStr.substring((asStr.indexOf("dur")+5),asStr.indexOf(", exer")));
          String exer = asStr.substring((asStr.indexOf("exer")+6),asStr.length-1);
          DateTime now = DateTime.now();
          int todayDay = int.parse(DateFormat("dd").format(now));
          int todayMo = int.parse(DateFormat("MM").format(now));
          if(mo == todayMo && (day-todayDay == 0)) {
            TimePlannerDateTime dateTime = TimePlannerDateTime(
                day: day - todayDay,
                hour: hr,
                minutes: min);
            addDate(context, dateTime, dur, exer);
          } else if((day-todayDay < 0)) {
            dbHelper.delete(mo.toString() + "/" + day.toString() + ";" + hr.toString() + ":" + min.toString());
          }
        }
        mainFirst = false;
      }
      addQueryData();
    }

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
