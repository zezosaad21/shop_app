import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_app_layout.dart';
import 'package:shop_app/modules/inbording_screen.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/local/chach_helper.dart';
import 'package:shop_app/shared/remot/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool isOnBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if (isOnBoarding != null) {
    if (token != null)
      widget = ShopAppLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startingWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startingWidget;

  const MyApp({this.startingWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<ShopLayoutCubit>(
          create: (context) => ShopLayoutCubit()..getHomeData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.teal,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.teal),
            ),
          ),
          fontFamily: 'Janna',
          primarySwatch: Colors.blue,
        ),
        home: startingWidget,
      ),
    );
  }
}
