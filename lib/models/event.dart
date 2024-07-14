class Event {
  final String id;
  final bool isExercise;
  final String? name;
  final int? reps;
  final int? weight;
  final String? notes;
  final int? time;

  Event({
    required this.id,
    required this.isExercise,
    required this.name,
    required this.reps,
    required this.weight,
    required this.notes,
    required this.time,
  });
}
