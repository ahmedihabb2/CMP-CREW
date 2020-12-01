import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:cmp_crew/Services/database.dart';
class AuthServices{
  //Create instance from firestore

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Create user model
  SingleUser _userFromFirebase(User user)
  {
    return user!=null ? SingleUser(uid: user.uid) : null ;
  }

  Stream<SingleUser>get userStream {
    return _auth.authStateChanges()
        .map(_userFromFirebase);
  }
  //Register with email and password
  Future regWithEmailandpass (String email , String password) async{
    final List<Map<String,int>> sandwiches =[{"Fool":0} , {"Ta3meya":0} , {"Batates":0},{"8anoog":0}];
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      //Create a new document for the new user
      await DatabaseServices(uid: user.uid).updateUserData("New CMP", sandwiches , 0,true);
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
      User user = result.user;
      return _userFromFirebase(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  //SignOut

  Future signUserOut() async {
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}

}