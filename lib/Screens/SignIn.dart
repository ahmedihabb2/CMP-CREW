// @dart=2.9
import 'package:cmp_crew/Screens/Intro.dart';
import 'package:cmp_crew/Screens/Register.dart';
import 'package:cmp_crew/Services/AdHelper.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Services/auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  BannerAd _ad;
  bool isLoaded;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_){
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (_,error){
          print('ad failed' + error.toString());
        }
      )
    );
    _ad.load();
  }

  Widget checkforad()
  {
    if(isLoaded == true)
      {
        return Container(
          alignment: Alignment.center,
          width: _ad.size.width.toDouble(),
          child: AdWidget(
            ad: _ad,
          ),
        );
      }
    else
      {
        return CircularProgressIndicator();
      }
  }

  @override
  Widget build(BuildContext context) {

    return loading? Loading() :Scaffold(

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
                height: 10,
              ),
              checkforad(),
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
                        error="Email or Password is incorrect";
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
                  child: const Text('Click Me (Important)'),
                  onPressed:(){ Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>Intro())
                  );}
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(error , style: TextStyle(color: Colors.red),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
