import 'package:flutter/material.dart';

enum FetchResultState { Loading, Searching, NoData, HasData, Failure }

enum PostResultState { Idle, Loading, Success, Failure }

class ColorPalette {
  static const Color backgroundColor = Color(0xFFF5F5F7);
}

class UrlList {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';

  static const String imageUrl =
      'https://restaurant-api.dicoding.dev/images/small/';
  static const String largeImageUrl =
      'https://restaurant-api.dicoding.dev/images/large/';
  static const String restoList = '/list';
  static const String restoDetail = '/detail/';
  static const String searchResto = '/search';
  static const String restoReview = '/review';
}
