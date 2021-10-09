import 'package:cmp_crew/Screens/EditMenu.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context,String roomID,List items,List Prices) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel",style: TextStyle(color: Colors.grey),),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {
      Navigator.pushReplacement(context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => EditMenu(roomID,items,Prices),
            transitionDuration: Duration(seconds: 0),
          )
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Warning !"),
    content: Text("Editing the menu will remove all orders from the room, are you sure to proceed "),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}