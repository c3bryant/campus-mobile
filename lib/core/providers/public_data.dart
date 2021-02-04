import 'package:campus_mobile_experimental/core/models/public_data.dart';
import 'package:campus_mobile_experimental/core/providers/notifications_freefood.dart';
import 'package:campus_mobile_experimental/core/services/public_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PublicDataProvider extends ChangeNotifier {
  PublicDataProvider() {
    ///DEFAULT STATES
    _isLoading = false;

    ///INITIALIZE SERVICES
    _publicDataService = PublicDataService();
    _publicDataModel = PublicDataModel();

    ///INITIALIZE VALUES
    initializeValues();
  }

  ///VALUES

  ///STATES
  bool _isLoading;
  DateTime _lastUpdated;
  String _error;

  ///MODELS
  PublicDataModel _publicDataModel;
  FreeFoodDataProvider _freeFoodDataProvider;

  ///SERVICES
  PublicDataService _publicDataService;

  void initializeValues() {}

  /// Update the [AuthenticationModel] stored in state
  /// overwrite the [AuthenticationModel] in persistent storage with the model passed in
  Future updatePublicDataModel(PublicDataModel model) async {
    _publicDataModel = model;
    var box = await Hive.openBox<PublicDataModel>('PublicDataModel');
    await box.put('PublicDataModel', model);
    _lastUpdated = DateTime.now();
  }

  Future<void> getAccessToken() async {
    _isLoading = true;

    notifyListeners();

    if (await _publicDataService.getNewToken()) {
      _publicDataModel = _publicDataService.data;
      _lastUpdated = DateTime.now();
      await updatePublicDataModel(_publicDataService.data);
    } else {
      _error = _publicDataService.error;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// SETTER
  set freeFoodDataProvider(FreeFoodDataProvider value) {
    _freeFoodDataProvider = value;
  }

  ///SIMPLE GETTERS
  String get error => _error;
  DateTime get lastUpdated => _lastUpdated;
  PublicDataModel get publicDataModel => _publicDataModel;
}
