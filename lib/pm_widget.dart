import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:progress_hud/progress_hud.dart';

import 'model/data.dart';
import 'util.dart';


class CardItem extends StatelessWidget {

  final _textFont = const TextStyle(fontSize: 16.0);
  final _smallFont = const TextStyle(fontSize: 12.0);
  const CardItem(
      {Key key,      
      this.onTap,
      @required this.item,
      this.selected: false,
      this.now})
      : //assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  final VoidCallback onTap;
  final Promise item;
  final bool selected;
  final now;

  Duration _getDuration() {
    return item.deadline.difference(now);
  }

  Icon _getMood(Duration d) {
    const _iconSize = 12.0 ; 
    if (d != null) {
      var hours = d.inHours;
      if (hours > 24) {
        return const Icon(Icons.sentiment_very_satisfied,
           size:_iconSize,
            color: Colors.greenAccent);
      } else if (hours > 0) {
        return const Icon(Icons.sentiment_neutral, 
                    size:_iconSize,
                    color: Colors.orangeAccent);
      } else {
        return const Icon(
          Icons.sentiment_dissatisfied,
          size:_iconSize,
          color: Colors.redAccent,
        );
      }
    } else {
      return const Icon(Icons.sentiment_very_satisfied, size:_iconSize,color: Colors.greenAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TextStyle textStyle = Theme.of(context).textTheme.display1;
    // if (selected)
    //   textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    Duration d = _getDuration();
    return new Padding(
      padding: const EdgeInsets.all(2.0),
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: new SizedBox(
          height: 90.0,
          child: new Card(
              // child: new Center(
              //   child: new Text(' ${item.title}', style: _biggerFont),
              //
               
              child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                new SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child: new FittedBox(
                    fit: BoxFit.contain, // otherwise the logo will be tiny

                    child: _getMood(d),
                  ),
                ),
                new Expanded(
                    child: new Container(
                  padding: new EdgeInsets.all(4.0),
                  child: new Text('${item.brief}',
                      textAlign: TextAlign.left, style: _textFont),
                )),
                new SizedBox(
                    height: 90.0,
                    width: 120.0,
                    child: new Column(children: <Widget>[
                      new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const Icon(Icons.access_alarm),
                          new Text(convertString(d),
                              textAlign: TextAlign.left, style: _smallFont),
                        ],
                      ),
                      new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ),
                          new Text(
                            ' ${item.loveRate}',
                            textAlign: TextAlign.left,
                            style: _smallFont,
                          ),
                          const Icon(Icons.attach_money,
                              color: Colors.greenAccent),
                          new Text('${item.bonus}',
                              textAlign: TextAlign.left, style: _smallFont),
                        ],
                      ),
                      new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const Icon(Icons.question_answer,
                              color: Colors.brown),
                          new Text(' ${item.status}',
                              textAlign: TextAlign.left, style: _smallFont),
                        ],
                      ),
                    ])),
              ])),
        ),
      ),
    );
  }
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

  var progressHUD = new ProgressHUD(
        backgroundColor: Colors.black12,
        color: Colors.white,
        containerColor: Colors.blue,
        borderRadius: 5.0,
      );