import 'dart:async';
import 'package:beautiful_timer/dot_presenter.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  int currentScreen = 0;
  int timerSeconds = 30;
  bool isTimerRunning = false;
  bool isSoundOn = true;

  late Timer _timer;
  AudioPlayer audioCache = AudioPlayer();
  List<String> title = ["Nom Nom :)", "Break Time", "Finish your meal"];
  List<String> subtitle = [
    "You have 10 minutes to eat before the pause. Focus on eating slowly",
    "Take a five-minute break to check in on your level of fullness",
    "You can eat until you feel full"
  ];
  List <Color> color = [Colors.pink, Colors.blue];

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds > 0) {
        setState(() {
          timerSeconds--;
          if (timerSeconds <= 5 && isSoundOn) {
            // Play sound when timer reaches 5 seconds
            audioCache.play(AssetSource("countdown_tick.mp3"));
          }
        });
      } else {
        timer.cancel();
        setState(() {
          currentScreen++;
          timerSeconds = 30;
          if (currentScreen > 2) {
            currentScreen = 0;
            _timer.cancel();
            
          }
        });
        startTimer(); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 11, 20),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 11, 20),
        title: const Text('Mindful Meal Timer',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                    title.length,
                    (index) => DotPresenter(
                          isActive: index == currentScreen,
                        ))
              ],
            ),
          ),
          Text(
            title[currentScreen],
            style: const TextStyle(fontSize: 24,
            color: Colors.white,
            ),
          ),
          Text(
            subtitle[currentScreen],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13,
            color: Colors.white,
            ),
          ),
          // Text(
          //   'Timer: $timerSeconds seconds',
          //   style: TextStyle(fontSize: 20),
          // ),

          const SizedBox(height: 20),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: color),
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 212, 72, 140),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.8),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '00:$timerSeconds',
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sound:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    ),
                    const SizedBox(width: 10),
                    Switch(
                      value: isSoundOn,
                      onChanged: (value) {
                        setState(() {
                          isSoundOn = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
          SizedBox(
            width: 390,
            height: 65,
            child: ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                elevation: 11,
                shadowColor: const Color.fromARGB(0, 255, 255, 255),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  backgroundColor: const Color.fromARGB(255, 212, 72, 140)),
              onPressed: () {
                if (isTimerRunning) {
                  _timer.cancel();
                  setState(() {
                    isTimerRunning = false;
                  });
                } else {
                  setState(() {
                    isTimerRunning = true;
                  });
                  startTimer();
                }
              },
              child: Text(isTimerRunning ? 'Pause Timer' : 'Start Timer',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          if (isTimerRunning)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 390,
                  height: 65,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        backgroundColor: const Color.fromARGB(255, 37, 11, 20)),
                    onPressed: () {
                      _timer.cancel();
                      setState(() {
                        isTimerRunning = false;
                        timerSeconds = 30;
                      });
                    },
                    child: const Text('Lets stop I am full now',
                    style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
                    ),
                  ),
                ),
                
              ],
            ),
            
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

