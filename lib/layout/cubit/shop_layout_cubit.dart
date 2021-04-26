import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/product/product_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/endpoint.dart';
import 'package:shop_app/shared/remot/dio_helper.dart';

part 'shop_layout_state.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutState> {
  ShopLayoutCubit() : super(ShopLayoutInitial());

  static ShopLayoutCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreens(),
    SettingsScreen(),
  ];

  void changeCurrentScreen( int index){

    currentIndex = index;
    emit(ShopLayoutChangeNabBar());

  }

  HomeModel homeModel;
  void getHomeData() {
    emit(ShopLayoutLoadingState());
    DioHelper.getData(
      token: token,
        url: HOME,
      lang: 'en'
    ).then((value){

        homeModel = HomeModel.fromJson(value.data);
        print(homeModel.status);
        emit(ShopLayoutSuccessState());
        print(homeModel.data.banners[0]['image']);
    }).catchError((error){
      emit(ShopLayoutError(error.toString()));
      print(error.toString());
    });
  }
}
