import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_planner/time_planner.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  List<TimePlannerTask> tasks = [];

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

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Added exercise!')));
  }

  @override
  Widget build(BuildContext context) {
    DateTime day1 = DateTime.now();
    DateTime day2 = DateTime(day1.year, day1.month, day1.day + 1);
    DateTime day3 = DateTime(day1.year, day1.month, day1.day + 2);
    DateTime day4 = DateTime(day1.year, day1.month, day1.day + 3);
    DateTime day5 = DateTime(day1.year, day1.month, day1.day + 4);
    DateTime day6 = DateTime(day1.year, day1.month, day1.day + 5);
    DateTime day7 = DateTime(day1.year, day1.month, day1.day + 6);

    DateTime selectedDate = day1;
    TimeOfDay selectedTime = TimeOfDay.now();
    TimePlannerDateTime dateTime;

    Future<DateTime?> pickDate(BuildContext context) async {
      final selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: day1,
        lastDate: day7,
      );
      if (selected != null && selected != selectedDate) {
        setState(() {
          selectedDate = selected;
        });
      } else if (selected == null) {
        return null;
      }
      return selectedDate;
    }

    Future<TimeOfDay?> pickTime(BuildContext context) async {
      final selected = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (selected != null && selected != selectedTime) {
        setState(() {
          selectedTime = selected;
        });
      } else if (selected == null) {
        return null;
      }
      return selectedTime;
    }

    String exerciseName = "";
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Future<void> exerciseDiag(BuildContext context) async {
      return await showDialog(
          context: context,
          builder: (context) {
            final TextEditingController textCont = TextEditingController();
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                content: Form(
                    key: formKey,
                    child: Column(children: [
                      TextFormField(
                        controller: textCont,
                        validator: (value) {
                          return value!.isNotEmpty ? null : 'Invalid field';
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter exercise name"),
                      ),
                    ])),
                actions: <Widget>[
                  TextButton(
                      child: const Text("SUBMIT"),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                        }
                        exerciseName = textCont.text;
                      })
                ],
              );
            });
          });
    }

    Future pickDateTime(BuildContext context) async {
      final date = await pickDate(context);
      if (date == null) return;
      final startTime = await pickTime(context);
      if (startTime == null) return;
      final endTime = await pickTime(context);
      if (endTime == null) return;
      if (endTime.hour < startTime.hour) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('End time cannot be earlier than start time!')));
        return;
      } else if (endTime.hour == startTime.hour &&
          endTime.minute == startTime.minute) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('End time cannot be the same as start time!')));
        return;
      }
      await exerciseDiag(context);

      int duration = (endTime.hour - startTime.hour) * 60 +
          (endTime.minute - startTime.minute);
      setState(() {
        dateTime = TimePlannerDateTime(
            day: date.day - int.parse(DateFormat("dd").format(day1)),
            hour: startTime.hour + 1,
            minutes: startTime.minute);
        addDate(context, dateTime, duration, exerciseName);
      });
    }

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
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
        onPressed: () => pickDateTime(context),
        tooltip: 'Add Workout',
        child: const Icon(Icons.add),
      ),
    );
  }
}
