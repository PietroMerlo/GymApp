import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uitest/constant/spaces.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Workout extends Notifier<List<Exercise>> {
  final String day;
  Workout({required this.day});

  @override
  List<Exercise> build() {
    return [];
  }

  Future<void> initialize() async {
    final path = await _localPath;

    final file = File('$path/workout$day.json');

    if (await file.exists()) {
      state = (jsonDecode(await file.readAsString()) as List<dynamic>)
          .map(
            (exercise) => Exercise.fromMap(exercise),
          )
          .toList();
    }

    debugPrint('Read workout data from disk');
  }

  Future<void> addExercise({
    required String name,
    required int sets,
    required int reps,
    required int weight,
    required int rest,
    String? notes,
  }) async {
    final exercise = Exercise(
      id: _uuid.v4(),
      name: name,
      sets: sets,
      reps: reps,
      weight: weight,
      notes: notes,
      rest: rest,
    );

    debugPrint("adding excercise: ${exercise.name}");

    state = [...state, exercise];

    await _writeData();
  }

  Future<void> removeExercise(String id) async {
    state = state.where((exercise) => exercise.id != id).toList();

    await _writeData();
  }

  Future<void> _writeData() async {
    final path = await _localPath;

    final file = File('$path/workout$day.json');

    await file.writeAsString(
      jsonEncode(state.map((exercise) => exercise.toMap()).toList()),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
