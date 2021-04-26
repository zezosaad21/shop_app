import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/search/search_screens.dart';
import 'package:shop_app/shared/local/chach_helper.dart';

class ShopAppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cuibt = ShopLayoutCubit.get(context);
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Salla'),
            elevation: 0.0,
            actions: [
              IconButton(
                icon: Icon(
                  CupertinoIcons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: cuibt.bottomScreen[cuibt.currentIndex],
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.flip,
            onTap: (index) {
              cuibt.changeCurrentScreen(index);
            },
            elevation: 0.0,
            backgroundColor: Colors.white,
            color: Colors.teal,
            activeColor: Colors.teal,
            initialActiveIndex: cuibt.currentIndex,
            items: [
              TabItem(icon: CupertinoIcons.home, title: 'Home'),
              TabItem(
                  icon: CupertinoIcons.rectangle_grid_2x2, title: 'Categories'),
              TabItem(
                  icon: CupertinoIcons.square_favorites, title: 'favorites'),
              TabItem(icon: CupertinoIcons.settings, title: 'settings'),
            ],
          )
          // BottomNavigationBar(
          //
          //   currentIndex: cuibt.currentIndex,
          //   onTap: (index){
          //     cuibt.changeCurrentScreen(index);
          //   },
          //   items: [
          //     // BottomNavigationBarItem(
          //     //
          //     //
          //     //   icon: Padding(
          //     //     padding: const EdgeInsets.all(8.0),
          //     //     child: Icon(
          //     //       CupertinoIcons.home,color: Colors.teal
          //     //
          //     //     ),
          //     //   ),
          //     //   label: 'Home',
          //     // ),
          //     // BottomNavigationBarItem(
          //     //   icon: Icon(
          //     //     CupertinoIcons.rectangle_grid_2x2,color: Colors.teal
          //     //   ),label: 'Categories',
          //     // ),
          //     // BottomNavigationBarItem(
          //     //   icon: Icon(
          //     //     CupertinoIcons.square_favorites,color: Colors.teal
          //     //   ),label: 'Favorite'
          //     // ),
          //     // BottomNavigationBarItem(
          //     //   icon: Icon(
          //     //     CupertinoIcons.settings,color: Colors.teal
          //     //   ),label: 'Settings'
          //     // ),
          //
          //   ],
          // ),
          );
    });
  }
}
