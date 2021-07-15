import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmp_crew/Models/CMP.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:get_storage/get_storage.dart';

import 'RandomCodeGenerator.dart';


class MenuServices
{
  String? uid;
  String roomID=getRandomString(6);
  final box = GetStorage();
  MenuServices({this.uid});
  final CollectionReference Rooms = FirebaseFirestore.instance.collection("Rooms");

  Future<String> CreateMenu(String? CreatorID ,String? roomName ,List<String> items , List<String> Prices)
 async {
    Map<String,String?> menu= {
      "Admin" : CreatorID,
      "Name" : roomName,
      for(int i = 0; i < items.length; i++) items[i] : Prices[i]
    };
    box.write('role', 1);
    box.write('room', roomID);
    CollectionReference RoomsR =FirebaseFirestore.instance.collection(roomID+"R");
    CollectionReference cmpData =FirebaseFirestore.instance.collection("CMP");
    DocumentSnapshot cmpDoc=await  cmpData.doc(CreatorID).get();
    await RoomsR.doc(CreatorID).set({
      "Name": cmpDoc["Name"]+" (Admin)",
    });
    await Rooms.doc(roomID).set(
      menu
    );
    return roomID;
  }

  Future<String> getRoomName(String roomID)async{
    DocumentReference documentReference = Rooms.doc(roomID);
    return await documentReference.get().then((value) {
      return value['Name'];
    });
  }

  Map? dataFromMenu(DocumentSnapshot snapshot)
  {
    return snapshot.data() as Map<dynamic, dynamic>?;
  }

  Stream   getMenu(String? roomID)
  {
    return Rooms.doc(roomID).snapshots().map(dataFromMenu);
  }
}