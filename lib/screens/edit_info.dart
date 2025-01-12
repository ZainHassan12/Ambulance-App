import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oorvi_ambulance_app/screens/user_profile.dart';
import 'package:intl/intl.dart';

class Edit_Info extends StatefulWidget {
  final String phone_number;

  const Edit_Info({Key? key, required this.phone_number})
      : super(key: key);

  @override
  State<Edit_Info> createState() => _Edit_InfoState();
}

class _Edit_InfoState extends State<Edit_Info> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String date = "Enter Date";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Edit Info",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                width: screenWidth * 0.78,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Enter Your Name',
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 15,),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email Address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: emailController,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Enter Your Email',
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15,),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Date of Birth',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: date,
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        onTap: () async {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now(),
                          ).then((value) =>
                          {
                            setState(() {
                              date = DateFormat("dd MMMM yyyy").format(value!);
                            })
                          });
                        },
                      ),
                      const SizedBox(height: 15,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          await updateUserData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserProfile()
                            ),
                          );
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateUserData() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('phone_number', isEqualTo: widget.phone_number)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(querySnapshot.docs[0].id)
          .update({
        'name': name,
        'email_address': email,
        'dob': date,
      });
    } else {
      await FirebaseFirestore.instance.collection('user').add({
        'name': name,
        'email_address': email,
        'phone_number': widget.phone_number,
        'dob': date,
      });
    }
  }
}
