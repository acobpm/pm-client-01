
import 'package:flutter/material.dart';

import 'model/data.dart';
import 'util.dart';
import 'pm_nav.dart';
import 'localization.dart';

class PromiseMePage extends StatefulWidget {
  PromiseMePage(this.promise);

  final Promise promise;
  @override
  createState() => new PromiseMeState(promise);
}

class PromiseMeState extends State<PromiseMePage> {
  PromiseMeState(this.item);
  final Promise item;

 List<Choice> choices ;


  final _biggerFont = const TextStyle(fontSize: 18.0);
  // final _smallFont = const TextStyle(fontSize: 12.0);
  // final _buttonTextFont = const TextStyle(fontSize: 18.0, color: Colors.white);

  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 12, minute: 00);
  // DateTime _toDate = new DateTime.now();
  // TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);
  final List<String> _bonusList = <String>['10', '20', '30', '50', '100'];

  String _selBonus = '10';


  @override
  Widget build(BuildContext context) {
  choices = new List<Choice> ();
  choices.add( new Choice(title: PMLocalizations.of(context).pgNewTabGive ));
  choices.add( new Choice(title: PMLocalizations.of(context).pgNewTabRequest ));
  

    return new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(PMLocalizations.of(context).pgNewTitle),
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
                            decoration: new InputDecoration(
                              labelText: PMLocalizations.of(context).pgNewInputPromise,
                            ),
                            style: Theme
                                .of(context)
                                .textTheme
                                .display1
                                .copyWith(fontSize: 24.0)),
                        new DateTimePicker(
                          labelText: PMLocalizations.of(context).pgNewInputExpireDate,
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
                            labelText: PMLocalizations.of(context).pgNewInputBonus,
                            hintText: PMLocalizations.of(context).pgNewInputBonusHint,
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
                        new TextField(
                          decoration: new InputDecoration(
                            labelText: PMLocalizations.of(context).pgNewInputComments,
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
          floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.done),            
            onPressed: (){


            }
          )
        ));
  }
  bool iconButtonToggle = false;
  int _loveValue = 0 ;

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
            } );
            },
            color: _loveValue>0 ? Theme.of(context).primaryColor : null,
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
            } );
            },
            color: _loveValue>1 ? Theme.of(context).primaryColor : null,
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
            } );
            },
            color: _loveValue>2 ? Theme.of(context).primaryColor : null,
          ),
          
        ]
        .map((Widget button) => new SizedBox(width: 64.0, height: 64.0, child: button))
        .toList(),
      ),
    );
  }
}


class Choice {
  const Choice({this.title});
  final String title;
  // final IconData icon;
}


// class ChoiceCard extends StatelessWidget {
//   const ChoiceCard({Key key, this.choice}) : super(key: key);

//   final Choice choice;

//   Widget _buildDetail(BuildContext context, Promise item) {
//     return new Column(children: <Widget>[
//       new ListTile(
//         leading: const Icon(Icons.add_box),
//         title: new TextField(
//           maxLines: 3,
//           decoration: new InputDecoration(
//             border: new OutlineInputBorder().copyWith(),
//             hintText:  PMLocalizations.of(context).pgNewInputPromiseHint,
//           ),
//         ),
//       ),
//       new Padding(
//         padding: new EdgeInsets.symmetric(vertical: 10.0),
//         child: new Divider(
//           height: 1.0,
//         ),
//       ),
//       new ListTile(
//         leading: const Icon(Icons.date_range),
//         title: new TextField(
//           maxLines: 2,
//           decoration: new InputDecoration(
//             hintText: "Expire Date",
//           ),
//         ),
//       ),
//     ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final wordPair = new WordPair.random();
//     // return new Text(wordPair.asPascalCase);
//     return new Card(
//         // body: _buildList(),
//         child: new Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[_buildDetail(context, null)],
//     ));
//   }

// //}
// }
