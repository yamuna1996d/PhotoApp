import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../Models/ProductModel.dart';
import 'package:http/http.dart' as http;

import '../api-interface/home.dart';

class HomeProvider with ChangeNotifier{

  List<Product>products = [];
  int _page = 1;
  void incrementPage() {
    _page += 1;
    //notifyListeners();
  }

  resetPage() {
    _page = 1;
    //notifyListeners();
  }

  Future<List<Product>> fetchProducts()async{
    var url = Uri.parse("https://demo.azinova.me/machine-test/api/get_items");
    final http.Response response = await http.get(url,
    headers: {
      'Content-Type' : 'application/json',
    });
    String responseBody = response.body;
    print(responseBody);
    var result = json.decode(responseBody);
    var productDetails = result["data"];
    products = (json.decode(responseBody)['items']as List).map((e) => Product.fromJson(e)).toList();
    notifyListeners();
    return products;
  }

  Future<List<Product>> fetchHome({bool reload = false}) async {
    if (reload) {
      resetPage();
    }

    final data = await HomeInterface.fetchHome(
        _page, 10);
    products.addAll(data);
    notifyListeners();
    incrementPage();
    return data;
  }
}