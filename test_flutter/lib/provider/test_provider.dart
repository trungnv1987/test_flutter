import 'package:flutter/foundation.dart';

final class TestProvider extends ChangeNotifier {
  final List<int> _list = [];

  List<int> get list => _list;

  void add(int value) {
    _list.add(value);
    notifyListeners();
  }
}
