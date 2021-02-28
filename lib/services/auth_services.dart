import 'dart:async';
import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' as http;

class AuthService{
  Future<Map> sendDataToServer(Map body) async {
    print('ggggggggg');
    final response = await http.post('http://roocket.org/api/login',
        body: body);
    var responseBody = json.decode(response.body);
    print(response.statusCode);

    return responseBody;
  }

  static Future<bool> checkApiToken(String apiToken) async{
    final response = await http.get('http://roocket.org/api/user?api_token=${apiToken}',headers: {'Accept' : 'application/json'});
    return response.statusCode == 200;
  }


}