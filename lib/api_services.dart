import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices{
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<dynamic>> sajjanAndDev() async{
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    print(response.statusCode);

    if(response.statusCode == 200 || response.statusCode ==201)
      {
        return jsonDecode(response.body);
      }else{
      throw Exception("Failed to load posts");
    }
  }
}