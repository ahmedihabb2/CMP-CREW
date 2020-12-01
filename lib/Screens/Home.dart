import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Models/CMP.dart';
import 'package:cmp_crew/Models/SettingsForm.dart';
import 'package:cmp_crew/Models/brewlist.dart';
import 'package:cmp_crew/Services/auth.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:provider/provider.dart';

import 'Statistics.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _authServices = AuthServices();
  int currentindex =0;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CMP>>.value(
      value: DatabaseServices().cmps,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentindex,
          fixedColor: Colors.blue[900],
          selectedIconTheme: IconThemeData(
            size: 30
          ),
          onTap: (index){
            setState(() {
              currentindex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                title: Text("Home"),
                icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
              title: Text("Statistics"),
              icon: Icon(Icons.filter_list)
            ),
            BottomNavigationBarItem(
                title: Text("Order"),
                icon: Icon(Icons.settings)
            ),
          ],
        ),
        appBar: AppBar(
          actions: [

            FlatButton.icon(
              icon: Icon(Icons.person , color: Colors.white,),
              label: Text("Sign out" , style: TextStyle(
                color: Colors.white
              ),),
              onPressed: ()async{
               await  AuthServices().signUserOut();
              },
            ),
          ],
          backgroundColor: Colors.blue[900],
          title: Text(
            "CMP CREW",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: currentindex==0 ? BrewList() : currentindex ==1 ? Statistics() : currentindex==2 ? SettingForm():Container(),
      ),
    );
  }
}
