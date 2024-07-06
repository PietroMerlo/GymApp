import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/models/workout.dart';
import 'package:gymapp/provider/providers.dart';
import 'package:gymapp/widgets/BottomBarHomePage.dart';

class Startup extends StatelessWidget {
  const Startup({super.key});

  Future<void> initialize(BuildContext context, Workout workout) async {
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
      initialize(context, ref.read(specificWorkoutProvider.notifier));

      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
