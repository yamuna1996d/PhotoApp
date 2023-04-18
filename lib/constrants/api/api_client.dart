/*
  ApiClient is a base client for sending APis from app to the server.
  Why it is used?
  This class can be used in all APi calls so that everything will be loose coupled
  like setting headers, changing base url made very easy
 */
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'api_interceptor.dart';

class ApiClient {
  String baseUrl = 'https://jsonplaceholder.typicode.com/';
  final String? tempUrl;

  ApiClient({this.tempUrl});

  http.Client client() {
    http.Client client =  InterceptedClient
        .build(interceptors: [ApiInterceptor()]);
    return client;
  }

  String url(String? route) {
    if(tempUrl!=null){
      return "$tempUrl$route";
    }
    return "$baseUrl$route";
  }
}
