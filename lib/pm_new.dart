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
  final _smallFont = const TextStyle(fontSize: 12.0);
  final _buttonTextFont = const TextStyle(fontSize: 18.0, color: Colors.white);

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
                child: new ChoiceCard(),
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


 Widget _buildDetail(Promise item) {
    return new Text("hello 2");
  }
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    return new Card(
      // body: _buildList(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text("1"),
            _buildDetail(null)
          ],
        )
      
    );
    
  }

  
  
//}
}