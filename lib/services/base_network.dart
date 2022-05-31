import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static final String baseUrl = "http://playtico.herokuapp.com";

  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = baseUrl + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");

    final response = await http.get(Uri.parse(fullUrl));

    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> postRegister(String partUrl, username, password, nama) async {
    Map<String, String> body = {
      'username': username,
      'password': password,
      'fullname' : nama,
    };

    final String fullUrl = baseUrl + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");

    final response = await http.post(
        Uri.parse(fullUrl),
      body: body,
    );

    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> postLogin(String partUrl, username, password) async {
    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    final String fullUrl = baseUrl + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");

    final response = await http.post(
      Uri.parse(fullUrl),
      body: body,
    );

    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> putAuthentication(String partUrl, token) async {
    Map<String, String> body = {
      'refreshToken': token,
    };
    final String fullUrl = baseUrl + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");

    final response = await http.post(
        Uri.parse(fullUrl),
        body: body,
    );

    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> getPlaylists(String partUrl, token) async {

    final String fullUrl = baseUrl + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");

    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        'Authorization': 'Bearer $token',
      }
    );

    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(http.Response response) async{
    final body = response.body;
    if(body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else{
      print("processResponse error");
      return {"error" :  true};
    }
  }



  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}