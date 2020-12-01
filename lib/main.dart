import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Models/SingleUser.dart';
import 'package:cmp_crew/Screens/Register.dart';
import 'package:cmp_crew/Screens/SignIn.dart';
import 'package:cmp_crew/Services/auth.dart';
import 'package:cmp_crew/loading.dart';
import 'package:provider/provider.dart';
import 'Screens/Wrapper.dart';
Future<void> main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<SingleUser>.value(
      value: AuthServices().userStream,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
