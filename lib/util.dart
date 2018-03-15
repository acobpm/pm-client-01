//import 'package:flutter/foundation.dart';
import 'dart:convert';
//import 'package:jaguar_serializer/jaguar_serializer.dart';

//import 'dart:io';

List<Map> toList(String jsonString) {
  final jsonData = JSON.decode(jsonString);
  return jsonData;
}

String convertString(Duration d) {
  // String sixDigits(int n) {
  //   if (n >= 100000) return "$n";
  //   if (n >= 10000) return "0$n";
  //   if (n >= 1000) return "00$n";
  //   if (n >= 100) return "000$n";
  //   if (n >= 10) return "0000$n";
  //   return "00000$n";
  // }

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  if (d.inMicroseconds < 0) {
    return "00:00:00";
  }
  String twoDigitHours = twoDigits(d.inHours.remainder(Duration.HOURS_PER_DAY));
  String twoDigitMinutes =
      twoDigits(d.inMinutes.remainder(Duration.minutesPerHour));
  String twoDigitSeconds =
      twoDigits(d.inSeconds.remainder(Duration.secondsPerMinute));
  // String sixDigitUs =
  //     sixDigits(inMicroseconds.remainder(microsecondsPerSecond));
  print("$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds");
  var days = "";
  if (d.inDays > 0) {
    days = d.inDays.toString() + "d";
  }
  return "$days $twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
}
