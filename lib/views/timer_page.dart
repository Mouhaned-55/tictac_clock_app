import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  double _selectedTime = 0.0;
  Timer? _timer;
  int _seconds = 0;
  bool _started = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    int time = _selectedTime.toInt();
    if (time <= 0) return;

    setState(() {
      _seconds = time;
    });

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
    });
  }

  String getFormattedTime() {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double getProgressValue() {
    if (_selectedTime <= 0 || _seconds <= 0) {
      return 0.0;
    } else {
      return (_selectedTime - _seconds) / _selectedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2D2F41), Color(0xFF1E1F34)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 220,
                    width: 220,
                    child: CircularProgressIndicator(
                      value: getProgressValue(),
                      strokeWidth: 12,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFAC56FF)),
                      backgroundColor: Color(0xFF464B5D),
                    ),
                  ),
                  Text(
                    '${_selectedTime.toInt().toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                getFormattedTime(),
                style: TextStyle(fontSize: 72, color: Colors.white),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      if (!_started) {
                        startTimer();
                      } else {
                        stopTimer();
                      }
                      setState(() {
                        _started = !_started;
                      });
                    },
                    fillColor: Colors.blue,
                    shape: StadiumBorder(),
                    child: Text(
                      (!_started) ? "Start" : "Pause",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "avenir",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  RawMaterialButton(
                    onPressed: () {
                      stopTimer();
                      setState(() {
                        _started = false;
                        _selectedTime = 0.0;
                      });
                    },
                    fillColor: Colors.blue,
                    shape: StadiumBorder(),
                    child: Text(
                      "Stop",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "avenir",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _selectedTime = double.tryParse(value) ?? 0.0;
                    });
                  },
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Set Time (in seconds)',
                    hintStyle: TextStyle(color: Colors.white54),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
