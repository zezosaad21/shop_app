import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/shared/endpoint.dart';
import 'package:shop_app/shared/remot/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=> BlocProvider.of(context);

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password' : password,
      },
    ).then((value){
      print(value.data);
      emit(LoginSuccessState());
    }).catchError((error){
      print(error);
      emit(LoginErrorState(error));
    });
  }
}
