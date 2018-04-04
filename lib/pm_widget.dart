import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    if (d != null) {
      var hours = d.inHours;
      if (hours > 24) {
        return const Icon(Icons.sentiment_very_satisfied,
            color: Colors.greenAccent);
      } else if (hours > 0) {
        return const Icon(Icons.sentiment_neutral, color: Colors.orangeAccent);
      } else {
        return const Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.redAccent,
        );
      }
    } else {
      return const Icon(Icons.sentiment_very_satisfied);
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
                  height: 90.0,
                  width: 90.0,
                  child: new FittedBox(
                    fit: BoxFit.contain, // otherwise the logo will be tiny
                    child: _getMood(d),
                  ),
                ),
                new Expanded(
                    child: new Container(
                  padding: new EdgeInsets.all(2.0),
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