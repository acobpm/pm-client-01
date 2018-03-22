//import 'dart:convert';
//import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'model/data.dart';
import 'local/json.dart';
import 'util.dart';
import 'pm_detail.dart';
import 'pm_new.dart';
import 'pm_nav.dart';
import 'localization.dart';

//import 'localization.dart';

class PromiseListWidget extends StatefulWidget {
  PromiseListWidget(this.currentUser);
  @override
  createState() => new PromiseListState(currentUser);
  final String currentUser ; 
}

class PromiseListState extends State<PromiseListWidget> {
  PromiseListState(this.userMe);
  final _biggerFont = const TextStyle(fontSize: 18.0);

  List<Promise> _pmList = <Promise>[];

  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKeyH =
      new GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKeyM =
      new GlobalKey<AnimatedListState>();
  ListModel<Promise> _list, _listH, _listM;

  final String userMe; //current user

  List<Choice> choices ;


  @override
  void initState() {
    super.initState();
  
    final pmJsonList = toList(localPMList);
    for (var map in pmJsonList) {
      _pmList.add(new Promise.fromJson(map));
    }

    _list = new ListModel<Promise>(
      listKey: _listKey,
      initialItems: _pmList,
    );
    final _mList = _pmList.where((p) => p.promiseFromId == userMe).toList();
    _listM = new ListModel<Promise>(
      listKey: _listKeyM,
      initialItems: _mList,
    );

    final _hList = _pmList.where((p) => p.promiseToId == userMe).toList();
    _listH = new ListModel<Promise>(
      listKey: _listKeyH,
      initialItems: _hList,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    
  choices= new List <Choice>();
  choices.add( new Choice(id: "A", title: PMLocalizations.of(context).pgListTabAll ));
  choices.add( new Choice(id: "M", title: PMLocalizations.of(context).pgListTabMy ));
  choices.add( new Choice(id: "H", title: PMLocalizations.of(context).pgListTabHis ));

    debugPrint("Current User: " + userMe);
    return new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
            appBar: new AppBar(
              title: new Text(PMLocalizations.of(context).pgListTitle),
              bottom: new TabBar(
                isScrollable: true,
                labelStyle: _biggerFont,
                tabs: choices.map((Choice choice) {
                  return new Tab(
                    text: choice.title,                    
                  );
                }).toList(),
              ),
              // actions: <Widget>[
              //   new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
              // ],
            ),
            body: new TabBarView(
              children: choices.map((Choice choice) {
                var _filterList;
                switch (choice.id) {
                  case "M":
                    _filterList = _listM;

                    break;
                  case "H":
                    _filterList = _listH;
                    break;
                  default:
                    _filterList = _list;
                }

                return new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new ChoiceCard(choice: choice, list: _filterList),
                );
              }).toList(),
            ),
            bottomNavigationBar: new PromiseNavBottom(0),
            floatingActionButton: new FloatingActionButton(
                elevation: 0.0,
                child: new Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new PromiseMePage(null),
                      ));
                })));
  }
}

class Choice {
  const Choice({this.id, this.title});
  final String title;
  final String id;
  // final IconData icon;
}


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
      ),
    );
  }
}
