import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:cmp_crew/decoration.dart';
import 'package:cmp_crew/loading.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  int groupval=1;
  bool hyakolBatats = false;
  final _formkey = GlobalKey<FormState>();
  final List<String> qty = ['0','1','2','3','4','5'];
  //Form values
  String _name;
  int _foolqty;
  int _ta3myaqty;
  int _batatsqty;
  int _8anoogqty;
  int _cost=0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SingleUser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid: user.uid).userdata,
      builder:(context,snapshot) {
        if(snapshot.hasData) {
          UserData userData = snapshot.data;
          return Scaffold(

            body: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Text("Hatakol eh yasta ?" , style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration,
                        validator: (val) {
                          return val.isEmpty
                              ? "Please enter your name yasta"
                              : null;
                        },
                        onChanged: (val) {
                          setState(() {
                            _name = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        validator: (val)
                        {
                          return val==null ? 'E5tar 7aga yasta' : null ;
                        },
                        decoration: InputDecoration(
                          hintText: "Kam Fool ya 7ob",
                          fillColor: Colors.grey[100],
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300],
                                width: 2.0),
                          ),
                        ),
                        items: qty.map((qtys) {
                          return DropdownMenuItem(
                            value: qtys,
                            child: Text("$qtys Fool"),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _foolqty = int.parse(val);
                            _cost += int.parse(val)*3;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        validator: (val)
                        {
                          return val==null ? 'E5tar 7aga yasta' : null ;
                        },
                        decoration: InputDecoration(
                          hintText: "Kam Ta3meya ya alby",
                          fillColor: Colors.grey[100],
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300],
                                width: 2.0),
                          ),
                        ),
                        items: qty.map((qtys) {
                          return DropdownMenuItem(
                            value: qtys,
                            child: Text("$qtys Ta3meya"),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _ta3myaqty = int.parse(val);
                            _cost += int.parse(val)*3;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        validator: (val)
                        {
                          return val==null ? 'E5tar 7aga yasta' : null ;
                        },
                        decoration: InputDecoration(
                          hintText: "Kam 8anoog ya Baba ",
                          fillColor: Colors.grey[100],
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300],
                                width: 2.0),
                          ),
                        ),
                        items: qty.map((qtys) {
                          return DropdownMenuItem(
                            value: qtys,
                            child: Text("$qtys 8anoog"),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _8anoogqty = int.parse(val);
                            _cost += int.parse(val)*4;

                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        validator: (val)
                        {
                          return val==null ? 'E5tar 7aga yasta' : null ;
                        },
                        decoration: InputDecoration(
                          hintText: "Kam batats ya creemaa",
                          fillColor: Colors.grey[100],
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300],
                                width: 2.0),
                          ),
                        ),
                        items: qty.map((qtys) {
                          return DropdownMenuItem(
                            value: qtys,
                            child: Text("$qtys Batats"),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _batatsqty = int.parse(val);
                            _cost += int.parse(val)*4;
                            if(int.parse(val) > 0)
                              {
                                hyakolBatats = true;
                              }
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      hyakolBatats ?Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            autofocus: true,
                              value: 1, groupValue: groupval, onChanged:(T){
                            setState(() {
                              groupval = T;
                            });
                          }),
                          Text('Sawab3' , style: TextStyle(
                            fontWeight: FontWeight.w600
                          ),),
                          Radio(value: 2, groupValue: groupval, onChanged:(T){
                            setState(() {
                              groupval = T;
                            });
                          }),
                          Text('Chipsy' , style: TextStyle(
                              fontWeight: FontWeight.w600)),
                        ],
                      ) : SizedBox(),
                      RaisedButton(
                        color: Colors.indigo[700],
                        child: Text("Update"),
                        textColor: Colors.white,
                        onPressed: () async {
                          if(_formkey.currentState.validate())
                            {
                              await DatabaseServices(uid: user.uid).updateUserData(
                                  _name ?? userData.name,
                                   [
                                  {"Fool": _foolqty },
                                  {"Ta3meya": _ta3myaqty},
                                  {"Batates": _batatsqty},
                                     {"8anoog":_8anoogqty},
                                  ] ,
                              _cost ?? userData.cost,
                              groupval ==1 ? true : false
                              );
                              Fluttertoast.showToast(msg: "Done yasta <3",
                                  toastLength: Toast.LENGTH_LONG);
                            }

                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }
}
