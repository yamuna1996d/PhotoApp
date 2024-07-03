import '../Models/ProductModel.dart';
import '../Utils/Api_Endpoints.dart';
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

  //just for post method example. function structure is similar for other Api methods.

  static Future<bool> sendAddress(
      {String? address1,String? address2,String? postalCode,int? countryId,int?stateId,int? districtId,int? cityId}) async {
    try {
      final response = await ApiRequest.send(
          method: ApiMethod.POST,
          route: ApiEndPoints.addAddress,
          body: {
            "addressLine_1":address1,
            "addressLine_2":address2,
            "country":countryId,
            "state":stateId,
            "district":districtId,
            "city":countryId,
            "postalCode": postalCode
          });

      if (response["status"] == 200) {
        print(response);
        return true;
      }

      if (response["status"] == 400) {
        print(response);
        return false;
      }

      return false;
    } catch (err) {
      print("saveChatDuration error: $err");
      return false;
    }
  }
}