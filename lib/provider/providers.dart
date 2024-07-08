import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';

final mondayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "monday"));

final tuesdayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "tuesday"));

final wednesdayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "wednesday"));

final thursdayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "thursday"));

final fridayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "friday"));

final saturdayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "saturday"));

final sundayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "sunday"));

final defaultWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "default"));
