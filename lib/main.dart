import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'database_helper.dart';
import 'home_page.dart';
import 'statistics_page.dart';

bool del = false;

void main() async {
  runApp(Main());

  final dbHelper = DatabaseHelper.instance;
  void queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    print('Database query:');
    for(int i = 0; i < allRows.length; i++) {
      print(allRows[i]);
      if(del) {
        String asStr = allRows[i].toString();
        String id = asStr.substring((asStr.indexOf("time")+6),asStr.indexOf(", dur"));
        print("Deleting: " + id);
        dbHelper.delete(id);
      }
    }
  }
  queryAll();
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: const IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

getDarkTheme() {
  return darkTheme;
}

class Main extends StatelessWidget {
  Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      title: "Workout Tracker",
      home: const NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int index = 1;

  static const List<Widget> widgetOpt = <Widget>[
    CalendarPage(),
    HomePage(),
    StatsPage(),
  ];

  void onItemTap(int i) {
    setState(() {
      index = i;
    });
    if(index == 0) {
      calFirst = true;
    } if(index == 1) {
      mainFirst = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Workout Tracker"),
          centerTitle: true,
        ),
        body: Center(
          child: widgetOpt.elementAt(index),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
              backgroundColor: Colors.black12,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.black12,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions),
              label: 'Statistics',
              backgroundColor: Colors.black12,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: index,
          selectedItemColor: Colors.indigoAccent,
          iconSize: 40,
          onTap: onItemTap,
          elevation: 5,
        ));
  }
}