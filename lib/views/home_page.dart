import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'clock_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat("HH:mm").format(now);
    var formattedDate = DateFormat("EEE,d MMM").format(now);
    var timezoneString = now.timeZoneOffset.toString().split(".").first;
    var offsetSign = "";
    if (!timezoneString.startsWith("-")) offsetSign = "+";
    print(timezoneString);
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildMenuButton("Clock", "assets/clock_icon.png"),
              buildMenuButton("Alarm", "assets/alarm_icon.png"),
              buildMenuButton("Timer", "assets/timer_icon.png"),
              buildMenuButton("Stopwatch", "assets/stopwatch_icon.png"),
            ],
          ),
          const VerticalDivider(
            color: Colors.white54,
            width: 3,
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Flexible(
                      fit: FlexFit.tight,
                      child: Text("Clock",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "avenir",
                              color: Colors.white,
                              fontSize: 24)),
                    ),
                    Column(
                      children: [
                        Text(formattedTime.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontFamily: "avenir",
                                color: Colors.white,
                                fontSize: 64)),
                        Text(formattedDate.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontFamily: "avenir",
                                color: Colors.white,
                                fontSize: 20)),
                      ],
                    ),
                    const Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Align(
                            alignment: Alignment.center,
                            child: ClockView(
                              size: 250,
                            ))),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "TimeZone",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "avenir",
                                color: Colors.white,
                                fontSize: 24),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.language, color: Colors.white),
                              const SizedBox(width: 16),
                              Text(
                                "UTC$offsetSign$timezoneString",
                                style: const TextStyle(
                                    fontFamily: "avenir",
                                    color: Colors.white,
                                    fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(String title, String image) {
    return Container(
      width: 95,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: title == "Clock" ? Colors.red : Colors.transparent,
        child: TextButton(
          onPressed: () {},
          child: Column(
            children: [
              Image.asset(
                image,
                scale: 1.5,
              ),
              const SizedBox(height: 16),
              Text(
                title ?? "",
                style: TextStyle(
                    fontFamily: "avenir", color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),

    );
  }
}
