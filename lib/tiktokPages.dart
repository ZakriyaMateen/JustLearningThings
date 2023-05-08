import 'package:flutter/material.dart';


class tiktok extends StatefulWidget {
  final index;
  const tiktok({Key? key, this.index}) : super(key: key);

  @override
  State<tiktok> createState() => _tiktokState();
}

class _tiktokState extends State<tiktok> {


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
    print('200h'+widget.index.toString());
    return DefaultTabController(length: 2,
        child:Scaffold(
          backgroundColor: Colors.black,

      body: Stack(
        children: [
          Container(
            child:
            TabBarView(
              children: [
                ListView.builder(itemBuilder: (context,index){
                  return Container(color: Colors.transparent,width: w,height: h,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child:Image.network("",fit: BoxFit.fill,),
                        ),
                        Align(alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(radius: h*0.02,foregroundImage: NetworkImage(""),backgroundColor: Colors.white,),
                            Icon(Icons.favorite,color: Colors.white,size: h*0.04,),
                          ],
                        ),)
                      ],
                    ),
                  );
                },itemCount: 10,),

                ListView.builder(itemBuilder: (context,index){
                  return Container(color: Colors.yellow,width: 200,height: 200,);
                },itemCount: 10,)
              ],
            ),
          ),
          Padding(
            padding:EdgeInsets.only(top: h*0.03),
            child: TabBar(
                indicator:BoxDecoration(
                    borderRadius: BorderRadius.circular(50), // Creates border
                    color: Colors.transparent), //
                // isScrollable: true,
                // splashBorderRadius: BorderRadius.circular(20),
                indicatorWeight: h*0.0055,

                tabs: [
                  Padding(
                    padding:EdgeInsets.only(left: w*0.1),
                    child: Text("Followings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: h*0.014 )),
                  ),
              Padding(
                padding:EdgeInsets.only(right: w*0.1),
                child: Text("For You",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: h*0.014 ),
                ),
              ),
            ]),
          ),

        ],
      ),
    ));
  }
}
