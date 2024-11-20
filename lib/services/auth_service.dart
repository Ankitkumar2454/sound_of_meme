import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sound_of_meme/modals/user.dart';
import 'dart:convert';

class AuthService extends ChangeNotifier {
  final storage = new FlutterSecureStorage();
  String _token = '';
  User? _user;
  bool get isAuthenticated => _token.isNotEmpty;
  User? get user => _user;

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://143.244.131.156:8000/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final data = json.decode(response.body);
      _token = data['access_token'];
      print(_token);
      await storage.write(key: 'jwt_token', value: _token);
      notifyListeners();
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> signup(String email, String password, String name) async {
    final url = Uri.parse('http://143.244.131.156:8000/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password, 'name': name}),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _token = data['access_token'];
      print(_token);
      await storage.write(key: 'jwt_token', value: _token);
      notifyListeners();
    } else {
      throw Exception('Failed to signup');
    }
  }

  Future<void> logout() async {
    _token = '';
    await storage.delete(key: 'jwt_token');
    notifyListeners();
  }

  Future<void> fetchUserDetails() async {
    final url = Uri.parse('http://143.244.131.156:8000/user');
    final _token = await storage.read(key: 'jwt_token');
    print(_token);
    print("user");
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      print(data);
      _user = User.fromJson(data);
      print(_user?.name);
      notifyListeners();
    } else {
      throw Exception('Failed to fetch user details');
    }
  }
}
