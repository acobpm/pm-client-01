import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'pm_list.dart';
import 'util.dart';

class LoginWidget extends StatefulWidget {
  @override
  createState() => new LoginState();
}

class LoginState extends State<LoginWidget> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  String _loginUser = null;
  String _userImg = "Default.jpg";
  final List<String> _loginUserList = <String>["Vicki", "Mason"];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Promise Me'),
          actions: <Widget>[
            //new IconButton(icon: new Icon(Icons.list), onPressed: ),
          ],
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: new Text(
                "Select User to Login ",
                style: _biggerFont,
              ),
            ),
            new Padding(
                padding: new EdgeInsets.all(16.0),
                child: new Center(
                    child: new CircleAvatar(
                        radius: 50.0,
                        child: new Image.asset('img/' + _userImg)))),
            new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Center(
                child: new DropdownButton<String>(
                  value: _loginUser,
                  isDense: false,
                  onChanged: (String newValue) {
                    setState(() {
                      _loginUser = newValue;
                      _userImg = newValue + ".jpg";
                    });
                  },
                  items: _loginUserList.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            new Center(
              child: new RaisedButton(
                child: new Text("Login"),
                onPressed: () {
                  if (_loginUser != null) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new PromiseListWidget(_loginUser),
                        ));
                  }
                },
              ),
            ),
          ],
        ));
  }
}