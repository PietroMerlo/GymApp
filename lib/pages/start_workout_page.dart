import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/constant/spaces.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';
import 'package:uitest/widgets/workout_recap_widget.dart';
import 'package:uitest/widgets/workout_show_widget.dart';

class StartWorkout extends StatelessWidget {
  final NotifierProvider<Workout, List<Exercise>> startedWorkoutProvider;

  StartWorkout({super.key, required this.startedWorkoutProvider});

  Widget buildPortrait() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: workout_Show(startedWorkoutProvider),
    );
  }

  Widget buildLandscape() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      kMediumVerticalSpacing,
                      Expanded(child: workout_Recap(startedWorkoutProvider)),
                      kMediumVerticalSpacing,
                    ],
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
          Expanded(
              child: Row(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(flex: 6, child: workout_Show(startedWorkoutProvider)),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Consumer(builder: (context, ref, child) {
              return Text(
                  "${ref.watch(startedWorkoutProvider.notifier).day} workout");
            })),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: (isLandscape) ? buildLandscape() : buildPortrait()));
  }
}
