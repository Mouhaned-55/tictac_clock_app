import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'clock_view.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
        var now = DateTime.now();
    var formattedTime = DateFormat("HH:mm").format(now);
    var formattedDate = DateFormat("EEE,d MMM").format(now);
    var timezoneString = now.timeZoneOffset.toString().split(".").first;
    var offsetSign = "";
    if (!timezoneString.startsWith("-")) offsetSign = "+";
    print(timezoneString);
    return  Container(
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
                                SvgPicture.asset("assets/tn.svg"),
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
                  ));
  }
}