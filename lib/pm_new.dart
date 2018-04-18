import 'dart:async';

import 'package:flutter/material.dart';


import 'model/data.dart';
import 'pm_widget.dart';
import 'pm_nav.dart';
import 'localization.dart';
import 'service/remote.dart';
import 'util.dart';

class PromiseMePage extends StatefulWidget {
  PromiseMePage(this.currentUser);

  final Couple currentUser;
  @override
  createState() => new PromiseMeState(currentUser);
}

class PromiseMeState extends State<PromiseMePage> with SingleTickerProviderStateMixin{
  PromiseMeState(this.currentUser);
  final Couple currentUser;

  List<Choice> choices;

  final _biggerFont = const TextStyle(fontSize: 18.0);
  // final _smallFont = const TextStyle(fontSize: 12.0);
  // final _buttonTextFont = const TextStyle(fontSize: 18.0, color: Colors.white);

  String _txtBrief = '';
  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 12, minute: 00);
  // DateTime _toDate = new DateTime.now();
  // TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);
  final List<String> _bonusList = <String>['10', '20', '30', '50', '100'];

  String _selBonus = '10';
  int _loveValue = 0;
  String _currentTab;
  TabController _tabController;
 
 @override
  void initState() {
    super.initState();
   
    _tabController = new TabController(vsync: this, length: 2);
  }

 @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
      choices = new List<Choice>();
    choices.add(new Choice(title: PMLocalizations.of(context).pgNewTabGive));
    choices.add(new Choice(title: PMLocalizations.of(context).pgNewTabRequest));

        return new Scaffold(
            appBar: new AppBar(
              title: new Text(PMLocalizations.of(context).pgNewTitle),
              actions: <Widget>[
                //new IconButton(icon: new Icon(Icons.list), onPressed: ),
              ],
              bottom: new TabBar(
                isScrollable: true,
                labelStyle: _biggerFont,
                controller: _tabController,
                tabs: choices.map((Choice choice) {

                 
                  return new Tab(

                    text: choice.title,
                    // icon: new Icon(choice.icon),
                  );
                }).toList(),
              ),
            ),
            body: new TabBarView(
              controller: _tabController,
              children: choices.map((Choice choice) {
                return new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new DropdownButtonHideUnderline(
                    child: new SafeArea(
                      top: false,
                      bottom: false,
                      child: new ListView(
                        padding: const EdgeInsets.all(16.0),
                        children: <Widget>[
                          new TextField(
                              decoration: new InputDecoration(
                                labelText: PMLocalizations
                                    .of(context)
                                    .pgNewInputPromise,
                              ),
                              onChanged: (String newValue) {
                                _txtBrief = newValue;
                              },
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(fontSize: 24.0)),
                          new DateTimePicker(
                            labelText: PMLocalizations
                                .of(context)
                                .pgNewInputExpireDate,
                            selectedDate: _fromDate,
                            selectedTime: _fromTime,
                            selectDate: (DateTime date) {
                              setState(() {
                                _fromDate = date;
                              });
                            },
                            selectTime: (TimeOfDay time) {
                              setState(() {
                                _fromTime = time;
                              });
                            },
                          ),
                          new InputDecorator(
                            decoration: new InputDecoration(
                              labelText:
                                  PMLocalizations.of(context).pgNewInputBonus,
                              hintText: PMLocalizations
                                  .of(context)
                                  .pgNewInputBonusHint,
                            ),
                            isEmpty: _selBonus == null,
                            child: new DropdownButton<String>(
                              value: _selBonus,
                              isDense: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _selBonus = newValue;
                                });
                              },
                              items: _bonusList.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          _buildIconButton(context),
                          // new TextField(
                          //   decoration: new InputDecoration(
                          //     labelText: PMLocalizations
                          //         .of(context)
                          //         .pgNewInputComments,
                          //   ),
                          //   style: Theme
                          //       .of(context)
                          //       .textTheme
                          //       .display1
                          //       .copyWith(fontSize: 20.0),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            bottomNavigationBar: new PromiseNavBottom(0),
            floatingActionButton: new FloatingActionButton(
                elevation: 0.0,
                child: new Icon(Icons.done),
                onPressed: () {
                  //print(choices[_tabController.index].title);
                  _makePromise(_tabController.index);
                }));
  }

  bool iconButtonToggle = false;

  Widget _buildIconButton(BuildContext context) {
    return new Align(
      alignment: const Alignment(-1.0, 0.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(PMLocalizations.of(context).pgNewTxtLove),
          new IconButton(
            icon: const Icon(
              Icons.favorite,
              size: 16.0,
              semanticLabel: 'love',
            ),
            onPressed: () {
              setState(() {
                //iconButtonToggle = !iconButtonToggle;
                _loveValue = 1;
              });
            },
            color: _loveValue > 0 ? Theme.of(context).primaryColor : null,
          ),
          new IconButton(
            icon: const Icon(
              Icons.favorite,
              size: 24.0,
              semanticLabel: 'love',
            ),
            onPressed: () {
              setState(() {
                //iconButtonToggle = !iconButtonToggle;
                _loveValue = 2;
              });
            },
            color: _loveValue > 1 ? Theme.of(context).primaryColor : null,
          ),
          new IconButton(
            icon: const Icon(
              Icons.favorite,
              size: 32.0,
              semanticLabel: 'love',
            ),
            onPressed: () {
              setState(() {
                //iconButtonToggle = !iconButtonToggle;
                _loveValue = 3;
              });
            },
            color: _loveValue > 2 ? Theme.of(context).primaryColor : null,
          ),
        ]
            .map((Widget button) =>
                new SizedBox(width: 64.0, height: 64.0, child: button))
            .toList(),
      ),
    );
  }

  Future _makePromise(int tabIndex) async {
    print("make promise :-->");
  
    String fromId ,toId;
    switch (tabIndex) {
      case 1: // request
        fromId = currentUser.parnterId;
        toId = currentUser.personId;
        break;
      case 0:// give
      default:
      fromId = currentUser.personId;
      toId = currentUser.parnterId;
    }
  
    DateTime dt = _fromDate.add(new Duration(minutes: _fromTime.hour*60+_fromTime.minute));
    var jsonMap = {
      "\$class": "com.acob.promiseme.MakePromise",
      "promiseFromId": fromId,
      "promiseToId": toId,
      "creatorId": currentUser.personId,
      "brief": _txtBrief,
      "expectation": " ",
      "bonus":_selBonus,
      "loveRate": _loveValue,
      "deadline": formatDate(dt,"R")
    };
    showDialog(context: context,
    child: progressHUD);
    await addNewPromise(jsonMap);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

class Choice {
  const Choice({this.title});
  final String title;
  // final IconData icon;
}

