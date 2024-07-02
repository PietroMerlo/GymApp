import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/pages/homePage.dart';
import 'package:uitest/pages/loginPage.dart';
import 'package:uitest/provider/providers.dart';

void main() {
  //mantra
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: //const MyHomePage(title: 'Flutter Demo Home Page'),
            Consumer(
          builder: (ctx, ref, _) {
            var userdata = ref.watch(userProfileProvider);

            if (userdata?.Username != "asd") {
              return const LoginPage();
            } else {
              return Navigator(
                  onGenerateInitialRoutes: (navigator, initialRoute) => [
                        MaterialPageRoute(
                            builder: (ctx) => MyHomePage(
                                title:
                                    "Welcome back ${userdata?.getUsername()}!")),
                      ]);
            }
          },
        ));
  }
}
