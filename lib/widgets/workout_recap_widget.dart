import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/constant/spaces.dart';
import 'package:uitest/models/excercise.dart';
import 'package:uitest/models/workout.dart';

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
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Color.fromARGB(162, 206, 148, 213),
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
                                color: Color.fromARGB(255, 160, 34, 183)),
                          )),
                          subtitle: Row(
                            children: [
                              Expanded(child: Container()),
                              Text('Sets: ${exersise.sets}',
                                  style: const TextStyle(color: Colors.white)),
                              kMediumHorizontalSpacing,
                              Text('Reps: ${exersise.reps}',
                                  style: const TextStyle(color: Colors.white)),
                              kMediumHorizontalSpacing,
                              Text('Weight: ${exersise.weight} kg',
                                  style: const TextStyle(color: Colors.white)),
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
