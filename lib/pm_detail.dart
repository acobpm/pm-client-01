
import 'package:flutter/material.dart';
import 'model/data.dart';
import 'util.dart';
import 'local/json.dart';
import 'pm_nav.dart';
import 'pm_widget.dart';
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

  //final _biggerFont = const TextStyle(fontSize: 18.0);
  final _textFont = const TextStyle(fontSize: 16.0);
  //final _smallFont = const TextStyle(fontSize: 12.0);
  final _buttonTextFont = const TextStyle(fontSize: 18.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("Detail : " + item.brief);

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

 

  Widget _buildItem(Promise item) {
    return new CardItem(
      item: item,
          now: new DateTime.now(),
          onTap: () {
           
          }
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
