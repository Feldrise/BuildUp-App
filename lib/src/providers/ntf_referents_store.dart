import 'package:buildup/entities/ntf_referent.dart';
import 'package:buildup/services/ntf_referents_service.dart';
import 'package:flutter/material.dart';

class NtfReferentsStore with ChangeNotifier {
  List<NtfReferent> _ntfReferents;

  void clear() {
    _ntfReferents = null;
    
    notifyListeners();
  }

  void ntfReferentUpdated() {
    notifyListeners();
  }

  List<NtfReferent> get loadedNtfReferents => _ntfReferents;

  Future<List<NtfReferent>> ntfReferents(String authorization) async {
    return _ntfReferents ??= await NtfReferentsService.instance.getAllReferents(authorization);
  }

  bool get hasData => _ntfReferents != null && _ntfReferents.isNotEmpty;
}