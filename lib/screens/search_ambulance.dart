import 'package:flutter/material.dart';

import 'map_screen.dart';

class Search_ambulance extends StatefulWidget {
  const Search_ambulance({super.key});

  @override
  State<Search_ambulance> createState() => _Search_ambulanceState();
}

class _Search_ambulanceState extends State<Search_ambulance> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(const Duration(seconds: 10), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MapScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: screenHeight/2.5, bottom: 5),
              child: Image.asset("assets/ambulance_img.webp", width: screenWidth/1.5,),
            ),
            Text(
              "Searching for Ambulance",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth*0.07, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
