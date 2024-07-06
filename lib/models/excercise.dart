class Exercise {
  final String id;
  final String name;
  final int sets;
  final int reps;
  final int weight;
  final String? notes;
  final int rest;

  Exercise({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.notes,
    required this.rest,
  });

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      sets: map['sets'],
      reps: map['reps'],
      weight: map['weight'],
      notes: map['notes'],
      rest: map['rest'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'notes': notes,
      'rest': rest,
    };
  }
}
