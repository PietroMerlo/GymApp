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

  Widget buildSmall(
      NotifierProvider<Workout, List<Exercise>> currentWorkoutProvider) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: workoutShow(currentWorkoutProvider),
    );
  }

  Widget buildLarge(
      NotifierProvider<Workout, List<Exercise>> currentWorkoutProvider) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              children: [
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      kMediumVerticalSpacing,
                      Expanded(child: workoutRecap(currentWorkoutProvider)),
                      kMediumVerticalSpacing,
                    ],
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox()),
              ],
            ),
          ),
          Expanded(
              child: Row(
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(flex: 4, child: workoutShow(currentWorkoutProvider)),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ))
        ]);
  }

  Widget workoutRecap(
      NotifierProvider<Workout, List<Exercise>> currentWorkout) {
    return workout_Recap(currentWorkout);
  }

  ConsumerWidget workoutShow(
      NotifierProvider<Workout, List<Exercise>> currentWorkout) {
    return workout_Show(currentWorkout);
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Consumer(builder: (context, ref, child) {
              return Text(ref.watch(startedWorkoutProvider.notifier).day);
            })),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: (isLandscape)
                ? buildLarge(startedWorkoutProvider)
                : buildSmall(startedWorkoutProvider)));
  }
}
