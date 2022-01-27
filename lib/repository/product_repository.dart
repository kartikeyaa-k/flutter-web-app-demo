import 'dart:convert';

import 'package:nuchange_web_app/network/api_base_helper.dart';
import 'package:nuchange_web_app/network/data/product.dart';

class ProductRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Product>> fetchProductList() async {
    final response = await _helper.get();

    // handle response
    try {
      final parsed =
          json.decode(response.toString()).cast<Map<String, dynamic>>();
      return parsed.map<Product>((json) => new Product.fromJson(json)).toList();
    } catch (e) {
      // throw error
      // for now just sending empty list
      return [];
    }
  }
}
