import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Promise {
  Promise(
      {this.promiseId,
      this.creatorId,
      this.promiseFromId,
      this.promiseToId,
      this.mood,
      this.expireTime,
      this.title,
      this.bonus,
      this.loveRate,
      this.status});
  String promiseId;
  String creatorId;
  String promiseFromId;
  String promiseToId;
  String mood;
  DateTime expireTime;
  String title;
  double bonus;
  int loveRate;
  String status;
  Promise.fromJson(Map json) {
    this.promiseId = json['promiseId'];
    this.creatorId = json['creatorId'];
    this.promiseFromId = json['promiseFromId'];
    this.promiseToId = json['promiseToId'];
    this.title = json['title'];
    this.bonus = json['bonus'];
    this.loveRate = json['loveRate'];
    this.status = json['status'];
    this.expireTime = DateTime.parse(json['expireTime']);
  }
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

  PromiseHistory.fromJson(Map json) {
    this.promiseId = json['promiseId'];
    this.currentId = json['currentId'];
    this.message = json['message'];
    this.status = json['status'];
    this.timestamp = DateTime.parse(json['timestamp']);
  }
}

