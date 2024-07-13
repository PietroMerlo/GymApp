import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/event.dart';
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

final nextEventProvider = StateProvider<Queue<Event>>((ref) {
  return Queue();
});

final toggleProvider = StateProvider<bool>((ref) {
  return true;
});
