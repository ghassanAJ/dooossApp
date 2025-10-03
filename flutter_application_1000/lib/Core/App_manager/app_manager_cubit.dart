// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_application_1000/Core/network/App_dio.dart';
import 'package:flutter_application_1000/Core/network/failure.dart';
import 'package:flutter_application_1000/Core/network/service_locator.dart';
import 'package:flutter_application_1000/features/Auth/data/Auth_remoute_data_Source.dart';
import 'package:flutter_application_1000/features/Home/data/models/data_profile_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppManagerCubit extends Cubit<StateAppManager> {
  AppManagerCubit() : super(StateAppManager());
  AppLocalDataSource dataSource = AppLocalDataSource(
    storage: FlutterSecureStorage(),
  );
  void savedDataUser(AuthDataResponse data) async {
    getIt<AppDio>().addToken(data.access);
    emit(state.copyWith(Userinfo: data));
    await dataSource.saveUserData(data);
  }

  void getDatadealer() async {
    var result = await dataSource.getUserData();
    result.fold((error) {}, (data) {
      if (data != null) {
        getIt<AppDio>().addToken(data.access);
      }
      emit(state.copyWith(Userinfo: data));
    });
  }
}

class StateAppManager {
  final AuthDataResponse? Userinfo;

  StateAppManager({this.Userinfo});

  StateAppManager copyWith({AuthDataResponse? Userinfo}) {
    return StateAppManager(Userinfo: Userinfo ?? this.Userinfo);
  }
}

class AppLocalDataSource {
  final FlutterSecureStorage storage;
  AppLocalDataSource({required this.storage});
  Future<Either<Failure, void>> saveUserData(AuthDataResponse dataUser) async {
    try {
      final encodedUserData = jsonEncode(dataUser.toJson());
      print('.....');
      print(encodedUserData.runtimeType);
      print('.....');

      await storage.write(key: '${KeysCache.token}', value: encodedUserData);
      return right(null);
    } catch (e) {
      return left(Failure(massageError: e.toString()));
    }
  }

  Future<Either<Failure, AuthDataResponse?>> getUserData() async {
    try {
      print(' ssssss');
      var value = await storage.read(key: '${KeysCache.token}');

      if (value != null) {
        var decodedUserData = jsonDecode(value);
        // print(decodedUserData);
        var result = AuthDataResponse.fromJson(decodedUserData);
        print('************************' + result.access);
        return right(result);
      } else {
        return right(null);
      }
    } catch (e) {
      print('***' + e.toString());
      return left(Failure(massageError: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteUserData() async {
    try {
      await storage.delete(key: '${KeysCache.token}');
      return right(null);
    } catch (e) {
      return left(Failure(massageError: e.toString()));
    }
  }
}

enum KeysCache { token }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:hotal_app_1/core/appManager/data/App_local_remoute_data_source.dart';
// import 'package:hotal_app_1/core/common/models/User_model.dart';
// import 'package:hotal_app_1/core/network/app_dio.dart';
// import 'package:hotal_app_1/core/network/services_locator.dart';
// import 'package:hotal_app_1/feature/auth/data/dataSource/remoute_data_source.dart/auth_remoute_data_source.dart';

// class AppCubit extends Cubit<AppState> {
//   final AppLocalDataSource dataSource;
//   AppCubit(this.dataSource) : super(AppState());
//   void savedDataUser(AuthDataResponseModel data) async {
//     getIt<AppDio>().addToken(data.accessToken);
//     emit(state.copyWith(dataUser: data));
//     await dataSource.saveUserData(data);
//   }

//   void getUsserDatafromCache() async {
//     var result = await dataSource.getUserData();
//     result.fold((failure) => null, (dataUserresponse) {
//       if (dataUserresponse != null) {
//         print(dataUserresponse.accessToken);
//         getIt<AppDio>().addToken(dataUserresponse.accessToken);
//       }
//       emit(state.copyWith(dataUser: dataUserresponse));
//     });
//   }

//   void logOut() async {
//     var result = await dataSource.deleteUserData();
//     result.fold(
//       (e) {
//         print('error log out');
//       },
//       (data) {
//         emit(state.copyWith(dataUser: null));
//       },
//     );
//   }
// }
