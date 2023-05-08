import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ViewRecipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color searchColor=Colors.grey[700]!;
  Route _createRouteAddCourse() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const ViewRecipe(),
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,right:w*0.05,top: h*0.02),
              child: TextFormField(
                 onTap:(){ setState((){
                 searchColor=Colors.black;
                  });},
                onFieldSubmitted: (value){
                  setState((){
                    if(searchColor==Colors.black){
                      searchColor=Colors.grey[700]!;
                    }
                  });
                },
                cursorColor: Colors.grey[800],
                style: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.grey[700],fontSize: h*0.018,fontWeight: FontWeight.normal)),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search,color: searchColor,),
                  hintText: "Search ...",
                hintStyle: GoogleFonts.adamina(textStyle: TextStyle(color: Colors.grey[700],fontSize: h*0.018,fontWeight: FontWeight.normal)),
                contentPadding: EdgeInsets.symmetric(vertical: -10,horizontal: 12)
              ,fillColor: Colors.grey,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.black,width: 1)
                    ),
                  enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.grey[700]!,width: 1)
                  ),
                  focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.black,width: 1.5)
                    )
                ),
              ),
            ),
            SizedBox(height: h*0.02,),
            Flexible(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: w*0.01),
                child: GridView.builder(
                scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context,index){
                  return Padding(
                    padding:  EdgeInsets.all(w*0.012),
                    child: InkWell(
                      onTap: (){
                        //add every detail as parameters of constructor
                      Navigator.of(context).push(_createRouteAddCourse());
                      },
                      child: Material(elevation: 5,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          width: w*0.4,
                          height: h*0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            image: DecorationImage(
                                image: NetworkImage("https://media.istockphoto.com/photos/portrait-of-small-girl-in-living-room-at-home-picture-id1352096257?b=1&k=20&m=1352096257&s=170667a&w=0&h=pxFX9aF1TREb1bnF9jJIJlfioIHpEOjo92wi5sYIg5w="),
                              fit: BoxFit.fitWidth
                            )
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
