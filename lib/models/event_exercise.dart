class event_Exercise {
  final String name;
  final int reps;
  final int weight;
  final String? notes;

  event_Exercise({
    required this.name,
    required this.reps,
    required this.weight,
    this.notes,
  });
}
