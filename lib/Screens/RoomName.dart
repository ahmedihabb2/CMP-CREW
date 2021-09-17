import 'package:cmp_crew/Screens/CreatingRoom.dart';
import 'package:flutter/material.dart';

import 'Pre-Home.dart';


class RoomName extends StatelessWidget {
  TextEditingController roomName = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>PreHome())
        );
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/Intro.png'),
                  fit: BoxFit.cover
              )
          ),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.09),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Form(
                  key: _key,
                  child: TextFormField(
                    validator: (val){
                      return val!.length <=1 ? "Name must be more than 1 char" : null;
                    },
                    controller: roomName,
                    maxLength: 15,
                    decoration: InputDecoration(
                      hintText: "Room name ... max 15 character",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.all(12.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                RaisedButton(
                  color: Colors.indigo,
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  onPressed: (){
                    if(_key.currentState!.validate()) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>
                              CreateRoom(roomName: roomName.text,)));
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
