// @dart=2.9
import 'package:cmp_crew/Models/LoadingModel.dart';
import 'package:cmp_crew/Screens/Pre-Home.dart';
import 'package:cmp_crew/Services/RoomFinder.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import 'Home.dart';
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
class RoomsHistory extends StatefulWidget {
  @override
  _RoomsHistoryState createState() => _RoomsHistoryState();
}

class _RoomsHistoryState extends State<RoomsHistory> {
  final box = GetStorage();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => PreHome(),
              transitionDuration: Duration(seconds: 0),
            )
        );
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushReplacement(context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => PreHome(),
                    transitionDuration: Duration(seconds: 0),
                  )
              );
            },
          ),
          elevation: 0,
          backgroundColor: Colors.blue[900],
          centerTitle: true,
          title: Text(
            "History",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: FutureBuilder(
          future: DatabaseServices(uid: box.read('UserID')).getRoomsHistory(),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData && snapshot.data != {}) {
              List RoomID, RoomName;
              RoomID = snapshot.data.keys.toList();
              RoomName = snapshot.data.values.toList();
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: RoomID.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 1,
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(RoomName[index] , style: TextStyle(fontWeight: FontWeight.w600),),
                          subtitle: Text(RoomID[index]),
                          trailing: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                RoomFinder roomfinder = RoomFinder(
                                    roomid: RoomID[index], userid: box.read('UserID'));
                                await roomfinder.isExist();
                                if (roomfinder.exist) {
                                  box.write("room", RoomID[index]);
                                  await roomfinder.addToRoom();
                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home(
                                                roomID: RoomID[index],
                                              )));
                                  DatabaseServices(uid: box.read('UserID'))
                                      .UpdateCurrentRoom(RoomID[index]);
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "This room does not exist any more",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey[700],
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: Text('Join'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.indigo[600])),
                        ),
                      );
                    },
                  ),
                  loading ? CircularProgressIndicator():SizedBox()
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
