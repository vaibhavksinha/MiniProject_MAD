import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projecttest/login_screen.dart';

import 'main.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    _navigator();
    super.initState();
  }

  _navigator()async{
    await Future.delayed(Duration(seconds: 2));
     Navigator.pushReplacement<void, void>(
       context,
       MaterialPageRoute<void>(
         builder: (BuildContext context) => LoginScreen(),)
     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        height: 170,
        alignment: Alignment.center,


        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Stock Prediction",
              textAlign: TextAlign.center,style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic), ),


            SizedBox(
              height: 20,


            ),
            SizedBox(
              width: 300,
              child: LinearProgressIndicator(
                backgroundColor: Colors.lightBlue,
                color: Colors.greenAccent,


              ),
            ),
            SizedBox(
              height: 20,


            ),
            Text("by Vaibhav Nishita Benjamin",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold , fontStyle: FontStyle.italic),),
          ],
        ),
      )),
    );
  }


}
