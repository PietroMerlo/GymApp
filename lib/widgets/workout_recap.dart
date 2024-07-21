import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/constant/spaces.dart';
import 'package:uitest/models/event.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';
import 'package:uitest/provider/providers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class workout_Recap extends ConsumerWidget {
  final NotifierProvider<Workout, List<Exercise>> currentWorkout;
  workout_Recap(this.currentWorkout, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
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
            kMediumVerticalSpacing,
            Expanded(
              child: ListView(
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                children: ref
                    .watch(currentWorkout)
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
