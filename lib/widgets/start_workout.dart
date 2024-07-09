import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';

class StartWorkout extends StatelessWidget {
  final NotifierProvider<Workout, List<Exercise>> startedWorkoutProvider;
  final _formKey = GlobalKey<FormBuilderState>();

  StartWorkout({super.key, required this.startedWorkoutProvider});

  void onSetsAddRemovePressed(int incrementValue) {
    _formKey.currentState!.fields['sets']!.didChange(
        (int.parse(_formKey.currentState!.fields['sets']!.value) +
                incrementValue)
            .toString());
  }

  void onRepsAddRemovePressed(int incrementValue) {
    _formKey.currentState!.fields['reps']!.didChange(
        (int.parse(_formKey.currentState!.fields['reps']!.value) +
                incrementValue)
            .toString());
  }

  Widget buildSmall(
      NotifierProvider<Workout, List<Exercise>> currentWorkoutProvider) {
    return workoutShow(currentWorkoutProvider);
  }

  Widget buildLarge(
      NotifierProvider<Workout, List<Exercise>> currentWorkoutProvider) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: workoutRecap(
                  currentWorkoutProvider) /*workoutShow(currentWorkout)*/),
          const SizedBox(width: 8),
          Expanded(child: workoutShow(currentWorkoutProvider))
        ]);
  }

  //TODO implementa workoutShow
  Widget workoutShow(NotifierProvider<Workout, List<Exercise>> currentWorkout) {
    return const Text("working out...");
  }

  //TODO implemente workoutRecap
  Widget workoutRecap(
      NotifierProvider<Workout, List<Exercise>> currentWorkout) {
    return Consumer(builder: (context, ref, child) {
      return ref.read(currentWorkout.notifier).toRecap();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isLarge = (size.width >= 992);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Working out..."),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: (isLarge)
                ? buildLarge(startedWorkoutProvider)
                : buildSmall(startedWorkoutProvider)));
  }
}
