// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:cmp_crew/Screens/MenuScreen.dart';
import 'package:cmp_crew/Screens/OrderScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Models/CMP.dart';
import 'package:cmp_crew/Models/brewlist.dart';
import 'package:cmp_crew/Services/auth.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'Statistics.dart';

class Home extends StatefulWidget {
  final String roomID;
  Home({this.roomID});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final box = GetStorage();
   DatabaseServices databaseServices ;
  final AuthServices _authServices = AuthServices();
  int currentindex =0;
  @override
  void initState() {
    // TODO: implement initState
    databaseServices = DatabaseServices(uid: box.read("UserID"),roomID: widget.roomID);
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<CMP>>.value(
      value: databaseServices.cmps,
      child: Scaffold(
        
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 13,
          unselectedFontSize: 12,
          currentIndex: currentindex,
          unselectedItemColor: Colors.blue[700],
          selectedItemColor: Colors.blue[900],
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
                label: "Home",
                icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
              label: "Statistics",
              icon: Icon(Icons.filter_list)
            ),
            BottomNavigationBarItem(
                label: "Menu",
                icon: Icon(Icons.menu_book)
            ),
            BottomNavigationBarItem(
                label: "Order",
                icon: Icon(Icons.settings)
            ),
          ],
        ),
        appBar: AppBar(

          elevation: 0,
          backgroundColor: Colors.blue[900],
          centerTitle: true,
          title: Text(
            "CMP CREW",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: currentindex==0 ? BrewList() : currentindex ==1 ? Statistics() :currentindex==2 ? MenuScreen(roomID: widget.roomID,) :currentindex==3 ? OrderScreen():Container(),
      ),
    );
  }
}
