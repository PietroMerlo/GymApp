import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Consumer(builder: (ctx, ref, _) {
            return Center(
              child: Text(
                "${ref.watch(week[pageIndex].notifier).day} workout",
              ),
            );
          })),
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
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: (isLandscape) ? 'Monday' : 'Mon'),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: (isLandscape) ? 'Tuesday' : 'Tue'),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: (isLandscape) ? "Wednesday" : 'Wed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: (isLandscape) ? "Thursday" : 'Thu'),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: (isLandscape) ? "Friday" : 'Fri'),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: (isLandscape) ? "Saturday" : 'Sat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down),
                activeIcon: Icon(Icons.arrow_drop_up),
                label: (isLandscape) ? "Sunday" : 'Sun'),
          ]),
      body: Padding(padding: const EdgeInsets.all(8), child: buildPage()),
    );
  }
}
