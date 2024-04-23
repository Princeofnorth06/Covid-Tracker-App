// ignore: file_names
import 'dart:async';

import 'package:covid_tracker/home.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage())),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: animationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: animationController.value * 2.0 * math.pi,
                    child: child,
                  );
                },
                child: const Image(image: AssetImage('images/corona.png')),
              ),
              SizedBox(
                height: mq.height * 0.08,
              ),
              const Align(
                child: Text(
                  '  Covid-19\nTracker App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
