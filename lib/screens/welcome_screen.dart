import 'package:flutter/material.dart';
import 'package:oorvi_ambulance_app/screens/search_ambulance.dart';
import 'package:oorvi_ambulance_app/screens/user_profile.dart';

class Welcome_Screen extends StatefulWidget {
  const Welcome_Screen({super.key});

  @override
  State<Welcome_Screen> createState() => _Welcome_ScreenState();
}

class _Welcome_ScreenState extends State<Welcome_Screen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: screenWidth*0.05, right: screenWidth*0.05, top: screenWidth*0.1, bottom: screenWidth*0.3),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Hi,",
                      style: TextStyle(
                        fontSize: screenWidth*0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: screenWidth*0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserProfile(),
                      ),
                    );
                  },
                    child: Image.asset("assets/person.png")
                ),
              ],
            ),
            SizedBox(
              height: screenHeight*0.2,
            ),
            Image.asset("assets/Man.png",),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Search_ambulance(),
                  ),
                );
              },
              child: const Text(
                "Search Ambulance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
