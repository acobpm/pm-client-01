import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'model/data.dart';
import 'util.dart';
import 'pm_nav.dart';

class PromiseMePage extends StatefulWidget {
  PromiseMePage(this.promise);

  final Promise promise;
  @override
  createState() => new PromiseMeState(promise);
}

class PromiseMeState extends State<PromiseMePage> {
  PromiseMeState(this.item);
  final Promise item;

  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _textFont = const TextStyle(fontSize: 16.0);
  // final _smallFont = const TextStyle(fontSize: 12.0);
  // final _buttonTextFont = const TextStyle(fontSize: 18.0, color: Colors.white);

  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 12, minute: 00);
  // DateTime _toDate = new DateTime.now();
  // TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);
  final List<String> _bonusList = <String>['10', '20', '30', '50', '100'];
  final List<int> _loveList = <int>[1, 2, 3];
  String _selBonus = '10';
  int _selLove = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text('Promise Me'),
            actions: <Widget>[
              //new IconButton(icon: new Icon(Icons.list), onPressed: ),
            ],
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
          ),
          body: new TabBarView(
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
                            decoration: const InputDecoration(
                              labelText: 'Promise',
                            ),
                            style: Theme
                                .of(context)
                                .textTheme
                                .display1
                                .copyWith(fontSize: 24.0)),
                        new DateTimePicker(
                          labelText: 'Expire Date',
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
                          decoration: const InputDecoration(
                            labelText: 'Bonus',
                            hintText: 'Select Bonus',
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
                        new InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Love',
                            hintText: 'Select Love',
                          ),
                          isEmpty: _selLove == 0,
                          child: new DropdownButton<int>(
                            value: _selLove,
                            isDense: true,
                            onChanged: (int newValue) {
                              setState(() {
                                _selLove = newValue;
                              });
                            },
                            items: _loveList.map((int value) {
                              return new DropdownMenuItem<int>(
                                value: value,
                                child: new Text(value.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                        new TextField(
                          decoration: const InputDecoration(
                            labelText: 'comments',
                          ),
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          bottomNavigationBar: new PromiseNavBottom(0),
        ));
  }
}

class Choice {
  const Choice({this.title});
  final String title;
  // final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Give'),
  const Choice(title: 'Request'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  Widget _buildDetail(BuildContext context, Promise item) {
    return new Column(children: <Widget>[
      new ListTile(
        leading: const Icon(Icons.add_box),
        title: new TextField(
          maxLines: 3,
          decoration: new InputDecoration(
            border: new OutlineInputBorder().copyWith(),
            hintText: "Promise",
          ),
        ),
      ),
      new Padding(
        padding: new EdgeInsets.symmetric(vertical: 10.0),
        child: new Divider(
          height: 1.0,
        ),
      ),
      new ListTile(
        leading: const Icon(Icons.date_range),
        title: new TextField(
          maxLines: 2,
          decoration: new InputDecoration(
            hintText: "Expire Date",
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    return new Card(
        // body: _buildList(),
        child: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[_buildDetail(context, null)],
    ));
  }

//}
}
