import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fitx_flutter_2/constants.dart';

class TimerCard extends StatefulWidget {
  @override
  State<TimerCard> createState() => _TimerCardState();
}

class _TimerCardState extends State<TimerCard> {
  int minutes = 0;
  int seconds = 0;

  bool check = false;

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (check == false) {
          timer.cancel();
        } else {
          seconds++;

          if (seconds == 60) {
            seconds = 0;
            minutes++;
          }
        }
      });
    });
  }

  void stopTimer() {
    setState(() {
      check = false;
      seconds = 0;
      minutes = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 170.0,
        width: 210.0,
        decoration: BoxDecoration(
            color: kMoove,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [kBoxShadow3]),
        child: Column(
          children: [
            Center(
              child: Text(
                'Rest timer',
                style: TextStyle(
                    color: kYellow,
                    fontSize: 25.0,
                    fontFamily: 'big_noodle_titling'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                '${minutes <= 9 ? '0' : ''}$minutes : ${seconds <= 9 ? '0' : ''}$seconds',
                style: TextStyle(
                    color: kYellow,
                    fontSize: 50.0,
                    fontFamily: 'big_noodle_titling'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      check = true;
                      startTimer();
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                          shadows: [kBoxShadow],
                          color: kYellow,
                          fontSize: 20.0,
                          fontFamily: 'big_noodle_titling'),
                    )),
                TextButton(
                    onPressed: () => stopTimer(),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                          shadows: [kBoxShadow],
                          color: kYellow,
                          fontSize: 20.0,
                          fontFamily: 'big_noodle_titling'),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
