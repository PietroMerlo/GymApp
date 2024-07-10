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

  Widget toRecap() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: Colors.white,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: const Color.fromARGB(255, 206, 148, 213),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const Text(
              "Today's Workout",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: state
                    .map((exersise) => ListTile(
                          title: Center(
                              child: Text(
                            exersise.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 122, 78, 130)),
                          )),
                          subtitle: Row(
                            children: [
                              Expanded(child: Container()),
                              Text('Sets: ${exersise.sets}',
                                  style: const TextStyle(color: Colors.black)),
                              kMediumHorizontalSpacing,
                              Text('Reps: ${exersise.reps}',
                                  style: const TextStyle(color: Colors.black)),
                              kMediumHorizontalSpacing,
                              Text('Weight: ${exersise.weight} kg',
                                  style: const TextStyle(color: Colors.black)),
                              Expanded(child: Container()),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
