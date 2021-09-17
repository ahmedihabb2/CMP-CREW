import 'package:cmp_crew/Models/LoadingModel.dart';
import 'package:cmp_crew/Screens/Home.dart';
import 'package:cmp_crew/Screens/JoinigRoom.dart';
import 'package:cmp_crew/Screens/RoomName.dart';
import 'package:cmp_crew/Screens/RoomsHistory.dart';
import 'package:cmp_crew/Services/RoomFinder.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';


class PreHome extends StatefulWidget {
  @override
  _PreHomeState createState() => _PreHomeState();
}

class _PreHomeState extends State<PreHome> {
  final box = GetStorage();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading? Loading3(): Scaffold(
      backgroundColor: Colors.blue[900],
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/Intro.png'),
                fit: BoxFit.cover
            )
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25,),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.22, vertical:MediaQuery.of(context).size.height*0.023 ),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>JoiningRoom()));

              },
              child: Text("Join a room" , style: TextStyle(color: Colors.black , fontSize: 20),),
            ),
            SizedBox(height: 10,),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey[500],
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.20, vertical:MediaQuery.of(context).size.height*0.023 ),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RoomName()));
              },
              child: Text("Create a room" , style: TextStyle(color: Colors.black , fontSize: 20),),
            ),
            SizedBox(height: 10,),
            RaisedButton(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey[600],
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.21, vertical:MediaQuery.of(context).size.height*0.023 ),
              onPressed: ()async{
                Navigator.pushReplacement(context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => RoomsHistory(),
                      transitionDuration: Duration(seconds: 0),
                    )
                );
                /*setState(() {
                  loading = true;
                });
                DatabaseServices database = DatabaseServices(uid:box.read("UserID") );
                await database.getCurrentRoom();
                if(database.roomID!='0')
                  {
                    RoomFinder roomfinder = RoomFinder(roomid:database.roomID,userid: box.read('UserID'));
                    await roomfinder.isExist();
                    if(roomfinder.exist) {
                      box.write("room", database.roomID);
                      await roomfinder.addToRoom();
                      setState(() {
                        loading=false;
                      });
                      Navigator.pushReplacement(context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => Home(roomID:database.roomID ,),
                            transitionDuration: Duration(seconds: 0),
                          )
                      );
                      DatabaseServices(uid: box.read("UserID")).UpdateCurrentRoom(database.roomID);
                    }
                    else
                    {
                      setState(() {
                        loading=false;
                      });
                      Fluttertoast.showToast(
                          msg: "Error Joining",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey[700],
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }

                  }
                else
                  {
                    setState(() {
                      loading=false;
                    });
                    Fluttertoast.showToast(
                        msg: "You haven't entered any room yet",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[700],
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }*/
              },
              child: Text("Room history" , style: TextStyle(color: Colors.black , fontSize: 20),),
            )
          ],
        ),
      ),
    );
  }
}
