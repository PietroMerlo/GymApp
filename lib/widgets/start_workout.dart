import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';
import 'package:uitest/widgets/workout_show.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Row(
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(flex: 4, child: workoutRecap(currentWorkoutProvider)),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ) /*workoutShow(currentWorkout)*/),
          const SizedBox(width: 8),
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
    return Consumer(builder: (context, ref, child) {
      return ref.read(currentWorkout.notifier).toRecap();
    });
  }

  ConsumerWidget workoutShow(
      NotifierProvider<Workout, List<Exercise>> currentWorkout) {
    return workout_Show(currentWorkout);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isLarge = (size.width >= 992);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Consumer(builder: (context, ref, child) {
              return Text(ref.watch(startedWorkoutProvider.notifier).day);
            })),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: (isLarge)
                ? buildLarge(startedWorkoutProvider)
                : buildSmall(startedWorkoutProvider)));
  }
}
