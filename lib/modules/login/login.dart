import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app_layout.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/local/chach_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState){
                if(state.loginModel.status){

                  CacheHelper.saveData(key: 'token', value: state.loginModel.data.token,).then((value){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShopAppLayout()));
                  });

                } else{

                  showToast(text: state.loginModel.message,
                    state: ToastStates.ERROR,
                  );

                }
              }

        }, builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('LOGIN',
                          style: TextStyle(
                            fontSize: 28.0,
                          )),

                      Text(
                        'Login now to browse our offers',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'the email is not empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        obscureText: LoginCubit.get(context).isPassword,
                        onFieldSubmitted: (value){
                          if(formKey.currentState.validate()){
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,

                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'the password is not empty';
                          } else if (value.isNotEmpty && value.length <= 4) {
                            return 'password short must be 4 carchater';
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_open_rounded),
                            suffixIcon: IconButton(
                              icon: Icon(LoginCubit.get(context).suffixButton),
                              onPressed: (){
                                LoginCubit.get(context).changePasswordVisibility();
                              },
                            ),



                        ),

                      ),
                      // ElevatedButton(
                      //
                      //   onPressed: (){},
                      //
                      //   child: Text('Login'),
                      // ),
                      SizedBox(
                        height: 40.0,
                      ),
                      ConditionalBuilder(condition: state is !LoginLoadingState,
                          builder: (context)=> GestureDetector(
                            onTap: () {
                              if(formKey.currentState.validate()){
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }

                            },
                            child: Container(
                              width: 400,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        fallback: (context)=> CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Dont have an account? ',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 15.0,
                                decoration: TextDecoration.underline,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
