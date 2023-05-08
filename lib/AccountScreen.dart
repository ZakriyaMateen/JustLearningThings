import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop/AccountDisplayCardInfo.dart';
import 'package:onlineshop/LoginScreen.dart';
import 'package:onlineshop/addCourse.dart';

import 'EditProfile.dart';



class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  ScrollController _controller=ScrollController();
  // TabController? controller = TabController(length: 2, vsync: );
  
  String profilePicfromDb="";
  
  User? user;



  getProfilePic()async {

    user=FirebaseAuth.instance.currentUser;
    var collection=FirebaseFirestore.instance.collection('Accounts');
    var docSnapshot=await collection.doc(user!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var profilePic = data?['profileImage'];
      setState((){
        profilePicfromDb=profilePic;
      });
      }}
  @override
  initState(){
    super.initState();
    getProfilePic();
  }

  bool isVisible=true;
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



      Route _createRouteAddCourse() {
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const AddCourse(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve,));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      }
      Route _createRouteAccountDisplayCardInfo({required int i}) {
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>  AccountDisplayCardInfo(index: i),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve,));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      }
      // Route _createRouteAccountDisplayCardInfo2({required int i}) {
      //   return PageRouteBuilder(
      //     pageBuilder: (context, animation, secondaryAnimation) =>  AccountDisplayCardInfo(index: i),
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       const begin = Offset(1.0, 0.0);
      //       const end = Offset.zero;
      //       const curve = Curves.easeOut;
      //
      //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve,));
      //
      //       return SlideTransition(
      //         position: animation.drive(tween),
      //         child: child,
      //       );
      //     },
      //   );
      // }

      Route _createRouteEditProfile() {
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const EditProfile(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      }
  
    return DefaultTabController(
      length: 2,
      animationDuration: const Duration(seconds: 1),



      child: Scaffold(

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(_createRouteAddCourse());

            },
          backgroundColor: Colors.black,
          child: Center(
            child: Icon(Icons.add,color: Colors.white,size: 25,),
          ),
        ),

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          controller:_controller ,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [   Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedContainer(
                    width: w,
                    height: h*0.25,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black,Colors.black87,Colors.black87,Colors.black]
                      ),
// image: DecorationImage(
//   fit: BoxFit.fill,
//   image: NetworkImage("https://media.istockphoto.com/photos/dark-black-and-blue-grungy-wall-background-for-display-or-montage-of-picture-id1150477705?b=1&k=20&m=1150477705&s=170667a&w=0&h=bPVqKUjUPGcxC0CxCoFFxh-oQggDovgZTT8K3IzWA5E=")
// )
                    ), duration: Duration(milliseconds:200),
                  ),
                ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: h*0.2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(400),
                          border: Border.all(color: Colors.grey[300]!)
                      ),
                      child: CircleAvatar(
                        radius: h*0.05,
                        backgroundColor: Colors.blue,
                        foregroundImage: NetworkImage(profilePicfromDb),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: h*0.25,right: h*0.01),
                      child: IconButton(
                          icon: Icon(Icons.edit_note_rounded,color: Colors.black,size: h*0.05,),
                          onPressed: (){
                            Navigator.of(context).push(_createRouteEditProfile());
                          }),
                    ),
                  ),



                ],
              ),
              SizedBox(height: h*0.025,),


              SizedBox(height: h*0.025,),
              TabBar(
                indicator:BoxDecoration(
                    borderRadius: BorderRadius.circular(50), // Creates border
                    color: Colors.black), //
                // isScrollable: true,
                // splashBorderRadius: BorderRadius.circular(20),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: h*0.0055,
                indicatorPadding: EdgeInsets.only(top:h*0.03),

                // automaticIndicatorColorAdjustment: true,
                // labelColor: Colors.black,



                tabs: [ styled(text: 'Your Recipes', color: Colors.black, weight:FontWeight.bold, size:h*0.02),
                  styled(text: 'Boughts', color: Colors.black, weight:FontWeight.bold, size:h*0.02)],
              ) ,
              Container(height: (h*0.2*30)/3.5,
                padding: EdgeInsets.only(top: h*0.02),
                child: TabBarView(
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w*0.01),
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance.collection('Recipes').doc(user!.uid).collection('recipes').snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.hasError){
                            return Center(child:styled(text: 'No recipes publishes', color: Colors.black, weight: FontWeight.normal, size:h*0.02));
                          }
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          if(snapshot.hasData){
                            final docs=snapshot.data!.docs;
                            return  GridView.builder(

                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (context,index){
                              final data = docs[index].data();








                              return Padding(
                                padding:  EdgeInsets.all(3),
                                child: InkWell(
                                  onTap: (){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('{$index}')));

                                   Navigator.of(context).push(_createRouteAccountDisplayCardInfo(i: index));

                                  },
                                  child: Material(
                                    elevation: 2.5,
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      width: w*0.25,
                                      height: h*0.2,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(7),
                                          image: DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(data['imageUrl'])
                                          )
                                      ),

                                    ),
                                  ),
                                ),
                              );
                            },itemCount: docs.length,);
                          }

                          return Center(child: CircularProgressIndicator());

                        }
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w*0.01),
                      child: GridView.builder(

                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (context,index){
                        return Padding(
                          padding:  EdgeInsets.all(3),
                          child: InkWell(
                            onTap: (){

                              // Navigator.of(context).push(_createRouteAccountDisplayCardInfo2(i: index));

                            },
                            child: Material(
                              elevation: 2.5,
                              borderRadius: BorderRadius.circular(7),
                              child: Container(
                                width: w*0.25,
                                height: h*0.2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7),
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: NetworkImage('https://media.istockphoto.com/photos/portrait-of-small-girl-in-living-room-at-home-picture-id1352096257?b=1&k=20&m=1352096257&s=170667a&w=0&h=pxFX9aF1TREb1bnF9jJIJlfioIHpEOjo92wi5sYIg5w=')
                                    )
                                ),

                              ),
                            ),
                          ),
                        );
                      },itemCount: 30,),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

      )
    );
  }


}



