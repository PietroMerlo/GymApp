import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/provider/providers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? _controlUsername;
  TextEditingController? _controlPassword;

  @override
  void initState() {
    super.initState();
    _controlPassword = TextEditingController();
    _controlUsername = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controlPassword?.dispose();
    _controlUsername?.dispose();
  }

  Widget buildPortrait(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("---Portrait Login---",
              style: Theme.of(context).textTheme.headlineMedium),
          TextField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                label: Text("Username"),
              ),
              controller: _controlUsername),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(
              icon: Icon(Icons.key),
              label: Text("Password"),
            ),
            controller: _controlPassword,
            obscureText: true,
          ),
          const SizedBox(height: 8),
          Consumer(
            builder: (ctx, ref, _) {
              return ElevatedButton(
                  onPressed: () {
                    ref
                        .read(userProfileProvider.notifier)
                        .login(_controlUsername!.text, _controlPassword!.text);
                  },
                  child: const Text("LOGIN"));
            },
          )
        ]);
  }

  Widget buildLandscape(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("---Landscape Login---",
              style: Theme.of(context).textTheme.headlineSmall),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        label: Text("Username"),
                      ),
                      controller: _controlUsername),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.key),
                      label: Text("Password"),
                    ),
                    controller: _controlPassword,
                    obscureText: true,
                  ),
                ),
              ]),
          SizedBox(height: 24),
          Consumer(
            builder: (ctx, ref, _) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(),
                    ElevatedButton(
                        onPressed: () {
                          ref.read(userProfileProvider.notifier).login(
                              _controlUsername!.text, _controlPassword!.text);
                        },
                        child: const Text("LOGIN")),
                    SizedBox(),
                  ]);
            },
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("building $this");

    return Scaffold(
        appBar: AppBar(title: const Text("LoginPage")),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: OrientationBuilder(
              builder: (context, orientation) =>
                  orientation == Orientation.portrait
                      ? buildPortrait(context)
                      : buildLandscape(context),
            )));
  }
}
