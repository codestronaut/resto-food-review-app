import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/models/resto.dart';
import 'package:resto/shared/constants.dart';

class RestoSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  Restos? _restos;
  int? _founded;
  String? _message = '';
  FetchResultState? _state;

  Restos? get restos => _restos;
  int? get founded => _founded;
  String? get error => _message;
  FetchResultState? get state => _state;

  RestoSearchProvider({required this.apiService});

  Future<dynamic> fetchRestoSearchResult({String query = ''}) async {
    try {
      _state = FetchResultState.Loading;
      final restos = await apiService.searchRestaurant(query: query);

      if (query.isEmpty) {
        _state = FetchResultState.Searching;
        notifyListeners();
        return _message = 'Searching';
      } else if (restos.founded == 0) {
        _state = FetchResultState.NoData;
        notifyListeners();
        return _message = 'No Data';
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
