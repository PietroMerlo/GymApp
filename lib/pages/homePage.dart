import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/provider/providers.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("building $this");

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(title),
            actions: [
              IconButton(
                  icon: const Icon(Icons.ac_unit),
                  onPressed: () {
                    debugPrint("Snow");
                    ref.read(todoItemProvider.notifier).zorro();
                  }),
            ]),

        //unica cosa che c'è sempre è body
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Container(
                          color: Colors.lightGreen,
                          child: Center(
                              child: Animate(
                                  effects: [FadeEffect(), ScaleEffect()],
                                  child: SizedBox(width: 100, height: 100))))),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Container(
                          color: Colors.lightBlue,
                          child: const Center(child: Text("Bottom")))),
                ])));
  }
}
