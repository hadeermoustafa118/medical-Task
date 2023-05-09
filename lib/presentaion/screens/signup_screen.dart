import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doc/presentaion/controller/app_cubit.dart';
import 'package:doc/presentaion/screens/login_screen.dart';
import '../components/action_button.dart';
import '../components/text_field_component.dart';
import 'home_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Join us now!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Let's start our journey and book any doctor any time with one click.",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldComponent(
                    tap: () {},
                    textInputType: TextInputType.phone,
                    hintText: 'Phone',
                    controller: cubit.phoneController,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldComponent(
                    tap: () {},
                    textInputType: TextInputType.emailAddress,
                    hintText: 'Email address',
                    controller: cubit.emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldComponent(
                    tap: () {},
                    textInputType: TextInputType.text,
                    hintText: 'Name',
                    controller: cubit.usernameController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldComponent(
                    tap: () {
                      cubit.showMyDialog(context);
                    },
                    textInputType: TextInputType.text,
                    hintText: 'Date of birth',
                    controller: cubit.dateOfBirthController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldComponent(
                    tap: () {},
                    textInputType: TextInputType.visiblePassword,
                    hintText: 'Password',
                    controller: cubit.passController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // TextFieldComponent(
                  //   tap: (){},
                  //   textInputType: TextInputType.text,
                  //   hintText: 'Gender',
                  // ),

                  const SizedBox(
                    height: 40,
                  ),
                  ActionButton(
                      buttonText: 'Sign up',
                      press: () {
                        cubit.registers(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {


                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        'Already have an account? Login',
                        style: TextStyle(color: Colors.green),
                      )),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
