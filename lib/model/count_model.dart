import 'package:flutter/material.dart';

class CountModel extends ChangeNotifier {
  int _count = 0;
  int _sum = 0;
  int _num = 1;

  int get count => _count;

  int get sum => _sum;

  int get num => _num;

  addCount(int a) {
    _count += a;

    notifyListeners();
  }

  addSum() {
    _sum++;

    notifyListeners();
  }

  addNum() {
    _num = _num * 2;

    notifyListeners();
  }
}
