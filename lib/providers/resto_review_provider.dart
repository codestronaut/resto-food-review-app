import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/models/resto.dart';
import 'package:resto/shared/constants.dart';

class RestoReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  CustomerReview? _review;
  String _message = '';
  PostResultState? _state = PostResultState.Idle;

  CustomerReview? get resto => _review;
  String get message => _message;
  PostResultState? get state => _state;

  RestoReviewProvider({required this.apiService});

  void setState(PostResultState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<dynamic> postReviewByRestoId({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      _state = PostResultState.Loading;
      notifyListeners();
      final restoReview = await apiService.postReviewById(
        id: id,
        name: name,
        review: review,
      );

      if (restoReview) {
        _state = PostResultState.Success;
        notifyListeners();
        return _message = 'Success';
      }
    } on TimeoutException catch (e) {
      _state = PostResultState.Failure;
      notifyListeners();
      return _message = 'TIMEOUT: $e';
    } on SocketException catch (e) {
      _state = PostResultState.Failure;
      notifyListeners();
      return _message = 'NO CONNECTION: $e';
    } on Error catch (e) {
      _state = PostResultState.Failure;
      notifyListeners();
      return _message = 'ERROR: $e';
    }
  }
}
