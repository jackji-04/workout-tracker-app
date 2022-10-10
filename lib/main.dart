import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/time_planner.dart';

void main() {
  runApp(const Core());
}

class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      accentColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.black),
      dividerColor: Colors.black12,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      title: "Workout Tracker",

      home: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon:Icon(Icons.calendar_month), text:"Calendar",),
                Tab(icon:Icon(Icons.home), text:"Home"),
                Tab(icon:Icon(Icons.pending_actions), text:"Statistics")],
            ),
            title: const Text('Workout Tracker'),
            centerTitle: true,
          ),
          body: const TabBarView(
            children: [
              CalendarPage(),
              Text("This is the home //TODO"),
              Text("This is the statistics //TODO")],
          ),
        ),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  List<TimePlannerTask> tasks = [];

  void addDate(BuildContext context) {
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
          dateTime: TimePlannerDateTime(
              day: Random().nextInt(14),
              hour: Random().nextInt(18) + 6,
              minutes: Random().nextInt(60)),
          minutesDuration: Random().nextInt(90) + 30,
          daysDuration: Random().nextInt(4) + 1,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Clicked on event')));
          },
          child: Text(
            'Test test',
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added random!')));
  }

  @override
  Widget build(BuildContext context) {
    DateTime day1 = DateTime.now();
    DateTime day2 = DateTime(day1.year, day1.month, day1.day+1);
    DateTime day3 = DateTime(day1.year, day1.month, day1.day+2);
    DateTime day4 = DateTime(day1.year, day1.month, day1.day+3);
    DateTime day5 = DateTime(day1.year, day1.month, day1.day+4);
    DateTime day6 = DateTime(day1.year, day1.month, day1.day+5);
    DateTime day7 = DateTime(day1.year, day1.month, day1.day+6);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0
      ),
      body: Center(
        child: TimePlanner(
          startHour: 6,
          endHour: 23,
          style: TimePlannerStyle(
            cellHeight: 40,
            cellWidth: 80,
            showScrollBar: true,
          ),
          headers: [
            TimePlannerTitle(
              date: DateFormat.yMd().format(day1),
              title: DateFormat.EEEE().format(day1),
            ),
            TimePlannerTitle(
              date: DateFormat.yMd().format(day2),
              title: DateFormat.EEEE().format(day2),
            ),
            TimePlannerTitle(
              date: DateFormat.yMd().format(day3),
              title: DateFormat.EEEE().format(day3),
            ),
            TimePlannerTitle(
              date: DateFormat.yMd().format(day4),
              title: DateFormat.EEEE().format(day4),
            ),
            TimePlannerTitle(
              date: DateFormat.yMd().format(day5),
              title: DateFormat.EEEE().format(day5),
            ),
            TimePlannerTitle(
              date: DateFormat.yMd().format(day6),
              title: DateFormat.EEEE().format(day6),
            ),
            TimePlannerTitle(
              date: DateFormat.yMd().format(day7),
              title: DateFormat.EEEE().format(day7),
            ),
          ],
          tasks: tasks,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addDate(context),
        tooltip: 'Add Workout',
        child: const Icon(Icons.add),
      ),
    );
  }
}