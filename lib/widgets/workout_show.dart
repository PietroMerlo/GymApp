import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/constant/spaces.dart';
import 'package:uitest/models/event.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';
import 'package:uitest/provider/providers.dart';

class workout_Show extends ConsumerWidget {
  final NotifierProvider<Workout, List<Exercise>> currentWorkout;

  const workout_Show(this.currentWorkout, {super.key});

  //TODO implementa workoutShow
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        kMediumVerticalSpacing,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 12, 49, 109)),
          onPressed: () {
            ref.read(nextEventProvider.notifier).state = Event(
              isExercise: true,
              name: 'panca',
              reps: 6,
              weight: 80,
              notes: null,
              time: null,
            );
          },
          child: const Row(
            children: [
              Expanded(child: SizedBox()),
              Text('Next '),
              Icon(Icons.arrow_right_alt_rounded),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
        kLargeVerticalSpacing,
        Expanded(
          child: (ref.watch(nextEventProvider).isExercise)
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 5,
                      color: Colors.white,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: const Color.fromARGB(255, 111, 187, 223),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          //NAME
                          "${ref.watch(nextEventProvider).name}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          //REPS & WEIGHT
                          children: [
                            Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                Text(
                                  "${ref.watch(nextEventProvider).reps}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(" reps",
                                    style: const TextStyle(fontSize: 20)),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                const Text("with ",
                                    style: const TextStyle(fontSize: 20)),
                                Text(
                                  "${ref.watch(nextEventProvider).weight}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(" kg",
                                    style: TextStyle(fontSize: 20)),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          //NOTES
                          children: [
                            Container(
                                child:
                                    (ref.watch(nextEventProvider).notes != null)
                                        ? const Text(
                                            "notes:",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const SizedBox()),
                            Container(
                              child:
                                  (ref.watch(nextEventProvider).notes != null)
                                      ? Text(
                                          "${ref.watch(nextEventProvider).notes}",
                                          style: const TextStyle(fontSize: 20),
                                        )
                                      : const SizedBox(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
              : const Text("rest"),
        ),
      ],
    );
  }
}
