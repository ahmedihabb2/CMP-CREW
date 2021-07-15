import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class OrderServices
{
  String? uid;
  OrderServices({this.uid});
  final box = GetStorage();
  Future submitOrder(Map<String,List<double>> order , double totalPrice)
  async {
    CollectionReference RoomsR = FirebaseFirestore.instance.collection(
        box.read("room") + "R");
    RoomsR.doc(uid).update(
        {
          "Order": order,
          "TotalPrice" : totalPrice
        }
    );
  }
  Map? orderData(DocumentSnapshot snapshot)
  {
    return snapshot.data() as Map<dynamic, dynamic>?;
  }
  Stream getUserOrder()
  {
    CollectionReference RoomsR = FirebaseFirestore.instance.collection(
        box.read("room") + "R");
    return RoomsR.doc(uid).snapshots().map(orderData);
  }

  Future<double> checkVaildMoney(double paid)
  async{
    CollectionReference RoomsR = FirebaseFirestore.instance.collection(
        box.read("room") + "R");
    DocumentSnapshot cmpDoc=await  RoomsR.doc(uid).get();
    if(paid < cmpDoc['TotalPrice'])
      return -2;
    else
      {
        RoomsR.doc(uid).update({
          'Change' : paid-cmpDoc['TotalPrice']
        });
      }
      return paid-cmpDoc['TotalPrice'];

  }

  Future deleteOrder()
  async{
    CollectionReference RoomsR = FirebaseFirestore.instance.collection(
        box.read("room") + "R");
    RoomsR.doc(uid).update(
      {
        "Order" : FieldValue.delete()
      }
    );
  }
}