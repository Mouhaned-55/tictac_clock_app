import 'package:clock_app/data/models/menu_info.dart';
import 'package:clock_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../data/enums.dart';
import 'alaram_page.dart';
import 'clock_page.dart';
import 'clock_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                if (value.menuType == MenuType.clock) 
                return ClockPage();
                else if (value.menuType == MenuType.alarm)
                return AlarmPage();
               return Container(
                child: Center(child: Text("Heeeeeeeeeeeeeeeeeey")),
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
    borderRadius: BorderRadius.only(
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
                  style: TextStyle(
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
