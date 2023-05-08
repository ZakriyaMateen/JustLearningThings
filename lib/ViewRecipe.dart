import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginScreen.dart';

class ViewRecipe extends StatefulWidget {
  const ViewRecipe({Key? key}) : super(key: key);

  @override
  State<ViewRecipe> createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
bool  hasBought=false;
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
        backgroundColor: Colors.white,
        body:SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft  ,
                  child: InkWell(onTap: (){
                    Navigator.of(context).pop();
                  },child: Padding(
                    padding:  EdgeInsets.only(top: h*0.02,left: w*0.03),
                    child: Icon(Icons.arrow_back_ios,size: h*0.02,color: Colors.black87,),
                  )),
                ),
                SizedBox(height: h*0.02,),
            Padding(
              padding: EdgeInsets.only(top: h*0.007,left: w*0.02,right: w*0.02,),
              child: Material(
                elevation: 5,
                child: Expanded(
                  child: Container(
                    width: w,
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: w,
                          height: h*0.4,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey,width: 0.35),
                            color: Colors.white,
                            image: DecorationImage(

                              image: NetworkImage("https://media.istockphoto.com/photos/portrait-of-small-girl-in-living-room-at-home-picture-id1352096257?b=1&k=20&m=1352096257&s=170667a&w=0&h=pxFX9aF1TREb1bnF9jJIJlfioIHpEOjo92wi5sYIg5w="),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                            child: Column(children: [

                            ],),
                        ),

                        Visibility(
                          visible: !hasBought,
                          child: Column(
                            children: [        styled(text: '-- Description --', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                              SizedBox(height: h*0.012,),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.05),
                                child: Material(
                                    color: Colors.white,
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(10),
                                    child:Padding(
                                      padding: EdgeInsets.all(w*0.015),
                                      child: Flexible(child:Text("Put one cup of water into pan ,add 1 tb of tea, 1 tb of sugar and let it heat for 15 minutes",style: GoogleFonts.adamina(textStyle: TextStyle(color:Colors.black,fontSize: h*0.016,
                                          fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),)),
                                    )),
                              ),
                              SizedBox(height: h*0.042,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: w*0.05),
                                child: OutlinedButton(onPressed: (){
                                  setState((){
                                    hasBought=true;
                                  });

                                }, child: styled(text: 'Buy Now', color: Colors.black, weight: FontWeight.bold, size:h*0.019),
                                  style:OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.black,width: 1.2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      minimumSize: Size(w, h*0.04)
                                  )
                                  ,),
                              )

                            ],
                          ),
                        ),
                        SizedBox(height: h*0.03,),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: w*0.06),
                            height: h,
                            child: Visibility(
                              visible: hasBought,
                              child: Expanded(
                                  child:
                                  Column(
                                    children: [
                                      SizedBox(height: h*0.02,),
                                      styled(text: '-- Dish --', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                                      SizedBox(height: h*0.012,),
                                  Material(
                                    color: Colors.white,
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(10),
                                    child:Padding(
                                      padding: EdgeInsets.all(w*0.015),
                                      child: styled(text: 'Zinger Burger', color: Colors.black, weight: FontWeight.normal, size:h*0.02),
                                    )),
                                      SizedBox(height: h*0.042,),

                                      styled(text: '-- Price --', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                                      SizedBox(height: h*0.012,),
                                      Material(
                                          color: Colors.white,
                                          elevation: 2,
                                          borderRadius: BorderRadius.circular(10),
                                          child: Padding(
                                            padding: EdgeInsets.all(w*0.015),
                                            child: styled(text: '180'+"Rs", color: Colors.black, weight: FontWeight.normal, size:h*0.02),
                                          )),
                                      SizedBox(height: h*0.042,),

                                      styled(text: '-- Ingredients --', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                                      SizedBox(height: h*0.012,),
                                      Flexible(child: Wrap(
                                        // textDirection: TextDirection.ltr,
                                        direction: Axis.horizontal,

                                        // alignment: WrapAlignment.spaceEvenly,
                                        children: [
                                          for(int i=0;i<10;++i)
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: w*0.01,vertical: h*0.004),child: Material(

                                          borderRadius: BorderRadius.circular(20),
                                                    elevation: 3,
                                                    color: Colors.white,
                                                    child: Container(

                                                  padding: EdgeInsets.all(w*0.02),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(color: Colors.black,width: 1.2),
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: styled(text: 'Salt 2tb', color: Colors.black, weight: FontWeight.normal, size:h*0.015),
                                                ),
                                              ),
                                            )
                                        ],
                                      )),
                                      SizedBox(height: h*0.042,),
                                      styled(text: '-- Recipe --', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                                      SizedBox(height: h*0.012,),

                                      Material(

                                        color: Colors.white,
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(10),
                                        child: Padding(
                                          padding:EdgeInsets.all(w*0.015),
                                          child: Flexible(child:Text("Put one cup of water into pan ,add 1 tb of tea, 1 tb of sugar and let it heat for 15 minutes",style: GoogleFonts.adamina(textStyle: TextStyle(color:Colors.black,fontSize: h*0.016,
                                              fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),)),
                                        ),
                                      ),
                                      SizedBox(height: h*0.042,),

                                      styled(text: '-- Description --', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                                      SizedBox(height: h*0.012,),

                                      Material(
                                          color: Colors.white,
                                          elevation: 2,
                                          borderRadius: BorderRadius.circular(10),
                                          child:Padding(
                                            padding: EdgeInsets.all(w*0.015),
                                            child: Flexible(child:Text("Put one cup of water into pan ,add 1 tb of tea, 1 tb of sugar and let it heat for 15 minutes",style: GoogleFonts.adamina(textStyle: TextStyle(color:Colors.black,fontSize: h*0.016,
                                                fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),)),
                                          )),
                                      SizedBox(height: h*0.042,),

                                    ],
                                  )
                              ),
                            ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            )
              ],
            ),
          ),
        )
    );
  }
}
