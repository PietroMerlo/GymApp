import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/workout.dart';
import 'package:uitest/provider/providers.dart';
import 'package:uitest/pages/bottom_bar_home_page.dart';

class Startup extends StatelessWidget {
  const Startup({super.key});

  /*Future<void> initialize(BuildContext context, Workout workout) async {
    await workout.initialize();
  }*/

  Future<void> initializeAll(List<Workout> week, WidgetRef ref) async {
    for (final workout in week) {
      await workout.initialize();
    }
  }

  /*Future<void> initAndCheckMount(BuildContext context, Workout workout) async {
    await workout.initialize();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomBarHomePage()),
      );
    }
  }*/
  Future<void> checkMount(
    BuildContext context,
  ) async {
    if (context.mounted) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomBarHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      var week = [
        ref.read(mondayWorkoutProvider.notifier),
        ref.read(tuesdayWorkoutProvider.notifier),
        ref.read(wednesdayWorkoutProvider.notifier),
        ref.read(thursdayWorkoutProvider.notifier),
        ref.read(fridayWorkoutProvider.notifier),
        ref.read(saturdayWorkoutProvider.notifier),
        ref.read(sundayWorkoutProvider.notifier),
      ];

      initializeAll(week, ref);

      WidgetsBinding.instance.addPostFrameCallback((timestamp) {
        checkMount(context);
      });

      /*initialize(context, ref.read(mondayWorkoutProvider.notifier));
      initialize(context, ref.read(tuesdayWorkoutProvider.notifier));
      initialize(context, ref.read(wednesdayWorkoutProvider.notifier));
      initialize(context, ref.read(thursdayWorkoutProvider.notifier));
      initialize(context, ref.read(fridayWorkoutProvider.notifier));
      initialize(context, ref.read(saturdayWorkoutProvider.notifier));
      */

      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
