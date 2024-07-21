import 'package:flutter/material.dart';

import 'package:uitest/widgets/workout_widget.dart';
import 'package:uitest/provider/providers.dart';

class BottomBarHomePage extends StatefulWidget {
  const BottomBarHomePage({super.key});

  @override
  State<BottomBarHomePage> createState() => _BottomBarHomePageState();
}

class _BottomBarHomePageState extends State<BottomBarHomePage> {
  int pageIndex = 0;
  var week = [
    mondayWorkoutProvider,
    tuesdayWorkoutProvider,
    wednesdayWorkoutProvider,
    thursdayWorkoutProvider,
    fridayWorkoutProvider,
    saturdayWorkoutProvider,
    sundayWorkoutProvider,
  ];
  Widget buildPage() {
    return WorkoutPage(week[pageIndex]);
    /*switch (pageIndex) {
      case 0:
        return WorkoutPage(mondayWorkoutProvider);
      case 1:
        return WorkoutPage(tuesdayWorkoutProvider);
      case 2:
        return WorkoutPage(wednesdayWorkoutProvider);
      case 3:
        return WorkoutPage(thursdayWorkoutProvider);
      case 4:
        return WorkoutPage(fridayWorkoutProvider);
      case 5:
        return WorkoutPage(saturdayWorkoutProvider);
      case 6:
        return WorkoutPage(sundayWorkoutProvider);
      default:
        return WorkoutPage(defaultWorkoutProvider);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            "GymApp 2.0",
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
