import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Future<String> SignUp({required String email, required String password})async{
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    String uid=await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("Accounts").doc(uid).set({
      'email':email,
      'password':password,
      'uid':uid,
      'profileImage':'',
      'name':'',
      'designation':'',
      'phone':'',
    });
    return "Success";
  }
  catch(e){
    Fluttertoast.showToast(msg: e.toString());
  }
  return "";
}

Future<String> SignIn({required String email, required String password})async{
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return "Success";

  }
  catch(e){
    Fluttertoast.showToast(msg: e.toString());
  }
  return "";

}

Future<void> SignOut({required String email, required String password})async{
  try{
    await FirebaseAuth.instance.signOut();
  }
  catch(e){
    Fluttertoast.showToast(msg: e.toString());
  }
}

Future<String> editProfile({required String name, required String designation, required String phone,required String uid, required XFile imageFile})async{

try{
  firebase_storage.Reference? ref;
  CollectionReference? imgRef;
  File image=await File(imageFile.path);

  try{

    ref=firebase_storage.FirebaseStorage.instance.ref().child(imageFile!.path);
    await ref?.putFile(image!).whenComplete(()  async{
      await ref?.getDownloadURL().then((value)async{
        await FirebaseFirestore.instance.collection("Accounts").doc(uid).update({
          'name':name,
          'designation':designation,
          'phone':phone,
          'profileImage':value

        });
      });
    });
  }
  catch(e){
    Fluttertoast.showToast(msg: e.toString());
  }

  return "Success";
}
catch(e){
  Fluttertoast.showToast(msg: e.toString());
}

return "";
}

Future<String> addRecipeMethod({required String uid,required String dish,required List<String> ingredients, required String recipe, required String description, required String price, required File imageFile})async{


try{
  firebase_storage.Reference? ref;
  CollectionReference? imgRef;

  try{





    QuerySnapshot<Map<String, dynamic>> snapShot=await FirebaseFirestore.instance.collection('Recipes').doc(uid).collection('recipes').get();

    var length=snapShot.docs.length;
    ref=firebase_storage.FirebaseStorage.instance.ref().child("RecipeImages"+length.toString());
    String imageUrl="";
    await ref?.putFile(imageFile).whenComplete(() async{

      await ref?.getDownloadURL().then((value) {
        imageUrl=value;
        Fluttertoast.showToast(msg:value);
      }).then((value)async{
        await FirebaseFirestore.instance.collection("Recipes").doc(uid).collection("recipes").doc(uid+length.toString()).set({

          "uid":uid,
          "dish":dish,
          "ingredients":FieldValue.arrayUnion(ingredients),
          "recipe":recipe,
          "description":description,
          "price":price,
          "imageUrl":imageUrl

        });
      });
    });

  }
  catch(e){
    Fluttertoast.showToast(msg: e.toString());
  }

  return "Success";

}
  catch(e){
    Fluttertoast.showToast(msg: e.toString());
  }

return "";
}

