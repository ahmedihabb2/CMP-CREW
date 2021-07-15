import 'package:cmp_crew/Models/Item_Price.dart';
import 'package:cmp_crew/Models/LoadingModel.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:cmp_crew/Screens/Home.dart';
import 'package:cmp_crew/Services/MenuServices.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:cmp_crew/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';


class CreateRoom extends StatefulWidget {
  final String? roomName;
  CreateRoom({this.roomName});
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final box = GetStorage();
  final MenuServices menuServices = MenuServices();
  List<ItemPriceModel> dynamicList = [ItemPriceModel()];
  List<String> Price = [];
  List<String> Item = [];
  bool loading = false;
  String? UserID;
  addDynamic() {
    if (Item.length != 0) {
      Item = [];
      Price = [];
      dynamicList = [];
    }
    setState(() {});
    if (dynamicList.length >= 15) {
      return;
    }
    dynamicList.add(ItemPriceModel());
  }

  submitData() {
    Item = [];
    Price = [];
    dynamicList.forEach((widget) {
      print(widget.Item.text);
      if (widget.Item.text != "") Item.add(widget.Item.text);
    });

    dynamicList.forEach((widget) {
      if (widget.Price.text != "") Price.add(widget.Price.text);
    });
    setState(() {});
  }
  

  @override
  Widget build(BuildContext context) {
    return loading? Loading2(): Scaffold(
      appBar: AppBar(
          title: Text("Prepare the menu"),
          backgroundColor: Colors.blue[900],
          actions: [
            FlatButton(
                onPressed: ()
                async{
                  submitData();
                  bool flag = true;
                  bool neg = false;
                  if((Item.length+Price.length)/2 < dynamicList.length)
                    {
                      flag = false;
                    }
                  for(int i=0 ; i<Price.length ; i++)
                    {
                      if(double.parse(Price[i]) <= 0 || double.parse(Price[i]) >200 || Item[i].length > 100)
                        {
                          neg = true;
                          break;
                        }
                    }
                 if(flag && !neg)
                   {
                     setState(() {
                       loading = true;
                     });
                     UserID = box.read('UserID');
                     var roomID= await menuServices.CreateMenu(UserID,widget.roomName ,Item, Price);
                     await DatabaseServices(uid: UserID).UpdateCurrentRoom(roomID);
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(roomID: roomID,)));
                   }else
                     {
                       if(!neg) {
                         Fluttertoast.showToast(
                             msg: "No empty fields are allowed",
                             toastLength: Toast.LENGTH_SHORT,
                             gravity: ToastGravity.CENTER,
                             timeInSecForIosWeb: 1,
                             backgroundColor: Colors.grey[700],
                             textColor: Colors.white,
                             fontSize: 16.0);
                       }
                       else
                         {
                           Fluttertoast.showToast(
                               msg: "No zeros or negative values are allowed and max 200 LE",
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.CENTER,
                               timeInSecForIosWeb: 1,
                               backgroundColor: Colors.grey[700],
                               textColor: Colors.white,
                               fontSize: 16.0);
                         }
                     }
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontStyle: FontStyle.italic),
                ))
          ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        onPressed: addDynamic,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: dynamicList.length,
        itemBuilder: (_, index) => dynamicList[index],
      ),
    );
  }
}
