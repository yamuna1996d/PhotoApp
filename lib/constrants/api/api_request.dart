import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'api_client.dart';
import 'api_exception.dart';
import 'api_methods.dart';

/* The ApiRequest class contains a handleApiError method and a send method that sends an API request and returns the response. */

class ApiRequest {
  handleApiError(Response response) async {
    switch (response.statusCode) {
      case 400:

        try {
          Map<String, dynamic> body = jsonDecode(response.body);

          if (body["message"] != null) {

          }
        } catch (err) {

        }

        break;
      case 401:
      case 402:
        throw new UnauthorisedException();
      // case 404:
      //   throw new FetchDataException();
    }
  }

  static send({
    ApiMethod? method,
    String? enableTempUrl,
    bool getRawResponse = false,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    required String route,
    Map<String, dynamic>? queries,
  }) async {
    final api = ApiClient(
        tempUrl: enableTempUrl != null
            ? 'https://jsonplaceholder.typicode.com/'
            : null);

    late Response response;

    if (queries != null && queries.isNotEmpty) {
      queries.forEach((key, value) {
        if (value != null) {
          if (route.contains("?")) {
            route += "&$key=$value";
          } else {
            route += "?$key=$value";
          }
        }
      });
    }

    try {
      Uri uri = Uri.parse(api.url(route));
      if (method == ApiMethod.GET) {
        response = await api.client().get(uri);
      } else if (method == ApiMethod.POST) {
        response = await api.client().post(uri, body: json.encode(body));
      } else if (method == ApiMethod.DELETE) {
        await api.client().delete(uri);
      } else if (method == ApiMethod.PUT) {
        response = await api.client().put(uri, body: json.encode(body));
      }

      switch (response.statusCode) {
        case 401:
          final body = response.body;
          if (response.body != null) {
            final json = jsonDecode(response.body);

            if (json["message"] == "User not authorized") {

            }
          }

          //Token== null ? Locally open login screen
          // else API call -> 401 ? open login screen

          throw new UnauthorisedException();

        case 402:
          throw new UnauthorisedException();
        case 400:
          final body = jsonDecode(response.body);
          if (body["message"] == "Invalid token please re-login.") {

          }
        // case 404:
        //   throw new FetchDataException();
      }

      final responseBody = json.decode(response.body);
      if (response.body != null) {
        final body = jsonDecode(response.body);
        if (getRawResponse) {
          return body["url"];
        }
        return json.decode(response.body);
      }
      return responseBody;
    } on SocketException {
      print("Socket exception");
    }
  }
}
