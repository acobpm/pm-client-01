//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PromiseNavBottom extends StatelessWidget {
  
  final int screenIndex ;
   final _biggerFont = const TextStyle(fontSize: 18.0);
  PromiseNavBottom(this.screenIndex);

  
  @override
  Widget build(BuildContext context) {
    return _buildNavBottom();
      }
    
  Widget _buildNavBottom() {



      return new BottomNavigationBar(

            currentIndex: screenIndex,
            onTap: (int index) {
              // setState(() {
              //   _screen = index;
              // });
            },
            items: [
              new BottomNavigationBarItem(
                icon: new Icon(Icons.sentiment_very_satisfied),
                title: new Text(
                  'Promise',
                  style: _biggerFont,
                ),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.account_balance_wallet),
                title: new Text(
                  'Wallet',
                  style: _biggerFont,
                ),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.report),
                title: new Text(
                  'Stats',
                  style: _biggerFont,
                ),                
              ),
             
            ],
          );

  }
  
}