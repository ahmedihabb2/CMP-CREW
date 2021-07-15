// @dart=2.9
import 'package:cmp_crew/Models/LoadingModel.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:cmp_crew/Screens/Home.dart';
import 'package:cmp_crew/Screens/Pre-Home.dart';
import 'package:cmp_crew/Services/RoomFinder.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
class JoiningRoom extends StatefulWidget {
  @override
  _JoiningRoomState createState() => _JoiningRoomState();
}

class _JoiningRoomState extends State<JoiningRoom> {
  final box = GetStorage();
  bool loading = false;
  TextEditingController roomID = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SingleUser>(context);
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>PreHome())
        );
        return Future.value(true);
      },
      child:loading? Loading3() : Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/Electrical.png'),
                  fit: BoxFit.cover
              )
          ),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextFormField(
                  controller: roomID,
                  maxLength: 15,
                  decoration: InputDecoration(
                    hintText: "Room ID",
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
                SizedBox(
                  height: 6,
                ),
                RaisedButton(
                  color: Colors.indigo,
                  child: Text(
                    "Join",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  onPressed: ()async{
                    setState(() {
                      loading = true;
                    });
                    RoomFinder roomfinder = RoomFinder(roomid: roomID.text.trim(),userid: user.uid);
                    await roomfinder.isExist();
                    if(roomfinder.exist) {
                      box.write("room", roomID.text.trim());
                      await roomfinder.addToRoom();
                      setState(() {
                        loading=false;
                      });
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => Home(roomID: roomID.text.trim(),)));
                      DatabaseServices(uid: user.uid).UpdateCurrentRoom(roomID.text.trim());
                    }
                    else
                      {
                        setState(() {
                          loading=false;
                        });
                        Fluttertoast.showToast(
                            msg: "Please check the ID and try again",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey[700],
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                  },
                ),
                TextButton(
                  child: Text(
                    "Back",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  onPressed: (){
                     Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context)=>PreHome())
                     );
                    }

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
