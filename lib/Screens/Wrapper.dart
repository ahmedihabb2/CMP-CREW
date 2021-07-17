// @dart=2.9
import 'package:cmp_crew/Screens/Pre-Home.dart';
import 'package:cmp_crew/Screens/RoomName.dart';
import 'package:cmp_crew/Screens/SignIn.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:cmp_crew/Screens/Home.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SingleUser>(context);
    return user!=null ? (box.read('room')=='0' || box.read('room')==null) ? PreHome() : Home(roomID: box.read('room'),):SignIn();
  }
}
