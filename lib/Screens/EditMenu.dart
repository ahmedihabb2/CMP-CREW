// @dart =2.9
import 'package:cmp_crew/Models/Item_Price.dart';
import 'package:cmp_crew/Models/LoadingModel.dart';
import 'package:cmp_crew/Services/MenuServices.dart';
import 'package:cmp_crew/Services/OrderServices.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class EditMenu extends StatefulWidget {
  final String roomID;
  List items ;
  List Prices ;
  EditMenu(this.roomID,this.items,this.Prices);
  @override
  _EditMenuState createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  final box = GetStorage();
  final MenuServices menuServices = MenuServices();
  List<ItemPriceModel> dynamicList = [];
  List<String> Price = [];
  List<String> Item = [];
  bool loading = false;
  String UserID;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i =0 ; i< widget.items.length ; i++) {
      ItemPriceModel itemPriceModel = ItemPriceModel();
      itemPriceModel.Item.text = widget.items[i];
      itemPriceModel.Price.text = widget.Prices[i];
      dynamicList.add(itemPriceModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: Text("Edit Menu"),
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
                    MenuServices().updateMenu(widget.roomID, Item , Price);
                    await OrderServices(uid: box.read("UserID")).deleteAllOrders();
                    Navigator.pop(context);
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
                  "Save",
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
      body:  Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
              itemCount: dynamicList.length,
              itemBuilder: (_, index) {
                return Row(
                  children: [
                    Expanded(child: dynamicList[index]),
                    IconButton(onPressed:(){
                      setState(() {
                        dynamicList.removeAt(index);
                      });

                    } ,
                        icon: Icon(Icons.delete_forever,color: Colors.red[200],))
                  ],
                );
              }
          ),
          SizedBox(height: 10,),
          loading? CircularProgressIndicator():SizedBox()
        ],
      )
    );
  }
}
