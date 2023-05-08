import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop/AccountScreen.dart';
import 'package:onlineshop/HomePage.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  IconData homeIcon=Icons.home_filled;
  IconData accountIcon=Icons.account_circle_outlined;
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  final selectedIndex=0;
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(

      body: GestureDetector(
        onPanUpdate: (details ){
          if (details.delta.dx > 0) {
            _onTappedBar(0);
          }
          if (details.delta.dx < 0) {
            _onTappedBar(1);
          }

        },

        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: [


            HomePage(),
            AccountScreen(),
          ],

          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          allowImplicitScrolling: false,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: myNavBarBuilder(h,w)
    );
  }
  void _onTappedBar(int index) {
    setState(() {
      if(index==0){
          homeIcon=Icons.home_filled;
          if(accountIcon==Icons.account_circle){
              accountIcon=Icons.account_circle_outlined;
          }
      }
      if(index==1){
        accountIcon=Icons.account_circle;
        if(homeIcon==Icons.home_filled){
          homeIcon=Icons.home_outlined;
        }
      }
      _currentIndex = index;
    });
    _pageController.animateToPage(index,duration:const Duration(milliseconds: 300),curve: Curves.linear);
  }
  Container myNavBarBuilder(double h,double w){
    return Container(
      width: w,
      height: h*0.07,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
              onTap: (){
                _onTappedBar(0);
              },child: Icon(homeIcon,color: Colors.black,size: h*0.025,)),
          InkWell(
              onTap: (){
                _onTappedBar(1);
              },
              child: Icon(accountIcon,color: Colors.black,size: h*0.025))
        ],
      ),
    );
  }
}
