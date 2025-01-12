import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oorvi_ambulance_app/screens/amb_arrived.dart';

class HospitalDetailScreen extends StatefulWidget {
  final String hospitalName;
  final int amount;
  const HospitalDetailScreen({Key? key, required this.hospitalName, required this.amount})
      : super(key: key);

  @override
  State<HospitalDetailScreen> createState() => _HospitalDetailScreenState();
}

class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
  int _timer = 5;
  late Timer _countdownTimer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1,), (timer) {
      setState(() {
        if (_timer > 0) {
          _timer--;
        } else {
          _countdownTimer.cancel();
          _navigateToHome();
        }
      });
    });
  }

  void _navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AmbArrived(amount: widget.amount,),
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Container(
            color: Colors.red,
            width: screenWidth,
            height: screenHeight * 0.1,
            padding: EdgeInsets.only(left: screenWidth * 0.08),
            child: Center(
              child: Text(
                widget.hospitalName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth*0.08,
                ),
              ),
            )
          ),
          Container(
            padding: EdgeInsets.only(top: screenHeight * 0.2),
            child: Image.asset(
              "assets/ambulance_img.webp",
              width: screenWidth / 1.5,
            ),
          ),
          const Text(
            'Your ambulance is arriving',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            color: Colors.red,
            padding: const EdgeInsets.all(5),
            margin: EdgeInsets.only(top: screenHeight * 0.05),
            child: Text(
              "$_timer minutes",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
