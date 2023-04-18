import '../Models/ProductModel.dart';
import '../constrants/api/api_exception.dart';
import '../constrants/api/api_methods.dart';
import '../constrants/api/api_request.dart';

class HomeInterface{
  static Future<List<Product>> fetchHome(int page, int limit) async {
    try {
      final response = await ApiRequest.send(
          method: ApiMethod.GET,
          route: "photos",
          queries: {
            "_page": page,
            "_limit": limit,
          });

      if (response != null) {
        return Product.convertToList(response);
      }
      return [];
    } catch (err) {
      print("Fetching subservices error: $err");
      throw ApiException(err.toString());
      return [];
    }
  }
}