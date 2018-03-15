import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'model/data.dart';
import 'util.dart';

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
        title: new Text('Promise Detail'),
        actions: <Widget>[
          //new IconButton(icon: new Icon(Icons.list), onPressed: ),
        ],
      ),
      body: _buildDetail(item),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _screen,
        onTap: (int index) {
          setState(() {
            _screen = index;
          });
        },
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.sentiment_very_satisfied),
            title: new Text(
              'Promise',
              style: _biggerFont,
            ),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.account_balance_wallet),
            title: new Text(
              'Wallet',
              style: _biggerFont,
            ),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.report),
            title: new Text(
              'Stats',
              style: _biggerFont,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(item) {
    return new Center(
        child: new Column(
      children: <Widget>[
        _buildItem(item),
        _buildPartnerRow(item),
        new Padding(
          padding: new EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_buildTxList(), _buildAction()],
          ),
        )
      ],
    ));
  }

  _buildPartnerRow(Promise item) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildPartnerItem("Creator", item.creatorId),
        const Icon(
          Icons.arrow_forward,
          size: 48.0,
        ),
        _buildPartnerItem("From", item.promiseFromId),
        const Icon(Icons.arrow_forward, size: 48.0),
        _buildPartnerItem("To", item.promiseToId),
      ],
    );
  }

  _buildPartnerItem(String partnerType, String partnerId) {
    Icon icon = const Icon(Icons.person_pin, size: 64.0);
    switch (partnerType) {
      case "Creator":
        icon = const Icon(
          Icons.person_pin,
          size: 64.0,
          color: Colors.blue,
        );
        break;
      case "From":
        icon = const Icon(Icons.account_box, size: 64.0, color: Colors.red);
        break;
      case "To":
        icon = const Icon(
          Icons.account_circle,
          size: 64.0,
          color: Colors.green,
        );
        break;
      default:
    }

    return new Column(
      children: <Widget>[
        new Container(
            margin: const EdgeInsets.all(10.0),
            color: const Color(0xFFFFFF),
            width: 64.0,
            height: 64.0,
            child: icon),
        new Text(partnerId, style: _biggerFont),
      ],
    );
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
                            Icons.loyalty,
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

  _buildAction() {
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
                new Text(" Comments", style: _textFont),
              ],
            ),
          ),
          new TextField(
              maxLines: 5,
              decoration: new InputDecoration(
                hintText: 'Input your comments',
              )),
          new Padding(
            padding: new EdgeInsets.symmetric(vertical: 20.0),
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
                new Text("   GOOD", style: _buttonTextFont)
              ],
            ),
          ),
          new Padding(
            padding: new EdgeInsets.symmetric(vertical: 20.0),
          ),
          new RaisedButton(
            onPressed: _onPress,
            color: Colors.red,
            child: new Row(
              children: <Widget>[
                new Icon(Icons.thumb_down, color: Colors.white),
                new Text(
                  "   BAD",
                  style: _buttonTextFont,
                )
              ],
            ),
          ),
          new Padding(
            padding: new EdgeInsets.symmetric(vertical: 20.0),
          ),
          new RaisedButton(
            onPressed: _onPress,
            color: Colors.blue,
            child: new Row(
              children: <Widget>[
                new Icon(Icons.thumbs_up_down, color: Colors.white),
                new Text(
                  "   PASS",
                  style: _buttonTextFont,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  _buildTxList() {
    return new Expanded(
        flex: 2,
        child: new Container(
            height: 420.0,
            margin: const EdgeInsets.only(right: 15.0),
            padding: const EdgeInsets.all(3.0),
            decoration:
                new BoxDecoration(border: new Border.all(color: Colors.brown)),
            child: new ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(5.0),
              children: <Widget>[
                const Text('I\'m dedicating every day to you'),
                const Text('Domestic life was never quite my style'),
                const Text('When you smile, you knock me out, I fall apart'),
                const Text('And I thought I was so smart'),
                const Text('I\'m dedicating every day to you'),
                const Text('Domestic life was never quite my style'),
                const Text('When you smile, you knock me out, I fall apart'),
                const Text('And I thought I was so smart'),
                const Text('I\'m dedicating every day to you'),
                const Text('Domestic life was never quite my style'),
                const Text('When you smile, you knock me out, I fall apart'),
                const Text('And I thought I was so smart'),
                const Text('I\'m dedicating every day to you'),
                const Text('Domestic life was never quite my style'),
                const Text('When you smile, you knock me out, I fall apart'),
                const Text('And I thought I was so smart'),
                const Text('I\'m dedicating every day to you'),
                const Text('Domestic life was never quite my style'),
                const Text('When you smile, you knock me out, I fall apart'),
                const Text('And I thought I was so smart'),
                const Text('I\'m dedicating every day to you'),
                const Text('Domestic life was never quite my style'),
                const Text('When you smile, you knock me out, I fall apart'),
                const Text('And I thought I was so smart'),
                const Text('I\'m dedicating every day to you'),
                const Text('Domestic life was never quite my style'),
                const Text('When you smile, you knock me out, I fall apart'),
                const Text('And I thought I was so smart'),
              ],
            )));
  }

  void _onPress() {}
}
