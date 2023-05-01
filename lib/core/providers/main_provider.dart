import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {


  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  setTabIndex(int val) {
    _tabIndex = val;
    notifyListeners();
  }

}