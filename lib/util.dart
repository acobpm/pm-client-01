//import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

//import 'package:jaguar_serializer/jaguar_serializer.dart';

//import 'dart:io';

final _dateFormatFull = new DateFormat('dd/MM/yyyy HH:mm:ss');
//final _dateFormatRemote = new DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');


String formatDate(DateTime dt,String type){
  if (dt ==null){
    return "";
  }
  if (type == "F"){
    return _dateFormatFull.format(dt);
  }
  //no type matches
  return "";
}

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

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: new DateTime(2015, 8),
      lastDate: new DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      selectDate(picked);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime
    );
    if (picked != null && picked != selectedTime)
      selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title.copyWith(fontSize: 16.0);
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 4,
          child: new _InputDropdown(
            labelText: labelText,
            valueText: new DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () { _selectDate(context); },
          ),
        ),
        const SizedBox(width: 12.0),
        new Expanded(
          flex: 3,
          child: new _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () { _selectTime(context); },
          ),
        ),
      ],
    );
  }
}
class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
            ),
          ],
        ),
      ),
    );
  }
}
  final imgMason = new Image.asset("img/Mason.jpg");
  final imgVicki = new Image.asset("img/Vicki.jpg");
  CircleAvatar buildImage(String name,double r){
    var img ; 
    switch (name) {
      case "Vicki":
        img= imgVicki;
        break;
      case "Mason":
        img= imgMason;
        break;
      default:
        img= imgMason;
    }
    return new CircleAvatar(
      radius: r,
      child:img,
    );
  }
