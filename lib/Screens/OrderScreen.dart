// @dart=2.9
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:cmp_crew/Screens/Pre-Home.dart';
import 'package:cmp_crew/Screens/Wrapper.dart';
import 'package:cmp_crew/Services/OrderServices.dart';
import 'package:cmp_crew/Services/RoomFinder.dart';
import 'package:cmp_crew/Services/auth.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final box = GetStorage();
  TextEditingController paid = TextEditingController();
  final _key = GlobalKey<FormState>();
  double totalPrice;
  List values=[];
  double valid=-1;
  bool loading=false;
  bool orderExist = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: OrderServices(uid: box.read("UserID")).getUserOrder(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List keys=[];
                  if(snapshot.data['Order'] != null) {
                    keys = snapshot.data['Order'].keys.toList();
                    values = snapshot.data['Order'].values.toList();
                  }
                  else
                  {
                    orderExist=false;
                    keys = [];
                    values = [];
                  }
                  totalPrice = snapshot.data['TotalPrice'];
                  return Column(
                    children: [
                      Card(
                        margin: EdgeInsets.all(12),
                        elevation: 1.5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data['Order']!=null ? snapshot.data['Order'].length:0,
                          itemBuilder: (context, index)
                          {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  index==0 ?  Text("Your order",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.bold),):SizedBox(),
                                  index==0 ? SizedBox(height: 10,):SizedBox(),
                                  Row(
                                    children: [
                                      Text(keys[index]+" (x"+values[index][1].toInt().toString()+")"+" : ",style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold) ,),
                                      Text(values[index][0].toString()+" LE",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                  index==snapshot.data['Order'].length-1 ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text("Total Money",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.bold),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data['TotalPrice'].toString()+" LE",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ):SizedBox()
                                  ,
                                  index==snapshot.data['Order'].length-1 ?
                                  Text("CMP CREW ANA B7BO ©",style: TextStyle(fontSize: 10),)
                                      :
                                  SizedBox()
                                ],

                              ),
                            );
                          },
                        ),
                      ),
                      orderExist ?Column(
                        children: [
                          Text("Daf3t Kam ?",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.bold),),
                          Form(
                            key: _key,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (val){
                                  return (val.isEmpty || val=='.') ? "Da5l daf3t kam yasta b3d eznk :)" :double.parse(val) > 1000 ? "Max 1000 LE":null;
                                },
                                controller: paid,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "2ol bsra7a",
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  contentPadding: EdgeInsets.all(12.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                              color: Colors.indigo,
                              child: Text(
                                "Lya ba2y?",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              onPressed: ()
                              async{
                                if(_key.currentState.validate())
                                {
                                  setState(() {
                                    loading=true;
                                  });
                                  valid=await OrderServices(uid: box.read("UserID")).checkVaildMoney(double.parse(paid.text));
                                  setState(() {
                                    loading=false;
                                  });
                                }
                              }
                          ),
                        ],
                      )
                          : Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text("Shoflak 7aga takolha yasta",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.bold),),
                      )

                    ],
                  );
                }else
                {
                  return Container();
                }
              },
            ),
            loading ? CircularProgressIndicator(
            ) : valid==-1 ? SizedBox()
                : valid==-2 ? Text("Hthazr m3aya yasta? da5l rkm s7",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w500),)
                : Column(
              children: [
                valid> 0 ?Text("Leek ${valid} ba2y aw3a tsebhom xD",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w500),)
                    :Text("Malksh ba2y yasta",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w500),),
                Text("Check home screen to see your change",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.w500))
              ],
            ),
            RaisedButton(
                shape:
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.red)
                ),
                color: Colors.indigo,
                child: Text(
                  "Sign out 😔",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                onPressed: ()
                async{
                  box.remove('UserID');
                  box.remove('room');
                  await AuthServices().signUserOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Wrapper()));
                }
            ),
            RaisedButton(
                color: Colors.indigo,
                child: Text(
                  "Join another room",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                onPressed: ()
                {
                  RoomFinder(userid: box.read('UserID'),roomid: box.read('room')).removeFromRoom();
                  box.write('room', '0');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PreHome()));
                }
            ),
            Text("Long press to copy room ID",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            SelectableText(box.read('room'),style:TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
         await OrderServices(uid: box.read('UserID')).deleteOrder();
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
