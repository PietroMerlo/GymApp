import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/constant/spaces.dart';
import 'package:uitest/models/event.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';
import 'package:uitest/provider/providers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

const _uuid = Uuid();

class workout_Show extends ConsumerWidget {
  final NotifierProvider<Workout, List<Exercise>> currentWorkout;
  workout_Show(this.currentWorkout, {super.key});

  void init_Queue(
      NotifierProvider<Workout, List<Exercise>> currentWorkout, WidgetRef ref) {
    ref.read(nextEventProvider).clear();
    var Exercise_List = ref.watch(currentWorkout);
    for (final element in Exercise_List) {
      for (int i = 0; i < element.sets; i++) {
        ref.read(nextEventProvider).add(Event(
            id: _uuid.v4(),
            isExercise: true,
            name: element.name,
            reps: element.reps,
            weight: element.weight,
            notes: element.notes,
            time: null));

        ref.read(nextEventProvider).add(Event(
            id: _uuid.v4(),
            isExercise: false,
            name: null,
            reps: null,
            weight: null,
            notes: null,
            time: element.rest));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Event nextEvent = Event(
        id: "default",
        isExercise: false,
        name: null,
        reps: null,
        weight: null,
        notes: null,
        time: null);

    (ref.watch(nextEventProvider).isEmpty && !ref.watch(firstTimeProvider))
        ? {
            /*WORKOUT FINITO*/
            Future(() {
              ref.read(endWorkoutProvider.notifier).state = true;
            }),
          }
        : {
            (ref.watch(firstTimeProvider))
                ? {
                    init_Queue(currentWorkout, ref),
                    Future(() {
                      ref.read(firstTimeProvider.notifier).state = false;
                    }),
                    nextEvent = ref.watch(nextEventProvider).first
                  }
                : {nextEvent = ref.watch(nextEventProvider).first}
          };

/*

GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },

*/
    return Scaffold(
        body: (!ref.watch(endWorkoutProvider))
            ? GestureDetector(
                onTap: () {
                  var dataList = ref.read(nextEventProvider);
                  dataList.removeWhere((item) => item.id == nextEvent.id);
                  ref.read(nextEventProvider.notifier).state = [...dataList];
                },
                child: Column(
                  children: [
                    kMediumVerticalSpacing,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: (nextEvent.isExercise)
                              ? Color.fromARGB(200, 111, 188, 223)
                              : Color.fromARGB(198, 111, 223, 171)),
                      onPressed: () {
                        var dataList = ref.read(nextEventProvider);
                        dataList.removeWhere((item) => item.id == nextEvent.id);
                        ref.read(nextEventProvider.notifier).state = [
                          ...dataList
                        ];
                      },
                      child: const Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Text('Next '),
                          Icon(Icons.arrow_forward_rounded),
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
                                  color: Color.fromARGB(255, 255, 255, 255)
                                      .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                ),
                              ],
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: (nextEvent.isExercise)
                                  ? Color.fromARGB(200, 111, 188, 223)
                                  : Color.fromARGB(198, 111, 223, 171),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: (nextEvent.isExercise)
                                  ? ListView(
                                      children: [
                                        Center(
                                          child: Text(
                                            //NAME
                                            "${nextEvent.name}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        kHugeVerticalSpacing,
                                        Column(
                                          //REPS & WEIGHT
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: SizedBox()),
                                                Text(
                                                  "${nextEvent.reps}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Text(" reps",
                                                    style: const TextStyle(
                                                        fontSize: 20)),
                                                const Expanded(
                                                    child: SizedBox()),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: SizedBox()),
                                                const Text("with ",
                                                    style: const TextStyle(
                                                        fontSize: 20)),
                                                Text(
                                                  "${ref.watch(nextEventProvider).first.weight}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Text(" kg",
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                                const Expanded(
                                                    child: SizedBox()),
                                              ],
                                            ),
                                          ],
                                        ),
                                        kHugeVerticalSpacing,
                                        Column(
                                          //NOTES
                                          children: [
                                            Center(
                                              child: Container(
                                                  child:
                                                      (nextEvent.notes != null)
                                                          ? const Text(
                                                              "notes:",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : const SizedBox()),
                                            ),
                                            Container(
                                              child: (nextEvent.notes != null)
                                                  ? Text(
                                                      "${nextEvent.notes}",
                                                      style: const TextStyle(
                                                          fontSize: 20),
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
                                        Expanded(
                                            child: Row(
                                          children: [
                                            const Expanded(child: SizedBox()),
                                            Expanded(
                                              child: CircularCountDownTimer(
                                                duration:
                                                    (nextEvent.time != null)
                                                        ? nextEvent.time!
                                                        : 1,
                                                initialDuration: 0,
                                                controller:
                                                    CountDownController(),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                ringColor: Color.fromARGB(
                                                    255, 111, 223, 171),
                                                ringGradient: null,
                                                fillColor: Color.fromARGB(
                                                    255, 8, 200, 24),
                                                fillGradient: null,
                                                backgroundColor: Color.fromARGB(
                                                    255, 8, 100, 24),
                                                backgroundGradient: null,
                                                strokeWidth: 20.0,
                                                strokeCap: StrokeCap.round,
                                                textStyle: TextStyle(
                                                    fontSize: 33.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textFormat:
                                                    CountdownTextFormat.S,
                                                isReverse: true,
                                                isReverseAnimation: false,
                                                isTimerTextShown: true,
                                                autoStart: true,
                                                timeFormatterFunction:
                                                    (defaultFormatterFunction,
                                                        duration) {
                                                  if (duration.inSeconds == 0) {
                                                    return "Start";
                                                  } else {
                                                    return Function.apply(
                                                        defaultFormatterFunction,
                                                        [duration]);
                                                  }
                                                },
                                              ),
                                            ),
                                            const Expanded(child: SizedBox()),
                                          ],
                                        )),
                                        const Expanded(child: SizedBox()),
                                      ],
                                    ),
                            ))),
                    kMediumVerticalSpacing,
                  ],
                ))
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Column(
                  children: [
                    kMediumVerticalSpacing,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(215, 223, 134, 111)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Icon(Icons.arrow_back_rounded),
                          Text(' Exit'),
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
                                  color: Color.fromARGB(255, 255, 255, 255)
                                      .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Color.fromARGB(215, 223, 134, 111),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  const Expanded(child: SizedBox()),
                                  Row(
                                    children: [
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "End of Workout",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Expanded(child: SizedBox()),
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
                                ],
                              ),
                            ))),
                    kMediumVerticalSpacing,
                  ],
                )));
  }
}
