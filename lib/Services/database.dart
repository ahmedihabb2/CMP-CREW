// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmp_crew/Models/CMP.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:get_storage/get_storage.dart';

class DatabaseServices{
  final box = GetStorage();
  final String uid;
  String roomID;
  DatabaseServices({this.uid,this.roomID });

  final CollectionReference cmpCollection = FirebaseFirestore.instance.collection("CMP");
  Future updateUserData(String name ,String CurrentRoom) async{
    return await cmpCollection.doc(uid).set({
      "Name" : name ,
      "CurrentRoom" : CurrentRoom ,
      "Roomshistory" : []
    });
  }

Future getCurrentRoom()
async{
    DocumentReference docref = cmpCollection.doc(uid);
   await docref.get().then((value) {
     roomID =value['CurrentRoom'];
   });
}

  List<CMP> _cmpsSnapShots (QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doxs) {
      Map<String, dynamic> map = doxs.data();
      print(doxs.data());
      return CMP(
        name: doxs.get('Name') ?? '' ,
        order: map.containsKey('Order') ?doxs.get('Order') ?? {}:{},
        change: map.containsKey('Change') ? doxs.get('Change') ?? -1 : -1,
      );
    }).toList();
  }

  UserData _userDataFromSnap (DocumentSnapshot snapshot)
  {
    return UserData(
      uid: uid,
      name: snapshot['Name'],
        room: snapshot['CurrentRoom']
    );
  }

  Stream <List<CMP>> get cmps {
    CollectionReference roomCollection=FirebaseFirestore.instance.collection(roomID+"R");
    return roomCollection.snapshots()
        .map(_cmpsSnapShots);
  }

  Stream <UserData> get userdata {
    CollectionReference roomCollection=FirebaseFirestore.instance.collection(roomID+"R");
    return roomCollection.doc(uid).snapshots()
        .map(_userDataFromSnap);
  }

  Future UpdateCurrentRoom(String CurrentRoom)
  async{
    return await cmpCollection.doc(uid).update({
      "CurrentRoom" : CurrentRoom
    });
  }
  String roomIdFromDoc(DocumentSnapshot snapshot)
  {
    return snapshot['CurrentRoom'];
  }

}