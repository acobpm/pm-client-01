//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'localization.dart';
import 'pm_list.dart';
import 'pm_wallet.dart';
import 'pm_stat.dart';

class PromiseNavBottom extends StatelessWidget {
  final int screenIndex;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final currentUser;
  PromiseNavBottom(this.screenIndex, this.currentUser);

  @override
  Widget build(BuildContext context) {
    return _buildNavBottom(context);
  }

  Widget _buildNavBottom(BuildContext context) {
    return new BottomNavigationBar(
      currentIndex: screenIndex,
      onTap: (int index) {
        // setState(() {
        //   _screen = index;
        // });
        switch (index) {
          case 0:
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new PromiseListWidget(currentUser),
                ));

            break;
          case 1:
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new PromiseWalletWidget(currentUser),
                ));

            break;
          case 2:
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new PromiseStatWidget(currentUser),
                ));

            break;
          default:
        }
      },
      items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.sentiment_very_satisfied),
          title: new Text(
            PMLocalizations.of(context).pgNavPromise,
            style: _biggerFont,
          ),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.account_balance_wallet),
          title: new Text(
            PMLocalizations.of(context).pgNavWallet,
            style: _biggerFont,
          ),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.report),
          title: new Text(
            PMLocalizations.of(context).pgNavStat,
            style: _biggerFont,
          ),
        ),
      ],
    );
  }
}
