import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';

//TODO implementa workoutShow
class workout_Show extends ConsumerWidget {
  final NotifierProvider<Workout, List<Exercise>> currentWorkout;

  const workout_Show(this.currentWorkout, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workout = ref.watch(currentWorkout);

    return const Text("to be implemented...");
  }
}
