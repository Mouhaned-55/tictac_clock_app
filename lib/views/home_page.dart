import 'package:clock_app/data/models/menu_info.dart';
import 'package:clock_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../data/enums.dart';
import '../notifications/noti.dart';
import 'alaram_page.dart';
import 'clock_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    Noti.initialize(flutterLocalNotificationsPlugin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems
                  .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                  .toList()),
          const VerticalDivider(
            color: Colors.white54,
            width: 3,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (context, value, child) {
                if (value.menuType == MenuType.clock) {
                  return ClockPage();
                } else if (value.menuType == MenuType.alarm) return AlarmPage();
                return Container(
                  child: const Center(
                      child: Text(
                    "POMODORO",
                    style: TextStyle(
                        color: Colors.red, fontSize: 30, fontFamily: "avenir"),
                  )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (context, value, child) {
        return Container(
          width: 95,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          decoration: BoxDecoration(
              color: currentMenuInfo.menuType == value.menuType
                  ? CustomColors.menuBackgroundColor
                  : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30.0),
              )),
          child: TextButton(
            onPressed: () {
              setState(() {
                var menuInfo = Provider.of<MenuInfo>(context, listen: false);
                menuInfo.updateMenu(currentMenuInfo);
              });
            },
            child: Column(
              children: [
                Image.asset(
                  currentMenuInfo.imageSource,
                  scale: 1.5,
                ),
                const SizedBox(height: 16),
                Text(
                  currentMenuInfo.title ?? "",
                  style: const TextStyle(
                      fontFamily: "avenir", color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
