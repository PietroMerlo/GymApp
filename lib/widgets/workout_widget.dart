import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/constant/spaces.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';
import 'package:uitest/pages/create_exercise.dart';
import 'package:uitest/pages/start_workout.dart';
import 'package:uitest/provider/providers.dart';

class WorkoutPage extends ConsumerWidget {
  final NotifierProvider<Workout, List<Exercise>> selectedDayWorkoutProvider;

  const WorkoutPage(this.selectedDayWorkoutProvider, {super.key});

  void onPressedCreateExercise(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CreateExercise(
              selectedWorkoutProvider: selectedDayWorkoutProvider)),
    );
  }

  void onPressedStartWorkout(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              StartWorkout(startedWorkoutProvider: selectedDayWorkoutProvider)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String day = ref.watch(selectedDayWorkoutProvider.notifier).day;

    return Scaffold(
        appBar: AppBar(
          title: Text("$day workout"),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => onPressedCreateExercise(context),
          icon: const Icon(Icons.add),
          label: const Text('Add exercise'),
        ),
        body: (ref.watch(selectedDayWorkoutProvider).isEmpty)
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Text('No exercise found'),
                    kMediumVerticalSpacing,
                    ElevatedButton(
                      onPressed: () => onPressedCreateExercise(context),
                      child: const Text('Create Exercise'),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 72, 36, 108)),
                    onPressed: () => {
                      Future(() {
                        ref.read(endWorkoutProvider.notifier).state = false;
                        ref.read(firstTimeProvider.notifier).state = true;
                      }),
                      onPressedStartWorkout(context)
                    },
                    child: const Text('Start Workout'),
                  ),
                  Expanded(
                    child: ListView(
                      children: ref
                          .watch(selectedDayWorkoutProvider)
                          .map((exersise) => ListTile(
                                title: Text(exersise.name),
                                subtitle: Row(
                                  children: [
                                    Text('Sets: ${exersise.sets}'),
                                    kMediumHorizontalSpacing,
                                    Text('Reps: ${exersise.reps}'),
                                    kMediumHorizontalSpacing,
                                    Text('Weight: ${exersise.weight} kg'),
                                  ],
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                        shadowColor: const Color.fromARGB(
                                            255, 100, 66, 114),
                                        backgroundColor: const Color.fromARGB(
                                            255, 100, 66, 114),
                                        title: const Center(
                                            child: Text('Are you sure?')),
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                        children: [
                                          Center(
                                            child: Text(
                                              'Removing exercise: ${exersise.name}',
                                            ),
                                          ),
                                          kLargeVerticalSpacing,
                                          const Center(
                                            child: Text(
                                              'Confirm?',
                                            ),
                                          ),
                                          kLargeVerticalSpacing,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                      .read(
                                                          selectedDayWorkoutProvider
                                                              .notifier)
                                                      .removeExercise(
                                                          exersise.id);

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
                    ),
                  ),
                ],
              ));
  }
}
