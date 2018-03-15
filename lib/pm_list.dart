//import 'dart:convert';
//import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'model/data.dart';
import 'local/json.dart';
import 'util.dart';
import 'pm_detail.dart';

class PromiseListWidget extends StatefulWidget {
  @override
  createState() => new PromiseListState();
}

class PromiseListState extends State<PromiseListWidget> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  int _screen = 0;
  List<Promise> _pmList = <Promise>[];
  //new Promise(expireTime:new DateTime(2018,3,8,12,0,0),title: 'Wash dishes tonight!',bonus: 10.0, loveRate: 1, status: "Expired"),
  //new Promise(expireTime:new DateTime(2018,3,10,12,0,0),title: 'Mown the lawn!',bonus: 20.0, loveRate: 2, status: "Fufilling"),
  //new Promise(expireTime:new DateTime(2018,3,15,12,0,0),title: 'Give Mason a 10 min back massage',bonus: 10.0, loveRate: 1, status: "Neg"),

  // const Promise(title: 'My Promise'),
  // const Promise(title: 'Her Promise'),
  // ];

  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  ListModel<Promise> _list;

  @override
  void initState() {
    super.initState();

    debugPrint("###### setup list#########");
    final pmJsonList = toList(localPMList);
    for (var map in pmJsonList) {
      _pmList.add(new Promise.fromJson(map));
    }

    _list = new ListModel<Promise>(
      listKey: _listKey,
      initialItems: _pmList,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    return new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text('Promise List'),
            bottom: new TabBar(
              isScrollable: true,
              labelStyle: _biggerFont,
              tabs: choices.map((Choice choice) {
                return new Tab(
                  text: choice.title,
                  // icon: new Icon(choice.icon),
                );
              }).toList(),
            ),
            // actions: <Widget>[
            //   new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
            // ],
          ),
          body: new TabBarView(
            children: choices.map((Choice choice) {
              return new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new ChoiceCard(choice: choice, list: _list),
              );
            }).toList(),
          ),
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
        ));
  }
}

class Choice {
  const Choice({this.title});
  final String title;
  // final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'ALL'),
  const Choice(title: 'My Promise'),
  const Choice(title: 'Her Promise'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice, this.list}) : super(key: key);

  final Choice choice;
  final ListModel list;

  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    return new Scaffold(
      // body: _buildList(),
      body: new AnimatedList(
        key: list.listKey,
        initialItemCount: list.length,
        itemBuilder: _buildItem,
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    var currentPromise = list[index];
    return new CardItem(
        animation: animation,
        item: currentPromise,
        now: new DateTime.now(),
        onTap: () {
          debugPrint("tapped " + currentPromise.promiseId);
          Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new PromiseDetailPage(currentPromise),
              ));
        });
  }

//}
}

class CardItem extends StatelessWidget {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _textFont = const TextStyle(fontSize: 16.0);
  final _smallFont = const TextStyle(fontSize: 12.0);
  const CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected: false,
      this.now})
      : assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final Promise item;
  final bool selected;
  final now;

  Duration _getDuration() {
    return item.expireTime.difference(now);
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
      child: new SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
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
      ),
    );
  }
}
