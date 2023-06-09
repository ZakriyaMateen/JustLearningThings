import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop/BottomNavBar.dart';
import 'package:onlineshop/FirebaseMethods.dart';
import 'package:onlineshop/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Color emailIconColor=Colors.grey[700]!;
  Color passwordIconColor=Colors.grey[700]!;
  final formKey=GlobalKey<FormState>();
  bool isObsecure=true;

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

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
      body: Stack(
        alignment: Alignment.center,
        children: [
                        
          Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w*0.5)),
              elevation: 5,
              child: Container(
                width: w,
                height: h*0.5,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w*0.5))
                ),
                child: Center(
                  child: styled(text: 'Login to Continue', color:Colors.white, weight: FontWeight.bold, size: h*0.023),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Material(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w*0.5)),
              elevation: 5,
              child: Container(
                width: w,
                height: h*0.2,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(w*0.5))
                ),
                child: Center(
                  child: styled(text: 'Login to Continue', color:Colors.white, weight: FontWeight.bold, size: h*0.023),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w*0.07,vertical: h*0.025),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: w,
                  height: h*0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:EdgeInsets.only(left:w*0.05,right: w*0.05),
                        child: Form(
                          key: formKey,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: emailController,
                              onTap: (){
                                if(passwordIconColor==Colors.black){
                                  passwordIconColor=Colors.grey[700]!;
                                }
                                  setState((){
                                    if(emailIconColor==Colors.grey[700]!){
                                      emailIconColor=Colors.black;
                                    }
                                    else{
                                      emailIconColor=Colors.grey[700]!;

                                    }
                                  });
                                },
                                onFieldSubmitted: (value){
                                  setState((){
                                    if(emailIconColor==Colors.grey[700]!){
                                      emailIconColor=Colors.black;
                                    }
                                    else{
                                      emailIconColor=Colors.grey[700]!;

                                    }
                                  });
                                },
                              validator: (value){
                                            if(!EmailValidator.validate(value!)){
                                            return "Invalid email";
                                            }
                                            else{
                                            return null;
                                            }
                                          },
                                        style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: h*0.015),
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.email_rounded,color: emailIconColor,),
                                            border: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey,width: 0.7),
                                            ),
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black,width: 1),
                                            ),
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: h*0.02)
                          ),
                    ),
                    SizedBox(height: h*0.02,),
                    TextFormField(
                      controller: passwordController,
                            obscureText: isObsecure,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter a password";
                            }
                            // if(value!.length<6){
                            //   return "Password is too week";
                            // }
                            else {
                              return null;
                            }
                          },
                          style:TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: h*0.015  ),
                      onTap: (){
                          if(emailIconColor==Colors.black){
                            emailIconColor=Colors.grey[700]!;
                          }
                          setState((){



                            if(passwordIconColor==Colors.grey[700]!){
                              passwordIconColor=Colors.black;
                            }
                          });

                      },


                      onFieldSubmitted: (value){
                          setState((){
                            if(passwordIconColor==Colors.black){
                              passwordIconColor=Colors.grey[700]!;
                            }

                          });
                      },
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: (){},
                                  child: InkWell(onTap: (){
                                    setState((){
                                      if(isObsecure){
                                        isObsecure=false;
                                      }
                                      else{
                                        isObsecure=true;
                                      }
                                    });
                                  },child: Icon(isObsecure?Icons.visibility_off:Icons.visibility,color: passwordIconColor,))),
                              prefixIcon: Icon(Icons.lock,color: passwordIconColor,),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey,width: 0.7),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 1),
                              ),

                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: h*0.02)
                          ),

                          ),
                            SizedBox(height: h*0.02,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [styled(text: "Don't have an account ", color: Colors.grey[600]!, weight: FontWeight.normal, size: h*0.015),
                                  InkWell(onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>SignupScreen()));
                                  },child: styled(text: 'sign up?', color:Colors.black, weight:FontWeight.bold, size: h*0.015)),
                                ],
                              ),
                              SizedBox(height: h*0.05,),
                              OutlinedButton(onPressed: ()async{
                                if(formKey.currentState!.validate()){
                                  formKey.currentState!.save();

                                  String email=emailController.text.toString();
                                  String password=passwordController.text.toString();

                                  try{
                                    String val=   await SignIn(email: email, password: password);
                                    if(val=="Success"){
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged in Successfully")));
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomNavBar()));
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error")));
                                    }
                                  }
                                  catch(e){
                                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(e.toString()),duration: const Duration(seconds: 7),));
                                  }

                                }
                              },child:styled(text: 'LOGIN', color: Colors.black, weight: FontWeight.bold, size:h*0.018),
                              style: OutlinedButton.styleFrom(

                                minimumSize: Size(w,h*0.04,),
                                side: BorderSide(color: Colors.black,width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                                )
                              ),),
                            ]
                    ),
                        ),
                      ),
                ),
                  ),
              ),
            ),
          )



          ) ],
      ),
    );
  }}
// aclonica
Text styled({required String text,required Color color, required FontWeight weight, required double size}){
  return Text(text, style: GoogleFonts.adamina(textStyle: TextStyle(color: color,fontSize: size,fontWeight: weight)),);
}