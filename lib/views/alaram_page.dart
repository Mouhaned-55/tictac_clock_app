// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:clock_app/data/data.dart';
import 'package:clock_app/utils/custom_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [
          Text("Alarm",style: TextStyle(
            fontFamily: "avenir",
            fontWeight: FontWeight.w700,
            color: CustomColors.primaryTextColor,
            fontSize: 24
          ),
          ),
          Expanded(
            child: ListView(
              children: alarms.map<Widget>((alarm) {
                   var alarmTime = DateFormat('hh:mm aa').format(alarm.alarmDateTime!);
                      var gradientColor = GradientTemplate.gradientTemplate[alarm.gradientColorIndex!].colors;
                return Container(
                  margin: EdgeInsets.only(bottom: 32),
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                 decoration:  BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: gradientColor.last.withOpacity(0.4),blurRadius: 8,spreadRadius: 2,offset: Offset(4, 4)
                    )
                  ],
                  gradient: LinearGradient(colors:GradientTemplate.gradientTemplate[alarm.gradientColorIndex!].colors ,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
                  borderRadius: BorderRadius.all(Radius.circular(24))
                 ),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                        Icon(Icons.label,color:Colors.white ,size: 24,),
                        SizedBox(width: 8),
                        Text(alarm.title!,style: TextStyle(color: Colors.white,fontFamily: "avenir"),),
                          ],
                        ),
                        Switch(value: true,activeColor: Colors.white, onChanged: (bool value){
                            
                        })
                      ],
                    )
                   , Text("Mon-Fri",style: TextStyle(color: Colors.white,fontFamily: 'avenir'),),
          Row(
            children: [
              Text("07:00 AM",style: TextStyle(
                color: Colors.white,fontFamily: "avenir",fontSize: 24,fontWeight: FontWeight.w700
              ),),
              Icon(
                Icons.keyboard_arrow_down,
                size: 36,
                color: Colors.white,
              )
            ],
          )
                  ],
                 ),
                );
              }).followedBy([
                DottedBorder(
                  strokeWidth: 3,
                  color: CustomColors.clockOutline,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(24),
                  dashPattern: [5,
                  4],
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                    color: CustomColors.clockBG,
                    borderRadius: BorderRadius.all(Radius.circular(24))
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/add_alarm.png',scale: 1.5,),
                          SizedBox(height: 8,),
                          Text("Add Alarm",style: TextStyle(
                            color: Colors.white,fontFamily: "avenir"
                          ),)
                        ],
                      ),
                    ),
                  ),
                )
              ]).toList(),
            ),
          )
        ],
      ),
    );
  }
}