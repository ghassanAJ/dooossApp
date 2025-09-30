// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1000/Core/network/failure.dart';

class AuthRemouteDataSource {
  final Dio dio;

  AuthRemouteDataSource({required this.dio});
  Future<Either<String, AuthDataResponse>> SignIn() async {
    var url = 'http://10.0.2.2:8010/api/dealers/login/';
    var data = {
      "username": "@ghas2004san.58",
      "password": "gogo123@",
      "code": "9C3637C3",
    };
    try {
      var response = await dio.post(url, data: data);
      print(response.data);
      AuthDataResponse dataResponse = AuthDataResponse.fromMap(response.data);
      return right(dataResponse);
    } catch (error) {
      print(error.toString());
      return left(Failure.handleExcaption(error).massageError);
    }
  }
}

class AuthDataResponse {
  final String refresh;
  final String access;
  final User user;

  AuthDataResponse({
    required this.refresh,
    required this.access,
    required this.user,
  });

  AuthDataResponse copyWith({String? refresh, String? access, User? user}) {
    return AuthDataResponse(
      refresh: refresh ?? this.refresh,
      access: access ?? this.access,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'refresh': refresh,
      'access': access,
      'user': user.toMap(),
    };
  }

  factory AuthDataResponse.fromMap(Map<String, dynamic> map) {
    return AuthDataResponse(
      refresh: map['refresh'] as String,
      access: map['access'] as String,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthDataResponse.fromJson(String source) =>
      AuthDataResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class User {
  final int dealerId;
  final int id;
  final String name;
  final String phone;
  final String role;
  final bool verified;
  final String handle;

  User({
    required this.dealerId,
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.verified,
    required this.handle,
  });

  User copyWith({
    int? dealerId,
    int? id,
    String? name,
    String? phone,
    String? role,
    bool? verified,
    String? handle,
  }) {
    return User(
      dealerId: dealerId ?? this.dealerId,
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      verified: verified ?? this.verified,
      handle: handle ?? this.handle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dealer_id': dealerId,
      'id': id,
      'name': name,
      'phone': phone,
      'role': role,
      'verified': verified,
      'handle': handle,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      dealerId: map['dealer_id'] as int,
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
      verified: map['verified'] as bool,
      handle: map['handle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
