import 'package:flutter/material.dart';
import 'model/data.dart';
import 'util.dart';
import 'service/remote.dart';
import 'pm_nav.dart';
import 'pm_widget.dart';
import 'localization.dart';

class PromiseDetailPage extends StatefulWidget {
  PromiseDetailPage(this.promise, this.currentUser);

  final Promise promise;
  final String currentUser;
  @override
  createState() => new PromiseDetailState(promise, currentUser);
}

class PromiseDetailState extends State<PromiseDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _txtComments;

  PromiseDetailState(this.item, this.currentUser);
  final Promise item;
  final currentUser;
  //final _biggerFont = const TextStyle(fontSize: 18.0);
  final _textFont = const TextStyle(fontSize: 16.0);
  //final _smallFont = const TextStyle(fontSize: 12.0);
  final _buttonTextFont = const TextStyle(fontSize: 14.0, color: Colors.white);

  List<PromiseHistory> _pmHistList = [];
  PromiseStatus _pmStatus;
  @override
  void initState() {
    super.initState();

    _genTxHistoryList();
  }

  _genTxHistoryList() async {
    _pmStatus = await getPromiseStatus(item.promiseId);
    _pmHistList = await getTxHistoryList(item.promiseId, item.status);
    setState(() {
      //currently empty
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print("Detail : " + item.brief);

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(PMLocalizations.of(context).pgDetailTitle),
        actions: <Widget>[
          //new IconButton(icon: new Icon(Icons.list), onPressed: ),
        ],
      ),
      body: _buildDetail(item),
      bottomNavigationBar: new PromiseNavBottom(0),
    );
  }

  Widget _buildDetail(item) {
    return new SafeArea(
        top: false,
        bottom: false,
        child: new Column(
          children: <Widget>[
            _buildItem(item),
            new Expanded(
                child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                _buildPartnerRow(item),
                new Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTxList(context),
                      _buildAction(context)
                    ],
                  ),
                )
              ],
            ))
          ],
        ));
  }

  _buildPartnerRow(Promise item) {
    double _radius = 24.0;
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //_buildPartnerItem("Creator", item.creatorId),
        buildImage(item.creatorId, _radius),
        const Icon(
          Icons.arrow_forward,
          size: 36.0,
        ),
        buildImage(item.promiseFromId, _radius),
        //_buildPartnerItem("From", item.promiseFromId),
        const Icon(Icons.arrow_forward, size: 36.0),
        buildImage(item.promiseToId, _radius),
        // _buildPartnerItem("To", item.promiseToId),
      ],
    );
  }

  Widget _buildItem(Promise item) {
    return new CardItem(item: item, now: new DateTime.now(), onTap: () {});
  }

  _buildButtonGroup(BuildContext context) {
    var actionButtonList = {
      "BTN_ARN": [
        {
          "name": "accept",
          "text": PMLocalizations.of(context).pgDetailBtnAccept,
          "color": Colors.green,
          "icon": Icons.thumb_up
        },
        {
          "name": "reject",
          "text": PMLocalizations.of(context).pgDetailBtnReject,
          "color": Colors.red,
          "icon": Icons.thumb_down
        },
        {
          "name": "negotiate",
          "text": PMLocalizations.of(context).pgDetailBtnNegotiate,
          "color": Colors.blue,
          "icon": Icons.thumbs_up_down
        },
      ],
      "BTN_GBP": [
        {
          "name": "good",
          "text": PMLocalizations.of(context).pgDetailBtnGood,
          "color": Colors.green,
          "icon": Icons.thumb_up
        },
        {
          "name": "bad",
          "text": PMLocalizations.of(context).pgDetailBtnBad,
          "color": Colors.red,
          "icon": Icons.thumb_down
        },
        {
          "name": "pass",
          "text": PMLocalizations.of(context).pgDetailBtnPass,
          "color": Colors.blue,
          "icon": Icons.thumbs_up_down
        },
      ],
      "BTN_DONE": [
        {
          "name": "done",
          "text": PMLocalizations.of(context).pgDetailBtnDone,
          "color": Colors.green,
          "icon": Icons.done
        }
      ],
      "BTN_COMMENT": [
        {
          "name": "comments",
          "text": PMLocalizations.of(context).pgDetailBtnComment,
          "color": Colors.green,
          "icon": Icons.email
        }
      ],
      "BTN_CANCEL": [
        {
          "name": "cancel",
          "text": PMLocalizations.of(context).pgDetailBtnCancel,
          "color": Colors.red,
          "icon": Icons.cancel
        }
      ],
    };
    // find out which to use
    var thisButtonList;

    List<Widget> btnGroup = [];
    if (_pmStatus != null) {
      if (_pmStatus.nextId == currentUser){
        switch (_pmStatus.status) {
          case "NEW":
          case "NEGOTIATING":
            thisButtonList = actionButtonList["BTN_ARN"];
            
            break;
          case "FULFILLING":
            thisButtonList = actionButtonList["BTN_DONE"];
            break;  
          case "COMPLETED":
            thisButtonList = actionButtonList["BTN_GBP"];
            break; 
            
          default:
        }
      } else {
         thisButtonList = actionButtonList["BTN_COMMENT"];  
      }
      //check if cancell button can be added
      if (_pmStatus.creatorId == currentUser &&
      ["NEW","NEGOTIATING"].contains(_pmStatus.status )){
        thisButtonList.addAll(actionButtonList["BTN_CANCEL"]);
      }
      for (var btns in thisButtonList) {
          btnGroup.add(
            new Padding(
              padding: new EdgeInsets.symmetric(vertical: 10.0),
            ),
          );
          btnGroup.add(new RaisedButton(
            
            onPressed: () => _onPress(btns["name"]),
            color: btns["color"],
            child: new Row(
              children: <Widget>[
                new Icon(
                  btns["icon"],
                  color: Colors.white,
                ),
                new Text(" " + btns["text"], style: _buttonTextFont)
              ],
            ),
          ));
        } 
    }
    return btnGroup;
  }

  _buildAction(BuildContext context) {
    return new Expanded(
        flex: 2,
        child: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Align(
                alignment: Alignment.centerLeft,
                child: new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.email,
                      color: Colors.brown,
                    ),
                    new Text(PMLocalizations.of(context).pgDetailTxtComments,
                        style: _textFont),
                  ],
                ),
              ),
              new TextField(
                  maxLines: 5,
                  onChanged: (String newValue) {
                                _txtComments = newValue;
                              },
                  decoration: new InputDecoration(
                    hintText:
                        PMLocalizations.of(context).pgDetailTxtCommentHint,
                  )),
              new Column(children: _buildButtonGroup(context))
            ],
          ),
        ));
  }

  _buildTxList(BuildContext context) {
    List<PromiseHistory> list = _pmHistList; //<PromiseHistory>[];
    //final pmHisJsonList = toList(txDoneList).reversed; // from json.dart
    // for (var map in pmHisJsonList) {
    //   list.add(new PromiseHistory.fromJson(map,"Negociating"));
    // }

    return new Expanded(
        flex: 3,
        child: new Container(
            height: 400.0,
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(right: 5.0),
            padding: const EdgeInsets.all(2.0),
            decoration:
                new BoxDecoration(border: new Border.all(color: Colors.brown)),
            child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  new EntryItem(list[index]),
              itemCount: list.length,
            )));
  }

  void _onPress(String actionName) {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    print(actionName);
    if (_txtComments == null ){
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text('please input comments')
        ));
    } else {
      showPMDialog<PMDialogAction>(
                context: context,
                actionName:actionName,
                child: new AlertDialog(
                  content: new Text(
                    "Are you sure to submit?",
                    style: dialogTextStyle
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: const Text('CANCEL'),
                      onPressed: () { Navigator.pop(context, PMDialogAction.cancel); }
                    ),
                    new FlatButton(
                      child: const Text('Yes'),
                      onPressed: () { Navigator.pop(context, PMDialogAction.yes); }
                    )
                  ]
                )
              );
    }
  }
   void showPMDialog<T>({ BuildContext context, String actionName, Widget child }) {
    showDialog<T>(
      context: context, 
      builder: (BuildContext context) => child,
    )
    .then<void>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {

      _updatePromise(actionName);    

    

        _scaffoldKey.currentState.showSnackBar(new SnackBar(
         content: new Text('You selected: $value')
        ));
      }
    });
  }
  void _updatePromise(String action) async{
    var jsonMap = {
      "\$class": "com.acob.promiseme.NegotiatePromise",
      "brief": item.brief,
      "expectation":" ",
      "bonus": 0,
      "loveRate": 0,
      "deadline": "1970-01-01T00:00:00.000Z",
      "promiseId": item.promiseId,
      "promiseFromId": item.promiseFromId,
      "promiseToId": item.promiseToId,
      "currentId": currentUser,
      "message": _txtComments,  
    };
    await updatePromise(tNegotiatePromise, jsonMap);
    setState(() {
          
        });
  }
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final PromiseHistory entry;

  @override
  Widget build(BuildContext context) {
    return _buildPHItem(entry);
  }

  Widget _buildPHItem(PromiseHistory entry) {
    final _phTextFont = const TextStyle(fontSize: 14.0);
    final _phTextFontStatus =
        const TextStyle(fontSize: 12.0, color: Colors.brown);
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new ListTile(
            leading: new Column(children: <Widget>[
              //new Icon(Icons.account_box,size: 48.0,color: Colors.blue,),
              buildImage(entry.currentId, 20.0),
              new Text(entry.currentId,
                  maxLines: 1, style: const TextStyle(fontSize: 12.0))
            ]),
            title:
                new Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              new Row(
                children: <Widget>[
                  new Icon(Icons.calendar_today, color: Colors.black87),
                  new Expanded(
                      child: new Text(
                    " " + formatDate(entry.timestamp, "F"),
                    style: _phTextFont,
                  ))
                ],
              ),
              new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.assignment, color: Colors.brown),
                  new Expanded(
                      child: new Text(
                    " " + entry.status,
                    style: _phTextFontStatus,
                  ))
                ],
              )
            ])),
        new Padding(
          padding: new EdgeInsets.symmetric(vertical: 5.0),
        ),
        new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.symmetric(horizontal: 5.0),
            ),
            new Icon(Icons.email, color: Colors.black54, size: 18.0),
            new Expanded(
                child: new Text(
              " " + entry.message,
              style: _phTextFont,
            ))
          ],
        ),
        new Padding(
          padding: new EdgeInsets.symmetric(vertical: 3.0),
        ),
        const Divider(height: 1.0, color: Colors.black87),
      ],
    );
  }
}

enum PMDialogAction {
  cancel,
  discard,
  disagree,
  agree,
  yes,
  no,
}
