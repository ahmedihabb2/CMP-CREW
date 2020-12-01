import 'package:flutter/material.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:cmp_crew/Screens/Authentication.dart';
import 'package:cmp_crew/Screens/Home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SingleUser>(context);
    return user!=null ? Home() : Authentication();
  }
}
