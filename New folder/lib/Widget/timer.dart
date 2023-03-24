import 'dart:async';
import 'package:flutter/material.dart';

class TimerExample extends StatefulWidget {
  @override
  _TimerExampleState createState() => _TimerExampleState();
}

class _TimerExampleState extends State<TimerExample> {
  int _seconds = 0;
  bool _isActive = false;
  late Timer _timer;

  void _startTimer() {
    _isActive = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _isActive = false;
    _timer.cancel();
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$_seconds', style: Theme.of(context).textTheme.headline4),
        ],
      ),
    );
  }
}
