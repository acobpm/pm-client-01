//import 'dart:convert';
//import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'model/data.dart';

//import 'util.dart';
import 'pm_widget.dart';
import 'pm_detail.dart';
import 'pm_new.dart';
import 'pm_nav.dart';
import 'localization.dart';
import 'service/remote.dart';
//import 'local/json.dart';
//import 'localization.dart';

class PromiseListWidget extends StatefulWidget {
  PromiseListWidget(this.currentUser);
  @override
  createState() => new PromiseListState(currentUser);
  final String currentUser;
}

class PromiseListState extends State<PromiseListWidget> {
  PromiseListState(this.userMe);
  final _biggerFont = const TextStyle(fontSize: 18.0);

  List<Promise> _pmList = <Promise>[];
  List<Promise> _mPmList = <Promise>[];
  List<Promise> _hPmList = <Promise>[];

  final String userMe; //current user

  List<Choice> choices;

  @override
  void initState() {
    super.initState();

    _getPMList();
  }

  _getPMList() async {
   
  _pmList = await getPMList(userMe);
  
    setState(() {

      _mPmList = _pmList.where((p) => p.promiseFromId == userMe).toList();
      _hPmList = _pmList.where((p) => p.promiseToId == userMe).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);

    choices = new List<Choice>();
    choices.add(
        new Choice(id: "A", title: PMLocalizations.of(context).pgListTabAll));
    choices.add(
        new Choice(id: "M", title: PMLocalizations.of(context).pgListTabMy));
    choices.add(
        new Choice(id: "H", title: PMLocalizations.of(context).pgListTabHis));

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
                    _filterList =_mPmList ;

                    break;
                  case "H":
                    _filterList = _hPmList;
                    break;
                  default:
                    _filterList = _pmList;
                }

                return new Padding(
                  padding: const EdgeInsets.all(5.0),
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
  // final ListModel list;
  final List<Promise> list;
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    return new Scaffold(
      body: _buildPMList(context),
      // body: new AnimatedList(
      //   key: list.listKey,
      //   initialItemCount: list.length,
      //   itemBuilder: _buildItem,
      // ),
    );
  }

  Widget _buildPMList(BuildContext conext) {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) => new CardItem(
          item: list[index],
          now: new DateTime.now(),
          onTap: () {
            debugPrint("tapped " + list[index].promiseId);
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new PromiseDetailPage(list[index]),
                ));
          }),
      itemCount: list.length,
    );
  }

}


