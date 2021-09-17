import 'package:cmp_crew/Screens/SignIn.dart';
import 'package:cmp_crew/Screens/Wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Services/auth.dart';
import 'package:cmp_crew/loading.dart';
import 'package:get_storage/get_storage.dart';

class Register extends StatefulWidget {


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final box = GetStorage();
  String email = '';
  String username = '';
  String password = '';
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage('assets/Intro.png'),
                      fit: BoxFit.cover)),
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
                          borderSide:
                              BorderSide(color: Colors.grey[300]!, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) =>
                          val!.isEmpty ? "Please Enter Your Email" : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        fillColor: Colors.grey[100],
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          username = val;
                        });
                      },
                      validator: (val) =>
                      val!.isEmpty ? "Please Enter Your Username" : null,
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
                          borderSide:
                              BorderSide(color: Colors.grey[300]!, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val) => val!.length < 6
                          ? "Password Should Be More Than 6 Characters"
                          : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.indigo,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });

                          dynamic result = await _auth.regWithEmailandpass(email.trim(),username.trim(), password);
                          Navigator.pushReplacement(context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => Wrapper(),
                                transitionDuration: Duration(seconds: 0),
                              )
                          );
                          box.write('room', '0');
                          if (result == null)
                            setState(() {
                              error = "Please Check Your data";
                              loading = false;
                            });
                        }
                      },
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => SignIn(),
                            transitionDuration: Duration(seconds: 0),
                          )
                      );
                    },
                        child: Text("Already CMP? .. Sign in" ,
                          style: TextStyle(color: Colors.white
                            ,
                            decoration: TextDecoration.underline,
                          ),
                        )
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
