import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
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
                itemBuilder: (context, index)=>buildoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController, count: boarding.length, effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10.0,
                  expansionFactor: 4.0,
                  dotWidth: 10.0,
                  spacing: 5.0,
                ),),
                Spacer(),
                FloatingActionButton(onPressed: (){

                  if(islast){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else{
                    boardController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.fastLinearToSlowEaseIn,);
                  }
                },
                child: Icon(Icons.arrow_forward_ios),
                )
              ],
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
