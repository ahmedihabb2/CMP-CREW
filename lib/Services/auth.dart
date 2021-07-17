import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthServices{
  final box = GetStorage();
  //Create instance from firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Create user model
  SingleUser? _userFromFirebase(User? user)
  {
    return user!=null ?SingleUser(uid: user.uid) : null ;
  }

  Stream<SingleUser?>get userStream {
    return _auth.authStateChanges()
        .map(_userFromFirebase);
  }

  //Register with email and password
  Future regWithEmailandpass (String email ,String username, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      //Create a new document for the new user
      await DatabaseServices(uid: user.uid).updateUserData(username,"0");
      box.write("UserID",user.uid);
      return _userFromFirebase(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  //Sign in with email and password
  Future signinWithEmailandpass (String email , String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      box.write("UserID",user.uid);
      return _userFromFirebase(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  //SignOut

  Future signUserOut() async{
    try {
       await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}

}