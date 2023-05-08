import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop/LoginScreen.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class AccountDisplayCardInfo extends StatefulWidget {
  final int index;
  const AccountDisplayCardInfo({Key? key, required this.index}) : super(key: key);

  @override
  State<AccountDisplayCardInfo> createState() => _AccountDisplayCardInfoState();
}

class _AccountDisplayCardInfoState extends State<AccountDisplayCardInfo> {

  
  List<String> ingredients=[];
  String dish="--/--";
  String recipe="--/--";
  String description="--/--";
  String price="--/--";
  String imageUrl="--/--";
  User?user;
  Future<void> getRecipeDetails()async{



    user=await FirebaseAuth.instance.currentUser;

    final collection=await FirebaseFirestore.instance.collection('Recipes').doc(user!.uid).collection('recipes');
    var docSnapshot = await collection.doc(user!.uid+widget.index.toString()).get();
    if (docSnapshot.exists) {
        Map<String,dynamic> ? data= docSnapshot.data();
        var ingredientsArray=data!['ingredients'];
        ingredients=List<String>.from(ingredientsArray);

        dish=data['dish'];
        recipe=data['recipe'];
        price=data['price'];
        imageUrl=data['imageUrl'];
        description=data['description'];
    }
  }
  
  @override
  void initState() {
    super.initState();
    getRecipeDetails();
    
  }
  
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

                            image: NetworkImage(imageUrl),
                            fit: BoxFit.fitWidth,
                          ),
                        ),

                      ),
                      SizedBox(height: h*0.03,),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: w*0.06),
                          height: h,
                          child: Column(
                            children: [
                              SizedBox(height: h*0.02,),
                              styled(text: 'Dish', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                              SizedBox(height: h*0.01,),
                              styled(text: dish, color: Colors.black, weight: FontWeight.normal, size:h*0.02),
                              SizedBox(height: h*0.04,),

                              styled(text: 'Price', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                              SizedBox(height: h*0.01,),
                              styled(text: price, color: Colors.black, weight: FontWeight.normal, size:h*0.02),
                              SizedBox(height: h*0.04,),

                              styled(text: 'Ingredients', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                              SizedBox(height: h*0.01,),
                              Flexible(child: Wrap(
                                // textDirection: TextDirection.ltr,
                                direction: Axis.horizontal,

                                // alignment: WrapAlignment.spaceEvenly,
                                children: [
                                  for(var ingredient in ingredients)
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: w*0.01,vertical: h*0.004),
                                      padding: EdgeInsets.all(w*0.02),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.black,width: 1.2),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: styled(text: ingredient, color: Colors.black, weight: FontWeight.normal, size:h*0.015),
                                    )
                                ],
                              )),
                              SizedBox(height: h*0.04,),
                              styled(text: 'Recipe', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                              SizedBox(height: h*0.01,),
                              Flexible(child:Text(recipe,style: GoogleFonts.adamina(textStyle: TextStyle(color:Colors.black,fontSize: h*0.016,
                                  fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),)),

                              SizedBox(height: h*0.04,),
                              styled(text: 'Description', color: Colors.black, weight: FontWeight.bold, size:h*0.02),
                              SizedBox(height: h*0.01,),
                              Flexible(child:Text(description ,style: GoogleFonts.adamina(textStyle: TextStyle(color:Colors.black,fontSize: h*0.016,
                                  fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),))

                            ],
                          ))

                    ],
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
