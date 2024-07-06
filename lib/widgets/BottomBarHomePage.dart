import 'package:flutter/material.dart';
import 'package:gymapp/pages/workout_page.dart';
import 'package:gymapp/widgets/create_exercise.dart';

class BottomBarHomePage extends StatefulWidget {
  const BottomBarHomePage({super.key});

  @override
  State<BottomBarHomePage> createState() => _BottomBarHomePageState();
}

class _BottomBarHomePageState extends State<BottomBarHomePage> {
  int pageIndex = 0;
  void onCreateExercisePressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CreateExercise()),
    );
  }

  Widget buildPage() {
    switch (pageIndex) {
      case 0:
        return const WorkoutPage();
      case 1:
        return Container(color: Colors.blue);
      case 2:
        return Container(color: Colors.green);
      case 3:
        return Container(color: Colors.green);
      case 4:
        return Container(color: Colors.green);
      case 5:
        return Container(color: Colors.green);
      case 6:
        return Container(color: Colors.green);
      default:
        return Container(color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Bottom navigation bar",
      )),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.amber[800],
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(size: 50),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          currentIndex: pageIndex,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: 'Monday'),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: "Tuesday"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: "Wednesday"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: "Thursday"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: "Friday"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: "Saturday"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: "Sunday"),
          ]),
      body: Padding(padding: const EdgeInsets.all(8), child: buildPage()),
    );
  }
}
