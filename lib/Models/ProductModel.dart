class Product {
  int? id;
  String? title;
  String? url,thumbnailUrl;

  Product({this.id, this.title, this.url,this.thumbnailUrl});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  static List<Product> convertToList(List<dynamic> list) {
    return list.map((e) => Product.fromJson(e)).toList();
  }
}
