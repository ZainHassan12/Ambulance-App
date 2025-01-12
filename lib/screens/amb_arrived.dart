import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AmbArrived extends StatefulWidget {
  final int amount;
  const AmbArrived({Key? key, required this.amount})
      : super(key: key);

  @override
  State<AmbArrived> createState() => _AmbArrivedState();
}

class _AmbArrivedState extends State<AmbArrived> {

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Payment Successful: ${response.paymentId!}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Payment Failed: ${response.message!}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "External Wallet: ${response.walletName!}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _openCheckout() async {
    var options = {
      'key': 'rzp_test_TFIkz8CVOy1EEH',
      'amount': widget.amount*100,
      'name': 'Amb Aid',
      'description': 'Ambulance Fair',
      'prefill': {'contact': '8888888888', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHeight*0.3,
          ),
          Image.asset("assets/amb_arrived.png"),
          Text(
            "Your ambulance has arrived",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth*0.07,
            ),
          ),
          const Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
                onPressed: (){
                _openCheckout();
                },
                child: const Text(
                  "Pay Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
