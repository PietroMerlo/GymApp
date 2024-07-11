import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/event_exercise.dart';
import 'package:uitest/models/event_rest.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';

final mondayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "Monday"));

final tuesdayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "Tuesday"));

final wednesdayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "Wednesday"));

final thursdayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "Thursday"));

final fridayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "Friday"));

final saturdayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "Saturday"));

final sundayWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "Sunday"));

final defaultWorkoutProvider =
    NotifierProvider<Workout, List<Exercise>>(() => Workout(day: "Default"));

/*final nextEventProvider = StateNotifierProvider<event_Rest>((ref) {
  return event_Rest(time: 10);
});*/

final nextEventProvider =
    StateProvider<event_Rest>((ref) => event_Rest(time: 10));
