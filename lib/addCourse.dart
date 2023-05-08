import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop/FirebaseMethods.dart';
import 'package:onlineshop/LoginScreen.dart';

import 'package:image_picker/image_picker.dart';
class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}
class bgColor{
  Color backGroundColor;
  Color foreGroundColor;
  bgColor({required this.backGroundColor,required this.foreGroundColor});
}

List<bgColor> colors=[
  bgColor(backGroundColor: Colors.black, foreGroundColor: Colors.white),
  bgColor(backGroundColor: Colors.purple, foreGroundColor: Colors.white),
  bgColor(backGroundColor: Colors.blue[900]!, foreGroundColor: Colors.white),
  bgColor(backGroundColor: Colors.pink[700]!, foreGroundColor: Colors.white),
  bgColor(backGroundColor: Colors.red[900]!, foreGroundColor: Colors.white),
  bgColor(backGroundColor: Colors.grey[800]!, foreGroundColor: Colors.white),
];

List<String> ingredients=[
  // 'Salt','Pepper','Cheese','Garlic','Cheese','Garlic'
];

class _AddCourseState extends State<AddCourse> {
   final formKey=GlobalKey<FormState>();

  TextEditingController dishController=TextEditingController();
  TextEditingController recipeController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController _ingredientsController=TextEditingController();

    final scaffoldKey=GlobalKey<ScaffoldState>();

  bool imageSet=false;

  File? imageFile;




  void selectImages() async {
  try{
    final PickedFile? selectedImages = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (selectedImages!=null) {
     imageFile=File(selectedImages.path);
    }
    setState(() {
      imageSet=true;
    });
  }
  catch(e){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No image selected',style: TextStyle(color: Colors.white),)));
  }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ingredientsController.dispose();
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
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: w*0.9,
            height: h*0.88,
            decoration: BoxDecoration(
              color: Colors.white ,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: w*0.05,vertical: h*0.023),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child:  InkWell(onTap: (){
                              Navigator.of(context).pop();
                            },child: Padding(
                              padding:  EdgeInsets.only(top: h*0.005),
                              child: Icon(Icons.arrow_back_ios,size: h*0.02,color: Colors.black87,),
                            )),
                          ),
                          Align(alignment: Alignment.topCenter,
                          child: styled(text: 'Add Recipe', color:Colors.black, weight: FontWeight.bold, size: h*0.023 ))
                        ],
                      ),

                      SizedBox(height: h*0.04,),

                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "Empty field";
                          }
                          else{
                            return null;
                          }
                        },
                        controller: dishController,
                        style: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fastfood,color: Colors.black87,),
                          labelText: "Dish",
                          labelStyle: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                          border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[600]!)
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[600]!)
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black,width: 1.5)
                          ),
                        ),
                      ),
                      SizedBox(height: h*0.025,),
                      OutlinedButton(onPressed: (){
                        showModalBottomSheet(
                              backgroundColor: Colors.white,
                            // barrierColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                            ),
                            context: context,
                            builder: (BuildContext bc){
                              return Container(
                                padding: EdgeInsets.all(w*0.05),
                                height: h*0.4,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                ),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: w*0.05),
                                      child: TextFormField(
                                        onFieldSubmitted: (val){
                                          String x=_ingredientsController.text.toString();

                                          if(x.isNotEmpty){
                                            setState((){
                                              ingredients.add(x);
                                              // Navigator.of(context).pop();
                                            });
                                            _ingredientsController.clear();

                                          }
                                        },
                                        controller: _ingredientsController,
                                        style: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          labelText: "Ingredient",
                                          labelStyle: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey[600]!)
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey[600]!)
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black,width: 1.5)
                                          ),
                                        ),
                                      ),
                                    ),

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: w*0.05),
                                        child: OutlinedButton.icon(onPressed: (){

                                            String x=_ingredientsController.text.toString();

                                            if(x.isNotEmpty){
                                              setState((){
                                                ingredients.add(x);
                                              });

                                              _ingredientsController.clear();
                                            }

                                        },icon:Icon(Icons.add_outlined,color: Colors.black,size: h*0.02,), label:styled(text: 'Add', color: Colors.black, weight: FontWeight.bold, size: h*0.02),
                                          style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(7)
                                              ),
                                              minimumSize: Size(w, h*0.045),
                                              side: BorderSide(color: Colors.black)
                                          ),),
                                      ),
                                  ],
                                )
                              );
                            }
                        );
                      }, child:styled(text: 'Ingredients', color: Colors.black, weight:FontWeight.normal, size: h*0.018),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)
                        ),
                        minimumSize: Size(w, h*0.045),
                        side: BorderSide(color: Colors.black)
                      ),),



                        SizedBox(height: h*0.03,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [

                            for(int i=0;i<ingredients.length;++i)

                              Padding(
                                padding:  EdgeInsets.only(right: w*0.03),
                                child: InkWell(
                                  // onLongPress: (){

                                // },
                                  child: Material(color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      // elevation: 3.7,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),

                                        onLongPress: (){
                                          setState((){
                                            ingredients.removeAt(i);
                                          });
                                        },
                                        child: Container(
                                    child: styled(text: ingredients[i], color: Colors.black, weight: FontWeight.normal, size: h*0.013),
                                    padding: EdgeInsets.all(w*0.025),
                                    decoration: BoxDecoration(
                                          // color:Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.black,width: 0.8)
                                    ),
                                  ),
                                      )),
                                ),
                              )
                          ],
                        ),
                      ),
                      Container(
                        height: h*0.17,
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Empty field";
                            }
                            else{
                              return null;
                            }
                          },
                          controller: recipeController,
                          maxLines: 5,
                          style: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelText: "Recipe",

                            labelStyle: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[600]!)
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[600]!)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 1.5)
                            ),
                          ),
                        ),
                      ),


                  SizedBox(height: h*0.023,),


                      Container(
                        height: h*0.17,
                        child: TextFormField(
                          validator: (value){
                          if(value!.isEmpty){
                            return "Empty field";
                          }
                          else{
                            return null;
                          }
                        },
                          controller:descriptionController,
                          maxLines: 3,
                          maxLength: 1000,
                          style: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelText: "Description",

                            labelStyle: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[600]!)
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[600]!)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 1.5)
                            ),
                          ),
                        ),
                      ),
                                SizedBox(height: h*0.02,),
                      Container(
                        height: h*0.17,
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Empty field";
                            }
                            else{
                              return null;
                            }
                          },
                          controller: priceController,
                          keyboardType: TextInputType.phone,
                          style: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelText: "Price",
                              suffix:styled(text: 'PKR', color:Colors.black, weight: FontWeight.bold, size: h*0.012),

                            labelStyle: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[600]!)
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[600]!)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 1.5)
                            ),
                          ),
                        ),
                      ),
                                imageSet==false?Tooltip(
                                  // showDuration: const Duration(milliseconds: 100),
                                  message: 'Add Images',
                                  child: InkWell(
                                    onTap: (){
                                      selectImages();
                                    },
                                    child: Material(
                                      // color: Colors.white,
                                      elevation: 3,
                                      borderRadius: BorderRadius.circular(300),
                                      child: Container(
                                        width: w*0.23,
                                        height: w*0.23,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(300),
                                          color: Colors.white
                                        ),
                                        child: Icon(CupertinoIcons.camera_on_rectangle,size: w*0.15,color: Colors.black,),

                                      ),
                                    ),
                                  ),
                                ):
                      GridView.builder(shrinkWrap: true,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context,index){
                                        return Padding(
                                          padding: EdgeInsets.all(w*0.01),
                                          child: Material(
                                          elevation: 5.5,
                                            borderRadius: BorderRadius.circular(10),
                                            child: Container(
                                                width: w*0.45,
                                                height: h*0.2,
                                                decoration: BoxDecoration(
                                                  color:Colors.white,
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    fit: BoxFit.fitWidth,
                                                    image: FileImage(imageFile!)
                                                  )
                                                ),
                                            ),
                                          ),
                                        );
                      },itemCount: 1,
                      ),
                      SizedBox(height: h*0.023,),


                      OutlinedButton(onPressed: ()async{

                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                         try{
                           String uid=await FirebaseAuth.instance.currentUser!.uid;


                           String response=await  addRecipeMethod(uid: uid, dish: dishController.text.toString(), ingredients: ingredients, recipe: recipeController.text.toString(), description: descriptionController.text.toString(),
                               price: priceController.text.toString(), imageFile: imageFile!);

                           if(response=="Success"){
                             scaffoldKey.currentState!.showSnackBar(const SnackBar(content: Text('Published Successfully')));
                           }
                           else{
                             scaffoldKey.currentState!.showSnackBar(const SnackBar(content: Text('Error Occurred')));

                           }
                         }
                         catch(e){
                           scaffoldKey.currentState!.showSnackBar( SnackBar(content: Text(e.toString()),duration: const Duration(seconds: 8),));

                         }

                        }
                      },child: styled(text: 'Publish', color: Colors.black, weight: FontWeight.bold, size:h*0.021),  style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)
                          ),
                          minimumSize: Size(w, h*0.045),
                          side: BorderSide(color: Colors.black)
                      ),),

                      SizedBox(
                        height: h*0.05,
                      ),




                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//
// Text text({required String text,required Color color, required FontWeight weight, required double size}){
//   return Text(text, style: GoogleFonts.besley(textStyle: TextStyle(color: color,fontSize: size,fontWeight: weight)),);
// }