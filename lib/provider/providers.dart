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

final nextEventProvider = StateProvider<List<Event>>((ref) {
  return [
    Event(
        id: "default",
        isExercise: false,
        name: null,
        reps: null,
        weight: null,
        notes: null,
        time: null)
  ];
});

final firstTimeProvider = StateProvider<bool>((ref) {
  return true;
});
final endWorkoutProvider = StateProvider<bool>((ref) {
  return false;
});
