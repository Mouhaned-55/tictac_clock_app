import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitsSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  // Stop timer function :
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // Reset Timer function :
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitHours = "00";
      digitMinutes = "00";
      digitsSeconds = "00";

      started = false;
    });
  }

  // Add Lap function :
  void addLaps() {
    String lap = "$digitHours:$digitMinutes:$digitsSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  // Start timer function :
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }

      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitsSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (seconds >= 10) ? "$hours" : "0$hours";
        digitMinutes = (seconds >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 16.0, left: 16.0, top: 25.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Stopwatch",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "avenir",
                  color: Colors.white,
                  fontSize: 24)),
          const SizedBox(height: 20.0),
           Center(
            child: Text("$digitHours:$digitMinutes:$digitsSeconds",
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "avenir",
                    color: Colors.white,
                    fontSize: 60)),
          ),
          Container(
            height: 400.0,
            decoration: BoxDecoration(
                color: const Color(0xFF323F68),
                borderRadius: BorderRadius.circular(8.0)),
            child: ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lap n°${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "${laps[index]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: RawMaterialButton(
                onPressed: () {
                  (!started) ? start() : stop();
                },
                fillColor: Colors.blue,
                shape: const StadiumBorder(),
                child: Text((!started) ? "Start" : "Pause",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "avenir",
                      color: Colors.white,
                    )),
              )),
              const SizedBox(width: 8.0),
              IconButton(
                  onPressed: () {
                    addLaps();
                  },
                  icon: const Icon(
                    Icons.flag,
                    color: Colors.white,
                  )),
              Expanded(
                  child: RawMaterialButton(
                onPressed: () {
                  reset();
                },
                fillColor: Colors.blue,
                shape: const StadiumBorder(),
                child: const Text("Reset",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "avenir",
                      color: Colors.white,
                    )),
              ))
            ],
          )
        ],
      ),
    );
  }
}
