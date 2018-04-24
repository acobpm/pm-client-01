
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'model/data.dart';

//import 'util.dart';

import 'pm_new.dart';
import 'pm_nav.dart';
import 'localization.dart';
import 'service/remote.dart';


class PromiseStatWidget extends StatefulWidget {
  PromiseStatWidget(this.currentUser);
  @override
  createState() => new PromiseStatState(currentUser);
  final Couple currentUser;
}

class PromiseStatState extends State<PromiseStatWidget> {
  PromiseStatState(this.currentUser);
  final _biggerFont = const TextStyle(fontSize: 18.0);


  final Couple currentUser;
  String userMe ;//current user
  String userPartner ;

  List<Choice> choices;

  @override
  void initState() {
    super.initState();
    userMe = currentUser.personId;
   
  }

 

  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);

    choices = new List<Choice>();
    choices.add(
        new Choice(id: "M", title: "Me"));//PMLocalizations.of(context).pgListTabAll));
    choices.add(
        new Choice(id: "C", title: "Couple"));// PMLocalizations.of(context).pgListTabMy));
    

    //debugPrint("Current User: " + userMe);
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
              

                return new Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new ChoiceCard(choice: choice, userMe: userMe),
                );
              }).toList(),
            ),
            bottomNavigationBar: new PromiseNavBottom(2,currentUser)
            
                )
                );
  }
}

class Choice {
  const Choice({this.id, this.title});
  final String title;
  final String id;
  // final IconData icon;
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice, this.userMe}) : super(key: key);

  final Choice choice;
  // final ListModel list;
   final userMe;
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    return new Scaffold(
      body: new Text("Stat"
      ),
      // body: new AnimatedList(
      //   key: list.listKey,
      //   initialItemCount: list.length,
      //   itemBuilder: _buildItem,
      // ),
    );
  }

  

}


