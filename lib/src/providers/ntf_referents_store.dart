import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/services/ntf_referents_service.dart';
import 'package:flutter/material.dart';

class NtfReferentsStore with ChangeNotifier {
  List<NtfReferent>? _ntfReferents;

  void clear() {
    _ntfReferents = null;
    
    notifyListeners();
  }

  void ntfReferentUpdated() {
    notifyListeners();
  }

  List<NtfReferent>? get loadedNtfReferents => _ntfReferents;

  Future<List<NtfReferent>> ntfReferents(String authorization) async {
    return _ntfReferents ??= await NtfReferentsService.instance.getAllReferents(authorization);
  }

  bool get hasData => _ntfReferents != null && _ntfReferents!.isNotEmpty;

  Future addReferent(String authorization, NtfReferent toAdd) async {
    if (_ntfReferents == null) {
      return;
    }

    try {
      toAdd.id = await NtfReferentsService.instance.addReferent(authorization, toAdd);

      _ntfReferents!.add(toAdd);
    }
    on Exception {
      rethrow;
    }

    notifyListeners();
  }

  Future updateReferent(String authorization, NtfReferent toUpdate) async {
    try {
      await NtfReferentsService.instance.updateReferent(authorization, toUpdate);
    }
    on Exception {
      rethrow;
    }

    notifyListeners();
  }
  
  Future removeReferent(String authorization, NtfReferent toRemove) async {
    if (_ntfReferents == null || toRemove.id == null) {
      return;
    }

    try {
      await NtfReferentsService.instance.deleteReferent(authorization, toRemove.id!);

      _ntfReferents!.remove(toRemove);
    }
    on Exception {
      rethrow;
    }

    notifyListeners();
  }

}