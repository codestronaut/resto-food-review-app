import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/models/resto.dart';
import 'package:resto/shared/constants.dart';

class RestoListProvider extends ChangeNotifier {
  final ApiService apiService;

  Restos? _restos;
  String _message = '';
  FetchResultState? _state;

  Restos? get restos => _restos;
  String get message => _message;
  FetchResultState? get state => _state;

  RestoListProvider({required this.apiService});

  Future<dynamic> fetchRestoList() async {
    try {
      _state = FetchResultState.Loading;
      final restos = await apiService.getRestaurantList();

      if (restos.count == 0) {
        _state = FetchResultState.NoData;
        notifyListeners();
        return _message = restos.message!;
      } else {
        _state = FetchResultState.HasData;
        notifyListeners();
        return _restos = restos;
      }
    } on TimeoutException catch (e) {
      _state = FetchResultState.Failure;
      notifyListeners();
      return _message = 'TIMEOUT: $e';
    } on SocketException catch (e) {
      _state = FetchResultState.Failure;
      notifyListeners();
      return _message = 'NO CONNECTION: $e';
    } on Error catch (e) {
      _state = FetchResultState.Failure;
      notifyListeners();
      return _message = 'ERROR: $e';
    }
  }
}
