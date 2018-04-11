import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Promise {
  Promise(
      {this.promiseId,
      this.creatorId,
      this.promiseFromId,
      this.promiseToId,
      this.mood,
      this.deadline,
      this.brief,
      this.bonus,
      this.loveRate,
      this.status});
  String promiseId;
  String creatorId;
  String promiseFromId;
  String promiseToId;
  String mood;
  DateTime deadline;
  String brief;
  double bonus;
  int loveRate;
  String status;
  Promise.fromJson(Map json) {
    this.promiseId = json['promiseId'];
    this.creatorId = _getPersonIdByResource(json['creator']);
    this.promiseFromId = _getPersonIdByResource(json['promiseFrom']);
    this.promiseToId = _getPersonIdByResource(json['promiseTo']);
    this.brief = json['brief'];
    this.bonus = json['bonus'].toDouble(); //double.parse(json['bonus'].toString());
    this.loveRate = json['loveRate']; 
    this.status = json['status'];
    this.deadline = DateTime.parse(json['deadline']);
  }
}
_getPersonIdByResource(String r){
  String rt = "";
  if (r!=null){
      final arr = r.split('#');
      if (arr.length == 2){
        rt = arr[1];
      } else {
        rt = r ;
      }
  }
  return rt; 
}
class ListModel<E> {
  ListModel({
    @required this.listKey,
    // @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })
      : assert(listKey != null),
        //assert(removedItemBuilder != null),
        _items = new List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  //final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  // removeAt(int index) {
  //   final E removedItem = _items.removeAt(index);
  //   if (removedItem != null) {
  //     _animatedList.removeItem(index, (BuildContext context, Animation<double> animation) {
  //       return removedItemBuilder(removedItem, context, animation);
  //     });
  //   }
  //   return removedItem;
  // }

  int get length => _items.length;
  E operator [](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);
}

class PromiseHistory {
  PromiseHistory({
    this.promiseId,
    this.currentId,
    this.message,
    this.status,
    this.timestamp,
  });
  String promiseId;
  String currentId;
  String message;
  String status;
  DateTime timestamp;

  PromiseHistory.fromJson(Map json,String status) {
    this.promiseId = json['promiseId'];
    this.currentId = json['currentId'];
    this.message = json['message'];
    this.status = status;//json['status'];
    this.timestamp = DateTime.parse(json['timestamp']);
  }
}

class PromiseStatus {
  PromiseStatus({
    this.promiseId,
    this.nextId,
    this.currentId,
    this.preStatus,
    this.status,
  });
  String promiseId;
  String currentId;
  String nextId;
  String status;
  String preStatus;

  PromiseStatus.fromJson(Map json) {
    this.promiseId = json['promiseId'];
    this.currentId = json['currentId'];
    this.nextId = json['nextId'];
    this.status = json['status'];
    this.preStatus = json['preStatus'];;
  }
}