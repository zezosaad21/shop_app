import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/models/home_model.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ShopLayoutCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.homeModel != null,
            builder: (context) => productsBuilder(cubit.homeModel),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget productsBuilder(HomeModel homeModel) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e['image']}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.58,
                children: List.generate(
                    homeModel.data.products.length,
                    (index) => Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image(
                                    image: NetworkImage(
                                      homeModel.data.products[index]['image'],
                                    ),
                                    width: double.infinity,
                                    height: 200,

                                  ),
                                  if(homeModel.data.products[index]['discount'] != 0)
                                  Positioned(
                                    bottom: 10.0,
                                    left: 10,
                                    child: Container(
                                      width: 40,
                                      height: 30,

                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                            "${homeModel.data.products[index]['discount']} %",style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      homeModel.data.products[index]['name'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        height: 1.3,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${homeModel.data.products[index]['price']}",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.teal,
                                          ),
                                        ),
                                        SizedBox(width: 20.0,),
                                        if(homeModel.data.products[index]['discount'] != 0)
                                        Text(
                                          "${homeModel.data.products[index]['old_price']}",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                            decoration: TextDecoration.lineThrough,
                                          ),

                                        ),
                                        Spacer(),
                                        IconButton(
                                            icon: Icon(
                                                Icons.favorite_outline),
                                            onPressed: (){}
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    )),
              ),
            )
          ],
        ),
      );
}
