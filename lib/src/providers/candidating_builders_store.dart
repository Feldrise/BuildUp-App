import 'package:buildup/entities/builder.dart';
import 'package:flutter/material.dart';

class CandidatingBuilderStore with ChangeNotifier {
  List<BuBuilder> _builders;

  void clear() {
    _builders.clear();
    notifyListeners();
  }

  void builderUpdated() {
    notifyListeners();
  }

  List<BuBuilder> get builders => _builders;
  set builders(List<BuBuilder> newBuilder) {
    _builders = newBuilder;
    notifyListeners();
  }

  bool get hasData => _builders != null && _builders.isNotEmpty;
}