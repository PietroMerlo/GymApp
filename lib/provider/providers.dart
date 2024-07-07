import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/models/excercise.dart';
import 'package:gymapp/models/workout.dart';

final specificWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: 0));

final tuesdayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: 1));

final wednesdayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: 2));
