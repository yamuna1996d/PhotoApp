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