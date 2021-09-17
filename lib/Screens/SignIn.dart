// @dart=2.9
import 'package:cmp_crew/Screens/Home.dart';
import 'package:cmp_crew/Screens/Intro.dart';
import 'package:cmp_crew/Screens/Register.dart';
import 'package:cmp_crew/Services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Services/auth.dart';
import 'package:get_storage/get_storage.dart';

import '../loading.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  bool loading = false;
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {

    return loading? Loading() :Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/Intro.png'),
                fit: BoxFit.cover
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              error != '' ?Text(error , style: TextStyle(color: Colors.red),):SizedBox(),
              SizedBox(height: 2,),
              TextFormField(
                decoration: InputDecoration(
          hintText: "Email",
            hintStyle: TextStyle(color: Colors.grey[600]),
            fillColor: Colors.grey[100],
            filled: true,
            contentPadding: EdgeInsets.all(12.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                validator: (val) => val.isEmpty ? "Please Enter Your Email" : null,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  fillColor: Colors.grey[100],
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                validator: (val) => val.length <6 ? "Password Should Be More Than 6 Characters" : null,
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                color: Colors.indigo,
                child: Text(
                  "Sign in",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                onPressed: ()
                async {
                  if(_formKey.currentState.validate())
                  {
                    setState(() {
                      loading = true;
                    });
                    dynamic result =await _auth.signinWithEmailandpass(email.trim(), password);
                    if(result == null)
                      setState(() {
                        error="Incorrect email or password";
                        loading = false;
                      });
                  }
                },
              ),

              TextButton(onPressed: (){
                Navigator.pushReplacement(context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Register(),
                    transitionDuration: Duration(seconds: 0),
                  )
                );
              },
                  child: Text("New CMP? .. Register" ,
                  style: TextStyle(color: Colors.white
                      ,
                    decoration: TextDecoration.underline,
                  ),
                  )
              ),
              TextButton(
                  child: const Text('User guides'),
                  onPressed:(){ Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>Intro())
                  );}
              ),

            ],
          ),
        ),
      ),
    );
  }
}
