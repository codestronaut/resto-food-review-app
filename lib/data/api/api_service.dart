import 'package:http/http.dart' as http;
import 'package:resto/data/models/resto.dart';
import 'package:resto/shared/constants.dart';

class ApiService {
  Future<Restos> getRestaurantList() async {
    final response = await http.get(
      Uri.parse(
        '${UrlList.baseUrl}${UrlList.restoList}',
      ),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return restosFromJson(response.body);
    } else {
      throw Exception('Failed to load resto list!');
    }
  }

  Future<Resto> getRestaurantDetailById({required String id}) async {
    final response = await http.get(
      Uri.parse(
        '${UrlList.baseUrl}${UrlList.restoDetail}$id',
      ),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return restoFromJson(response.body);
    } else {
      throw Exception('Failed to load resto detail!');
    }
  }

  Future<Restos> searchRestaurant({required String query}) async {
    final response = await http.get(
      Uri.parse(
        '${UrlList.baseUrl}${UrlList.searchResto}?q=$query',
      ),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return restosFromSearchJson(response.body);
    } else {
      throw Exception('Failed to load search result!');
    }
  }

  Future<bool> postReviewById({
    required String id,
    required String name,
    required String review,
  }) async {
    final body = CustomerReview(
      id: id,
      name: name,
      review: review,
    );

    final request = await http.post(
      Uri.parse(
        '${UrlList.baseUrl}${UrlList.restoReview}',
      ),
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': '12345',
      },
      body: reviewToJson(body),
    );

    if (request.statusCode == 200) {
      print(request.body);
      return true;
    } else {
      throw Exception('Failed to post review!');
    }
  }
}
