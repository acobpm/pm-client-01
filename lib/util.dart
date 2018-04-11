//import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

//import 'package:jaguar_serializer/jaguar_serializer.dart';

//import 'dart:io';

final _dateFormatFull = new DateFormat('dd/MM/yyyy HH:mm:ss');
final _dateFormatRemote = new DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'");


String formatDate(DateTime dt,String type){
  if (dt ==null){
    return "";
  }
  if (type == "F"){
    return _dateFormatFull.format(dt);
  }
  if (type == "R"){
    return _dateFormatRemote.format(dt);
  }
  //no type matches
  return "";
}

List toList(String jsonString) {
  var jsonData = json.decode(jsonString);
  
  return jsonData;
}
Map toMap(String jsonString) {
  var jsonData = json.decode(jsonString);
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
  String twoDigitHours = twoDigits(d.inHours.remainder(Duration.hoursPerDay));
  String twoDigitMinutes =
      twoDigits(d.inMinutes.remainder(Duration.minutesPerHour));
  String twoDigitSeconds =
      twoDigits(d.inSeconds.remainder(Duration.secondsPerMinute));
  // String sixDigitUs =
  //     sixDigits(inMicroseconds.remainder(microsecondsPerSecond));
  //print("$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds");
  var days = "";
  if (d.inDays > 0) {
    days = d.inDays.toString() + "d";
  }
  return "$days $twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
}