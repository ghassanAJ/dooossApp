// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_1000/features/Auth/data/Auth_remoute_data_Source.dart';

class AuthState {
  final AuthDataResponse? dataUser;

  AuthState({this.dataUser});

  AuthState copyWith({AuthDataResponse? dataUser}) {
    return AuthState(dataUser: dataUser ?? this.dataUser);
  }
}
