import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'home_page.dart';

void main() {
  runApp(const Main());
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
  const Main({super.key});

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
    Text('Statistics'),
  ];

  void onItemTap(int i) {
    setState(() {
      index = i;
    });
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
