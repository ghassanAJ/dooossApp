import 'package:flutter_application_1000/Core/network/service_locator.dart';
import 'package:flutter_application_1000/features/Auth/data/Auth_remoute_data_Source.dart';
import 'package:flutter_application_1000/features/Auth/presentation/manager/Auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.data) : super(AuthState());
  final AuthRemouteDataSource data;

  void SignIn() async {
    var result = await data.SignIn();
    result.fold(
      (Error) {
        print(Error);
      },
      (data) {
        print(data.access);
        emit(state.copyWith(dataUser: data));
      },
    );
  }
}
