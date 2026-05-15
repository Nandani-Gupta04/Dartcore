import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/model/user.dart';

class UserServices {
 static Future<List<User>> fetchUsers() async {
    final url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body=response.body;
    final json =jsonDecode(body);
final results=json['results'] as List<dynamic>;
    final users= results.map((e){
      return User.fromMap(e);
    }).toList();
    return users;
    }
  }

