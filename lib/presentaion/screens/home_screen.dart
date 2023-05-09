import 'package:flutter/material.dart';
import 'package:doc/presentaion/components/action_button.dart';
import 'package:doc/presentaion/screens/booking_list_screen.dart';
import 'package:doc/presentaion/screens/login_screen.dart';

import '../components/doctor_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
          }, icon: Icon(Icons.logout, color: Colors.white,))
        ],
        title: const Text('Doctor hunt'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ActionButton(buttonText: 'Booking List', press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BookingList()));
                }),
                const SizedBox(
                  height: 30,
                ),
              DoctorCard(),
                DoctorCard(),
                DoctorCard(),
                DoctorCard(),
                DoctorCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
