import 'package:cmp_crew/Screens/SignIn.dart';
import 'package:flutter/material.dart';

TextStyle style = TextStyle(fontStyle: FontStyle.italic,fontSize: 16,fontWeight: FontWeight.bold);
TextStyle style2 = TextStyle(fontSize: 16,fontWeight: FontWeight.bold);
TextStyle style3 = TextStyle(fontSize: 16,fontWeight: FontWeight.w400);
class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>SignIn())
        );
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context)=>SignIn())
              );
            },
          ),
          elevation: 0,
          backgroundColor: Colors.blue[900],
          centerTitle: true,
          title: Text(
            "CMP CREW",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Card(
            margin: EdgeInsets.all(12),
            elevation: 1.5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text("Welcome to new CMP CREW <3",style: style,)),
                    SizedBox(height: 5,),
                    Text("It is a new version upgraded to flutter 2",style: style2,),
                    SizedBox(height: 5,),
                    Text("New Features :",style: style2),
                    Text(" • Now you can create your own room with a custom menu",style: style3),
                    Text(" • You can join any room (but only one at a time) and choose your order from the menu created by room admin",style: style3),
                    Text(" • You can enter how much money you paid to know your change",style: style3),
                    Text(" • You can leave the room and join another one",style: style3),
                    Text(" • Only the admin can change the menu (beta)",style: style3),
                    Text(" • Notifications now work correctly and you can see them in notifications bar",style: style3),
                    Text("How to use :",style: style2),
                    Text(" • After signing in you can join or create a room",style: style3),
                    Text(" • If you are creating a room you will put menu items and their prices",style: style3),
                    Text(" • Send the room ID to your friends by copying it from the order settings screen",style: style3),
                    Text(" • Go to menu page and pick any item you want and specify the quantity",style: style3),
                    Text(" • Click Save then check the orders screen to see your order and how much it will cost you",style: style3),
                    Text("Notes :",style: style2),
                    Text(" • If the room admin left the room no one will be admin but when he rejoin again he will still be the admin of the room",style: style3),
                    Text(" • If there is any bug please tell me and feel free to join me to fix it or to implement any new feature ;)",style: style3),
                    Center(child: Text("Made with love <3",style: style,)),
                    Image(image: ExactAssetImage(
                        'assets/cmppic.jpg'
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
