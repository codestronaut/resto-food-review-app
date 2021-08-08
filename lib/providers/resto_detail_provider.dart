import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/models/resto.dart';
import 'package:resto/shared/constants.dart';

class RestoDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  Resto? _resto;
  String _message = '';
  FetchResultState? _state;

  Resto? get resto => _resto;
  String get message => _message;
  FetchResultState? get state => _state;

  RestoDetailProvider({required this.apiService});

  Future<dynamic> fetchRestoDetail(String id) async {
    try {
      _state = FetchResultState.Loading;
      final resto = await apiService.getRestaurantDetailById(id: id);

      if (resto.item == null) {
        _state = FetchResultState.NoData;
        notifyListeners();
        return _message = resto.message!;
      } else {
        _state = FetchResultState.HasData;
        notifyListeners();
        return _resto = resto;
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
