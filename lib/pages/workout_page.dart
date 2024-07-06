import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/constant/spaces.dart';
import 'package:gymapp/provider/providers.dart';
import 'package:gymapp/widgets/create_exercise.dart';

class WorkoutPage extends ConsumerWidget {
  const WorkoutPage({super.key});

  void onCreateExercisePressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CreateExercise()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GymApp'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => onCreateExercisePressed(context),
        icon: const Icon(Icons.add),
        label: const Text('Aggiungi esercizio'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final workout = ref.watch(specificWorkoutProvider);

          return workout.isEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text('Nessun esercizio trovato'),
                      kMediumVerticalSpacing,
                      ElevatedButton(
                        onPressed: () => onCreateExercisePressed(context),
                        child: const Text('Crea esercizio'),
                      )
                    ],
                  ),
                )
              : ListView(
                  children: workout
                      .map((exersise) => ListTile(
                            title: Text(exersise.name),
                            subtitle: Row(
                              children: [
                                Text('Sets: ${exersise.sets}'),
                                kSmallHorizontalSpacing,
                                Text('Reps: ${exersise.reps}'),
                                kSmallHorizontalSpacing,
                                Text('Peso: ${exersise.weight}'),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    title: const Text('Elimina esercizio'),
                                    contentPadding: const EdgeInsets.all(20),
                                    children: [
                                      Text(
                                        'Stai eliminando l\'esercizio ${exersise.name}. Confermare?',
                                      ),
                                      kSmallVerticalSpacing,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          kMediumHorizontalSpacing,
                                          ElevatedButton(
                                            onPressed: () {
                                              ref
                                                  .read(specificWorkoutProvider
                                                      .notifier)
                                                  .removeExercise(exersise.id);

                                              Navigator.of(context).pop();
                                            },
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.red,
                                              ),
                                            ),
                                            child: const Text(
                                              'Confirm',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ))
                      .toList(),
                );
        },
      ),
    );
  }
}
