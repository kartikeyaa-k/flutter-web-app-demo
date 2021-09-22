import 'dart:convert';

import 'package:nuchange_web_app/network/api_base_helper.dart';
import 'package:nuchange_web_app/network/data/product.dart';

class MovieRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Product>> fetchProductList() async {
    final response = await _helper.get();

    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => new Product.fromJson(json)).toList();
  }
}
