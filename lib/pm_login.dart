import 'package:flutter/material.dart';
import 'pm_list.dart';
import 'localization.dart';
import 'service/remote.dart';
class LoginWidget extends StatefulWidget {
  @override
  createState() => new LoginState();
}

class LoginState extends State<LoginWidget> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  String _loginUser;
  
  List<String> _loginUserList =[" "];//new List<String>() ; //<String>["Vicki", "Mason"];

  @override
  void initState() {
    super.initState();
    _getCoupleList(); 
    //final pmJsonList = toList(localPMList);
    
  }

  _getCoupleList() async {
    var listCouples = await getCoupleList();    
    print ("Couples " +listCouples.length.toString());
    setState((){
      _loginUserList = listCouples; 
    });
     
  }
  Image _getPersonImg(String user){
    var img; 
    try {
      img = new Image.asset('img/' + user + ".jpg");
    } catch (exception){ 
      img = new Image.asset('img/Default.jpg');
    }
    return img ; 
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(PMLocalizations.of(context).pgLoginTitle),
          actions: <Widget>[
            //new IconButton(icon: new Icon(Icons.list), onPressed: ),
          ],
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: new Text(
                PMLocalizations.of(context).pgLoginTxtSelectUser,
                style: _biggerFont,
              ),
            ),
            new Padding(
                padding: new EdgeInsets.all(16.0),
                child: new Center(
                    child: new CircleAvatar(
                        radius: 50.0,
                        child: _getPersonImg(_loginUser)))),
            new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Center(
                child: new DropdownButton<String>(
                  value: _loginUser,
                  isDense: false,
                  onChanged: (String newValue) {
                    setState(() {
                      _loginUser = newValue;
                      
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
                child: new Text(PMLocalizations.of(context).pgLoginBtnLogin),
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
