import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String splashImage;

  @override
  void initState() {
    super.initState();
    loadSplashData();
  }

  Future<void> loadSplashData() async {
    final String response = await rootBundle.loadString('assets/splash.json');
    final data = await json.decode(response);
    splashImage = data['splashImage'];
    await Future.delayed(const Duration(seconds: 2));
    checkFirstLaunch();
  }

  void checkFirstLaunch() async {

    final isFirstLaunch = await checkIfFirstLaunch();
    if (isFirstLaunch) {
      GoRouter.of(context).replace('/boarding');
    } else {
      GoRouter.of(context).replace('/home');
    }
  }

  Future<bool> checkIfFirstLaunch() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: splashImage != null
            ? Image.asset(splashImage)
            : CircularProgressIndicator(),
      ),
    );
  }
}
