import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlineshop/AccountScreen.dart';
import 'package:onlineshop/BottomNavBar.dart';
import 'package:onlineshop/EditProfile.dart';
import 'package:onlineshop/HomePage.dart';
import 'package:onlineshop/LoginScreen.dart';
import 'package:onlineshop/SignupScreen.dart';
import 'package:onlineshop/ViewRecipe.dart';
import 'package:onlineshop/addCourse.dart';
import 'package:onlineshop/del.dart';
import 'package:onlineshop/tiktokPages.dart';

import 'AccountDisplayCardInfo.dart';

void main()async{  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values,);
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarContrastEnforced: false,
  systemStatusBarContrastEnforced: false,
  systemNavigationBarDividerColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
),);
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(const app());  
}

class app extends StatefulWidget {
  const app({Key? key}) : super(key: key);

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginScreen(),
      // home:tiktok(index:299),
      // home:AccountDisplayCardInfo(index: 0, dish: "zinger", description: "this is my dish", price: "200", imageUrl: 'https://media.istockphoto.com/photos/portrait-of-small-girl-in-living-room-at-home-picture-id1352096257?b=1&k=20&m=1352096257&s=170667a&w=0&h=pxFX9aF1TREb1bnF9jJIJlfioIHpEOjo92wi5sYIg5w=', recipe: 'This is my recipe'),
    );
  }
}
