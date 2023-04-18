import 'dart:developer';
import 'package:http_interceptor/http_interceptor.dart';

/* The purpose of this class is to intercept HTTP requests and responses made by the application and modify them as necessary.
   The interceptRequest method is called before a request is sent, and the interceptResponse method is called after a response is received.*/


class ApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      if (data.headers['content-type'] != 'multipart/form-data') {
        data.headers['content-type'] = 'application/json';
      }

      
    } catch (e) {
      print(e);
    }

    log(
        "------->Request Start\n${data.method}: ${data.baseUrl} \nHeaders: ${data.headers}\nBody: \n${data.body}\n<----------Request End");

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    log(

        "------->Response Start\n${data.method}${data.statusCode}: ${data.url} \nBody: \n${data.body}\n<----------Response End",);

    return data;
  }
}
