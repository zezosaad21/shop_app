import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/local/chach_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String title;
  final String image;
  final String body;

  BoardingModel({this.title, this.image, this.body});
}

class OnBoardingScreen extends StatefulWidget {


  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onbarding1.jpg',
      title: 'Onboard1 title',
      body: 'Onboard 1 body',
    ),
    BoardingModel(
      image: 'assets/images/onbarding1.jpg',
      title: 'Onboard2 title',
      body: 'Onboard 2 body',
    ),
    BoardingModel(
      image: 'assets/images/onbarding1.jpg',
      title: 'Onboard3 title',
      body: 'Onboard 3 body',
    ),
  ];

  bool islast = false;

  void submit(){

    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context)=> LoginScreen(),),);
      }
    });


  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(onPressed:submit,
              child: Text('Skip',style: TextStyle(
            color: Colors.teal,
            fontSize: 16.0,
          ),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index == boarding.length - 1){
                    setState(() {
                      islast = true;
                    });
                  } else{
                    setState(() {
                      islast = false;
                    });
                  }
                },
                controller: boardController,
                physics: BouncingScrollPhysics() ,
                itemBuilder: (context, index)=>Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: buildoardingItem(boarding[index]),
                ),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40.0,),
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 30.0,bottom: 30.0),
              child: Row(
                children: [
                  SmoothPageIndicator(controller: boardController, count: boarding.length, effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.teal,
                    dotHeight: 10.0,
                    expansionFactor: 4.0,
                    dotWidth: 10.0,
                    spacing: 5.0,
                  ),),
                  Spacer(),
                  FloatingActionButton(onPressed: (){

                    if(islast){
                      submit();
                    } else{
                      boardController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn,);
                    }
                  },
                    backgroundColor: Colors.teal,
                  child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            )

          ],
        ),
      )
    );
  }

  Widget buildoardingItem(BoardingModel boardingModel)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage(boardingModel.image))),
      SizedBox(
        height: 20,
      ),
      Text(
        boardingModel.title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        boardingModel.body,
        style: TextStyle(
          fontSize: 14.0,

        ),
      ),
    ],
  );
}
