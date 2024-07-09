import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/workout.dart';
import 'package:uitest/provider/providers.dart';
import 'package:uitest/widgets/BottomBarHomePage.dart';

class Startup extends StatelessWidget {
  const Startup({super.key});

  Future<void> initialize(BuildContext context, Workout workout) async {
    await workout.initialize();
  }

  Future<void> initAndCheckMount(BuildContext context, Workout workout) async {
    await workout.initialize();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomBarHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      initialize(context, ref.read(mondayWorkoutProvider.notifier));
      initialize(context, ref.read(tuesdayWorkoutProvider.notifier));
      initialize(context, ref.read(wednesdayWorkoutProvider.notifier));
      initialize(context, ref.read(thursdayWorkoutProvider.notifier));
      initialize(context, ref.read(fridayWorkoutProvider.notifier));
      initialize(context, ref.read(saturdayWorkoutProvider.notifier));
      initAndCheckMount(context, ref.read(sundayWorkoutProvider.notifier));
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
