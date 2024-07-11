import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/event_rest.dart';
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
        Row(
          children: [
            const Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: () {
                ref.read(nextEventProvider.notifier).state =
                    event_Rest(time: 20);
              },
              child: const Row(
                children: [
                  Text('Next '),
                  Icon(Icons.arrow_right_alt_rounded),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        Text("time: ${ref.watch(nextEventProvider).time}"),
      ],
    );
  }
}
