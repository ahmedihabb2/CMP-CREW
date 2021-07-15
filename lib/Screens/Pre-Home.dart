import 'package:cmp_crew/Screens/CreatingRoom.dart';
import 'package:cmp_crew/Screens/JoinigRoom.dart';
import 'package:cmp_crew/Screens/RoomName.dart';
import 'package:flutter/material.dart';


class PreHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/Electrical2.png'),
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
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.22, vertical:MediaQuery.of(context).size.height*0.023 ),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RoomName()));
              },
              child: Text("Create a room" , style: TextStyle(color: Colors.black , fontSize: 20),),
            )
          ],
        ),
      ),
    );
  }
}
