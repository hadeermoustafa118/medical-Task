import 'package:flutter/material.dart';
import 'package:doc/presentaion/screens/login_screen.dart';

import '../components/action_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 200,
              ),
             const  Icon(
                Icons.monitor_heart_outlined,
                color: Colors.green,
                size: 130,
              ),
              const Text(
                'Doctor Hunt',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'You can find trusted doctors and book home visits in minutes.',
                style: TextStyle(fontSize: 18, color: Colors.black54 , ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 250,
              ),
              ActionButton(press: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }, buttonText:'Get Started'),
            ],
          ),
        ));
  }
}
