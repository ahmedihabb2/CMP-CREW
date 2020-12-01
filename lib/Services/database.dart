import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmp_crew/Models/CMP.dart';
import 'package:cmp_crew/Models/SingleUser.dart';

class DatabaseServices{
  final String uid;
  DatabaseServices({this.uid});
  
  final CollectionReference cmpCollection = FirebaseFirestore.instance.collection("CMP");
  Future updateUserData(String name , List<Map<String,int>> sandwiches, int cost, bool sawab3) async{
    return await cmpCollection.doc(uid).set({
      "Name" : name ,
      "Meal" : sandwiches,
      "Cost" : cost,
      "is" : sawab3
    });
  }

  List<CMP> _cmpsSnapShots (QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doxs) {
      return CMP(
        name: doxs.data()['Name'] ?? '' ,
        meal: doxs.data()['Meal']?? [],
        cost: doxs.data()['Cost'] ?? 0,
        sawab3: doxs.data()['is'] ?? true,
      );
    }).toList();
  }

  UserData _userDataFromSnap (DocumentSnapshot snapshot)
  {
    return UserData(
      uid: uid,
      name: snapshot.data()['Name'],
      meal: snapshot.data()['Meal'],
      cost: snapshot.data()['Cost'],
      sawab3: snapshot.data()['is']
    );
  }

  Stream <List<CMP>> get cmps {
    return cmpCollection.snapshots()
        .map(_cmpsSnapShots);
  }

  Stream <UserData> get userdata {
    return cmpCollection.doc(uid).snapshots()
        .map(_userDataFromSnap);
  }

}