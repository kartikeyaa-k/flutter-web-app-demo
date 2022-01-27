import 'dart:io';

import 'package:flutter/services.dart';

import 'package:nuchange_web_app/network/api_exception.dart';

class ApiBaseHelper {
  final String _baseUrl = "assets/response.json";

  Future<dynamic> get() async {
    try {
      // skipping network calls as we already have the hardcoded response
      // fetch data directly from local json file
      final response = await rootBundle.loadString(_baseUrl);

      // print(':: Printing json response inside helper $response');
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
