import 'dart:convert';
import 'dart:io';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:nuchange_web_app/network/api_exception.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<dynamic> update() async {
    try {} on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
