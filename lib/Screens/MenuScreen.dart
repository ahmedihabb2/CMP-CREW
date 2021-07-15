// @dart=2.9
import 'package:cmp_crew/Services/MenuServices.dart';
import 'package:cmp_crew/Services/OrderServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  final String roomID;

  MenuScreen({this.roomID});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final box = GetStorage();
  List<bool> checked = List<bool>.filled(50, false);
  List<int> qty = List<int>.filled(50, 0);
  List<TextEditingController> _controller = List.generate(50, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MenuServices().getMenu(widget.roomID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map data = snapshot.data;
          data.remove("Admin");
          data.remove("Name");
          List items = data.keys.toList();
          List Prices = data.values.toList();
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2),
                        child: Card(
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          items[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          Prices[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: Colors.blue[800]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Pick",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        SizedBox(
                                          height: 15,
                                          child: Checkbox(
                                              shape: CircleBorder(),
                                              value: checked[index],
                                              onChanged: (bool val) {
                                                setState(() {
                                                  checked[index] = val;
                                                });
                                                if(val)
                                                  {
                                                    qty[index]=1;
                                                    _controller[index].text='1';
                                                  }
                                                else
                                                  {
                                                    _controller[index].clear();
                                                  }
                                              }),
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          width: 65,
                                          child: TextField(
                                            controller: _controller[index],
                                            onChanged: (val) {
                                              setState(() {
                                                qty[index] = int.parse(val);
                                              });
                                            },
                                            enabled: checked[index],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: "QTY",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[600]),
                                              fillColor: Colors.grey[100],
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.all(12.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300],
                                                    width: 2.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.0),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 9,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: box.read('role') == 1
                              ? Colors.blue[700]
                              : Colors.grey[600],
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool valid = true;
                      bool noChecked = false;
                      if(!checked.contains(true)) noChecked=true;
                      for(int i=0 ; i< data.length ; i++)
                        {
                          if(checked[i] &&(qty[i]==0 || qty[i] < 0 || qty[i] >50))
                            {
                              valid=false;
                              Fluttertoast.showToast(
                                  msg: "Qty cannot be empty or zero and max 50",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey[700],
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              break;
                            }
                        }
                     if(valid&&!noChecked)
                       {
                         double sum = 0;
                         Map<String, List<double>> order = {};
                         for (int i = 0; i < data.length; i++) {
                           if (checked[i]) {
                             order[items[i]] = [
                               double.parse(Prices[i]) * qty[i],
                               qty[i].toDouble()
                             ];
                             sum += double.parse(Prices[i]) * qty[i];
                           }
                         }
                         print(box.read("UserID"));
                         await OrderServices(uid: box.read("UserID"))
                             .submitOrder(order, sum);

                         Fluttertoast.showToast(
                             msg: "Done ... Bos kda 3la el order screen ;)",
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
                             msg: "Pick at least one order",
                             toastLength: Toast.LENGTH_SHORT,
                             gravity: ToastGravity.CENTER,
                             timeInSecForIosWeb: 1,
                             backgroundColor: Colors.grey[700],
                             textColor: Colors.white,
                             fontSize: 16.0);
                       }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 9,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: checked.contains(true)
                              ? Colors.blue[700]
                              : Colors.grey[600],
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
