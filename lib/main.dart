import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/pages/startup_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const Startup(),
    );
  }
}
