import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Loading.png'),
          fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SpinKitThreeBounce(
                color: Colors.white,
                size: 40.0,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Welcome , Cream <3"
              , style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  wordSpacing: 1.5
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
