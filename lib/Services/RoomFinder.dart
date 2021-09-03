// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class RoomFinder {
  String roomid;
  String userid;
  bool exist = false;
  final box = GetStorage();

  RoomFinder({this.roomid, this.userid});

  final CollectionReference roomCollection =
      FirebaseFirestore.instance.collection("Rooms");

  Future<bool> isExist() async {
    QuerySnapshot querySnapshot = await roomCollection.get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    docs.forEach((element) {
      if (element.id == roomid) {
        exist = true;
      }
    });
  }

  addToRoom() async {
    bool admin = false;
    DocumentSnapshot roomDoc = await roomCollection.doc(roomid).get();
    if (roomDoc['Admin'] == userid) {
      admin = true;
      box.write('role', 1);
    } else {
      box.write('role', 0);
    }
    CollectionReference cmpData = FirebaseFirestore.instance.collection("CMP");
    DocumentSnapshot cmpDoc = await cmpData.doc(userid).get();
    List roomshistory = cmpDoc['Roomshistory'];
    roomshistory.add(roomid);
    await cmpData.doc(userid).update({
      "Roomshistory" : roomshistory.toSet().toList()
    });
    CollectionReference RoomsR =
        FirebaseFirestore.instance.collection(roomid + "R");
    bool exist=false;
    RoomsR.doc(userid).get().then((value) => exist=value.exists);
    if(exist) {
      await RoomsR.doc(userid).update({
        "Name": (admin == true
            ? cmpDoc['Name'] + " (Admin)"
            : cmpDoc['Name']),
      });
    }
    else
      {
        await RoomsR.doc(userid).set({
          "Name": (admin == true
              ? cmpDoc['Name'] + " (Admin)"
              : cmpDoc['Name']),
        });
      }
  }

  Future removeFromRoom()
  async{
    CollectionReference RoomsR = FirebaseFirestore.instance.collection(
        roomid+ "R");
    RoomsR.doc(userid).delete();
  }
}
