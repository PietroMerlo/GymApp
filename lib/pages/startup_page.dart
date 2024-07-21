import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/constant/spaces.dart';
import 'package:uitest/models/quote.dart';
import 'package:uitest/models/workout.dart';
import 'package:uitest/provider/providers.dart';
import 'package:uitest/pages/bottom_bar_home_page.dart';
import 'package:http/http.dart' as http;

class Startup extends StatelessWidget {
  const Startup({super.key});

  Future<void> initializeAll(List<Workout> week, WidgetRef ref) async {
    for (final workout in week) {
      await workout.initialize();
    }
  }

  Future<void> checkMount(
    BuildContext context,
  ) async {
    if (context.mounted) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomBarHomePage()),
      );
    }
  }

  Future<Quote> getQuote() async {
    final response =
        await http.get(Uri.parse("https://api.quotable.io/quotes/random"));

    if (response.statusCode != 200) {
      throw Exception("Something went wrong");
    }

    List<dynamic> rawJsonList = jsonDecode(response.body);
    var jsonList = rawJsonList
        .cast<Map<String, dynamic>>()
        .map((e) => Quote.fromJson(e))
        .toList();

    return jsonList.first;
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
      late Future<Quote> q = getQuote();

      return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Center(child: Text("Random quote for motivation"))),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<Quote>(
                  future: q,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(
                            "\"${snapshot.data!.content}\"",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("-${snapshot.data!.author}"),
                          kLargeVerticalSpacing
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 72, 36, 108)),
                  onPressed: () => {
                    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
                      checkMount(context);
                    })
                  },
                  child: const Text('enter'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
