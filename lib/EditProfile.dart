import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlineshop/FirebaseMethods.dart';
import 'dart:io';

import 'LoginScreen.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {


  final scaffoldKey=GlobalKey<ScaffoldState>();

  final ImagePicker imagePicker = ImagePicker();

  Color phoneColor=Colors.grey[700]!;
  Color designationColor=Colors.grey[700]!;
  Color nameColor=Colors.grey[700]!;

  TextEditingController nameController=TextEditingController();
  TextEditingController designationController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  XFile ?imageFile=null;
  bool imageSet=false;

  void selectImages() async {
    try{
      final XFile? selectedImage= await imagePicker.pickImage(source: ImageSource.gallery);
      if (selectedImage!=null) {
          imageFile=selectedImage;
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

      body:Center(
        child: Material(
          elevation: 5.5,
            borderRadius: BorderRadius.circular(13),
          color: Colors.white,
          child: Container(
            // margin:  EdgeInsets.symmetric(horizontal: w*0.06),
            width: w*0.9,
            height: h*0.88,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13)
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: w*0.06),
                child: Column(
                  children: [
                    SizedBox(height: h*0.024,),

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
                            child: styled(text: 'Edit Profile', color:Colors.black, weight: FontWeight.bold, size: h*0.023 ))
                      ],
                    ),
                    SizedBox(
                      height: h*0.045 ,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                child: Icon(CupertinoIcons.photo_camera,size: w*0.15,color: Colors.black,),

                              ),
                            ),
                          ),
                        ):
                        InkWell(
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
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: FileImage(File(imageFile!.path))
                                  )
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                            SizedBox(height: h*0.1,),
                    TextFormField(
                      controller: nameController,
                      onTap: (){

                          setState((){
                            if(designationColor==Colors.black){
                              designationColor=Colors.grey[700]!;
                            }
                            if(phoneColor==Colors.black){
                              phoneColor=Colors.grey[700]!;
                            }
                            nameColor=Colors.black;
                          });

                      },
                      onFieldSubmitted: (val){
                      setState((){

                        nameColor=Colors.grey[700]!;
                      });
                      },
                      style: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Name",

                          prefixIcon: Icon(CupertinoIcons.person_fill,color: nameColor,),

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
                    SizedBox(height: h*0.045,),
                    TextFormField(
                      controller: designationController,
                      onTap: (){
                        setState((){
                          if(phoneColor==Colors.black){
                            phoneColor=Colors.grey[700]!;
                          }
                          if(nameColor==Colors.black){
                            nameColor=Colors.grey[700]!;
                          }
                          designationColor=Colors.black;

                        });
                      },
                      onFieldSubmitted: (val){
                        setState((){

                          designationColor=Colors.grey[700]!;

                        });
                      },
                      style: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.checkmark_seal_fill,color: designationColor,),

                        labelText: "Designation",
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
                    SizedBox(height: h*0.045,),
                    TextFormField(
                      controller: phoneController,
                      onTap: (){
                        setState((){
                          if(designationColor==Colors.black){
                            designationColor=Colors.grey[700]!;
                          }
                          if(nameColor==Colors.black){
                            nameColor=Colors.grey[700]!;
                          }
                          phoneColor=Colors.black;

                        });
                      },
                      keyboardType: TextInputType.phone,
                      onFieldSubmitted: (val){

                                setState((){

                                  phoneColor=Colors.grey[700]!;

                                });
                      },
                      style: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.black,fontSize: h*0.016,fontWeight: FontWeight.normal)),
                      cursorColor: Colors.black,

                      decoration: InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.phone_fill_arrow_down_left,color: phoneColor,),
                        labelText: "Phone",
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

                    SizedBox(height: h*0.1,),
                    OutlinedButton(onPressed: ()async{
                      String uid =await FirebaseAuth.instance.currentUser!.uid;

                   String response=   await editProfile(
                                        name: nameController.text.toString(), designation: designationController.text.toString(), phone: phoneController.text.toString(),
                                        uid: uid, imageFile:imageFile!
                                        );
                   if(response=="Success"){

                     scaffoldKey.currentState!.showSnackBar(const SnackBar(content: Text("Editted successfully")));
                   }
                    else{
                     scaffoldKey.currentState!.showSnackBar(const SnackBar(content: Text("Error")));

                   }

                    },  style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),
                        minimumSize: Size(w, h*0.045),
                        side: BorderSide(color: Colors.black)
                    ),child: styled(text: 'Save', color: Colors.black, weight: FontWeight.bold, size:h*0.021),),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
