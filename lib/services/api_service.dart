import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductCategory {
  const ProductCategory({
    required this.id,
    required this.name,
    required this.productCount,
  });

  final int id;
  final String name;
  final int productCount;

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: int.parse(json['id'].toString()),
      name: json['name'] as String,
      productCount: int.parse(json['product_count'].toString()),
    );
  }
}

class AppUser {
  const AppUser({
    required this.id,
    required this.username,
    required this.email,
  });

  final int id;
  final String username;
  final String email;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: int.parse(json['id'].toString()),
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }
}

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ApiService {
  static const String _configuredBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
  );

  static String get baseUrl {
    if (_configuredBaseUrl.isNotEmpty) return _configuredBaseUrl;
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return 'http://localhost/babyshop_api/api.php';
    }
    return 'http://10.0.2.2/babyshop_api/api.php';
  }

  Future<List<ProductCategory>> fetchCategories() async {
    final uri = Uri.parse(baseUrl)
        .replace(queryParameters: const {'action': 'categories'});
    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw Exception(body['error'] ?? 'Could not load categories.');
    }

    final rows = body['data'] as List<dynamic>;
    return rows
        .map((row) => ProductCategory.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  Future<AppUser> register({
    required String username,
    required String email,
    required String password,
  }) {
    return _post('register', {
      'username': username,
      'email': email,
      'password': password,
    });
  }

  Future<AppUser> login({
    required String identifier,
    required String password,
  }) {
    return _post('login', {'identifier': identifier, 'password': password});
  }

  Future<AppUser> _post(String action, Map<String, String> payload) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: {'action': action});
    final response = await http
        .post(
          uri,
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        )
        .timeout(const Duration(seconds: 10));

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        body['error'] as String? ?? 'Request failed. Please try again.',
      );
    }

    return AppUser.fromJson(body['data'] as Map<String, dynamic>);
  }
}
