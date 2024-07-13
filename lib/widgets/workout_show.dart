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

  void init_Queue(
      NotifierProvider<Workout, List<Exercise>> currentWorkout, WidgetRef ref) {
    //TODO riempi la coda di eventi
    ref.read(nextEventProvider).add(Event(
        isExercise: true,
        name: "start",
        reps: 1,
        weight: 1,
        notes: "test note",
        time: null));
    ref.read(nextEventProvider).add(Event(
        isExercise: false,
        name: null,
        reps: null,
        weight: null,
        notes: null,
        time: 120));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    init_Queue(currentWorkout, ref);
    Event nextEvent = ref.watch(nextEventProvider).first;
    return Column(
      children: [
        kMediumVerticalSpacing,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 12, 49, 109)),
          onPressed: () {
            ref.read(nextEventProvider.notifier).state.removeFirst();
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
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 10,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  border: Border.all(
                    width: 5,
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: const Color.fromARGB(255, 111, 187, 223),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: (nextEvent.isExercise)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              //NAME
                              "${nextEvent.name}",
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
                                      "${nextEvent.reps}",
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
                                      "${ref.watch(nextEventProvider).first.weight}",
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
                                    child: (nextEvent.notes != null)
                                        ? const Text(
                                            "notes:",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const SizedBox()),
                                Container(
                                  child: (nextEvent.notes != null)
                                      ? Text(
                                          "${nextEvent.notes}",
                                          style: const TextStyle(fontSize: 20),
                                        )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const Expanded(child: SizedBox()),
                            Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                Text("rest: ${nextEvent.time}"),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                ))),
        kMediumVerticalSpacing,
      ],
    );
  }
}
