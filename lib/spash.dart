import 'dart:async';
import 'package:beautiful_timer/timerPage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const TimerPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 11, 20),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/timer.png",
            color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Beautiful Timer",
              style: TextStyle(
                  color: Colors.pink[100],
                  fontSize: 29,
                
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

// const Color.fromARGB(255, 9, 50, 83),