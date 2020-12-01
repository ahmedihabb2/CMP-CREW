import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Services/auth.dart';

import '../loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
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

  @override
  Widget build(BuildContext context) {
    return loading? Loading() :Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person , color: Colors.white,),
            label: Text('Register' , style: TextStyle(color: Colors.white),),
            onPressed: ()
            {widget.toggleView();}
            ,
          )
        ],
        backgroundColor: Colors.blue[900],
        title: Text(
          "Sign In",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/Electrical.png'),
                fit: BoxFit.cover
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                height: 20,
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
                    dynamic result =await _auth.signinWithEmailandpass(email, password);
                    if(result == null)
                      setState(() {
                        error="Email or Password is incorrect";
                        loading = false;
                      });
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(error , style: TextStyle(color: Colors.red),)
            ],
          ),
        ),
      ),
    );
  }
}
