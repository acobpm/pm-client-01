import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'model/data.dart';
import 'util.dart';
import 'local/json.dart';
import 'pm_nav.dart';
import 'localization.dart';

class PromiseDetailPage extends StatefulWidget {
  PromiseDetailPage(this.promise);

  final Promise promise;
  @override
  createState() => new PromiseDetailState(promise);
}

class PromiseDetailState extends State<PromiseDetailPage> {
  PromiseDetailState(this.item);
  final Promise item;

  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _textFont = const TextStyle(fontSize: 16.0);
  final _smallFont = const TextStyle(fontSize: 12.0);
  final _buttonTextFont = const TextStyle(fontSize: 18.0, color: Colors.white);

  int _screen = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("Detail : " + item.title);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(PMLocalizations.of(context).pgDetailTitle),
        actions: <Widget>[
          //new IconButton(icon: new Icon(Icons.list), onPressed: ),
        ],
      ),
      body: _buildDetail(item),
      bottomNavigationBar: new PromiseNavBottom(0),
    );
  }

  Widget _buildDetail(item) {
    return new SafeArea(
        top: false,
        bottom: false,
        child: new Column(
          children: <Widget>[
            _buildItem(item),
            new Expanded(
                child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                _buildPartnerRow(item),
                new Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[_buildTxList(context), _buildAction(context)],
                  ),
                )
              ],
            ))
          ],
        ));
  }

  _buildPartnerRow(Promise item) {
    double _radius = 24.0;
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //_buildPartnerItem("Creator", item.creatorId),
        buildImage(item.creatorId, _radius),
        const Icon(
          Icons.arrow_forward,
          size: 36.0,
        ),
        buildImage(item.promiseFromId, _radius),
        //_buildPartnerItem("From", item.promiseFromId),
        const Icon(Icons.arrow_forward, size: 36.0),
        buildImage(item.promiseToId, _radius),
        // _buildPartnerItem("To", item.promiseToId),
      ],
    );
  }

  // _buildPartnerItem(String partnerType, String partnerId) {
  //   Icon icon = const Icon(Icons.person_pin, size: 64.0);
  //   switch (partnerType) {
  //     case "Creator":
  //       icon = const Icon(
  //         Icons.person_pin,
  //         size: 64.0,
  //         color: Colors.blue,
  //       );
  //       break;
  //     case "From":
  //       icon = const Icon(Icons.account_box, size: 64.0, color: Colors.red);
  //       break;
  //     case "To":
  //       icon = const Icon(
  //         Icons.account_circle,
  //         size: 64.0,
  //         color: Colors.green,
  //       );
  //       break;
  //     default:
  //   }

  //   return new Column(
  //     children: <Widget>[
  //       new Container(
  //           margin: const EdgeInsets.all(10.0),
  //           color: const Color(0xFFFFFF),
  //           width: 64.0,
  //           height: 64.0,
  //           child: icon),
  //       new Text(partnerId, style: _biggerFont),
  //     ],
  //   );
  // }

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
      return const Icon(
        Icons.sentiment_very_satisfied,
        size: 36.0,
      );
    }
  }

  Duration _getDuration(Promise item, DateTime now) {
    return item.expireTime.difference(now);
  }

  Widget _buildItem(Promise item) {
    Duration d = _getDuration(item, new DateTime.now());
    return new Padding(
      padding: const EdgeInsets.all(2.0),
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
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
                  padding: new EdgeInsets.all(8.0),
                  child: new Text('${item.title}',
                      textAlign: TextAlign.left, style: _textFont),
                )),
                new SizedBox(
                    height: 90.0,
                    width: 100.0,
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

  _buildAction(BuildContext context) {
    return new Flexible(
        child: new Container(
      width: 180.0,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Align(
            alignment: Alignment.centerLeft,
            child: new Row(
              children: <Widget>[
                new Icon(
                  Icons.email,
                  color: Colors.brown,
                ),
                new Text(" "+PMLocalizations.of(context).pgDetailTxtComments, style: _textFont),
              ],
            ),
          ),
          new TextField(
              maxLines: 5,
              decoration: new InputDecoration(
                hintText: PMLocalizations.of(context).pgDetailTxtCommentHint,
              )),
          new Padding(
            padding: new EdgeInsets.symmetric(vertical: 10.0),
          ),
          new RaisedButton(
            onPressed: _onPress,
            color: Colors.green,
            child: new Row(
              children: <Widget>[
                new Icon(
                  Icons.thumb_up,
                  color: Colors.white,
                ),
                new Text(" "+PMLocalizations.of(context).pgDetailBtnGood, style: _buttonTextFont)
              ],
            ),
          ),
          new Padding(
            padding: new EdgeInsets.symmetric(vertical: 10.0),
          ),
          new RaisedButton(
            onPressed: _onPress,
            color: Colors.red,
            child: new Row(
              children: <Widget>[
                new Icon(Icons.thumb_down, color: Colors.white),
                new Text(
                  " "+PMLocalizations.of(context).pgDetailBtnBad,
                  style: _buttonTextFont,
                )
              ],
            ),
          ),
          new Padding(
            padding: new EdgeInsets.symmetric(vertical: 10.0),
          ),
          new RaisedButton(
            onPressed: _onPress,
            color: Colors.blue,
            child: new Row(
              children: <Widget>[
                new Icon(Icons.thumbs_up_down, color: Colors.white),
                new Text(
                  " "+PMLocalizations.of(context).pgDetailBtnPass,
                  style: _buttonTextFont,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  _buildTxList(BuildContext context) {
    List<PromiseHistory> list = <PromiseHistory>[];
    final pmHisJsonList = toList(txDoneList).reversed; // from json.dart
    for (var map in pmHisJsonList) {
      list.add(new PromiseHistory.fromJson(map));
    }
    return new Expanded(
        flex: 2,
        child: new Container(
            height: 300.0,
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(right: 15.0),
            padding: const EdgeInsets.all(5.0),
            decoration:
                new BoxDecoration(border: new Border.all(color: Colors.brown)),
            child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  new EntryItem(list[index]),
              itemCount: list.length,
            )));
  }

  void _onPress() {}
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final PromiseHistory entry;

  @override
  Widget build(BuildContext context) {
    return _buildPHItem(entry);
  }

  Widget _buildPHItem(PromiseHistory entry) {
    final _phTextFont = const TextStyle(fontSize: 14.0);
    final _phTextFontStatus =
        const TextStyle(fontSize: 14.0, color: Colors.brown);
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new ListTile(
            leading: new Column(children: <Widget>[
              //new Icon(Icons.account_box,size: 48.0,color: Colors.blue,),
              buildImage(entry.currentId, 20.0),
              new Text(entry.currentId,
                  maxLines: 1, style: const TextStyle(fontSize: 12.0))
            ]),
            title:
                new Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              new Row(
                children: <Widget>[
                  new Icon(Icons.calendar_today, color: Colors.black87),
                  new Expanded(
                      child: new Text(
                    " " + formatDate(entry.timestamp, "F"),
                    style: _phTextFont,
                  ))
                ],
              ),
              new Row(
                children: <Widget>[
                  new Icon(Icons.assignment, color: Colors.brown),
                  new Expanded(
                      child: new Text(
                    " " + entry.status,
                    style: _phTextFontStatus,
                  ))
                ],
              )
            ])),
        
        new Padding(
          padding: new EdgeInsets.symmetric(vertical: 5.0),
        ),
        new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.symmetric(horizontal: 5.0),
            ),
            new Icon(Icons.email, color: Colors.black54, size: 18.0),
            new Expanded(
                child: new Text(
              " " + entry.message,
              style: _phTextFont,
            ))
          ],
        ),
        new Padding(
          padding: new EdgeInsets.symmetric(vertical: 3.0),
        ),
        const Divider(height: 1.0, color: Colors.black87),
      ],
    );
  }
}
