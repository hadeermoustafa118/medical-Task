import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doc/presentaion/components/action_button.dart';
import 'package:doc/presentaion/components/text_field_component.dart';
import 'package:doc/presentaion/controller/app_cubit.dart';
import 'package:doc/presentaion/screens/signup_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=> AppCubit(),child: BlocConsumer<AppCubit, AppState>(listener: (context, state){},builder: (context , state){
     var cubit  = AppCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: cubit.formKeyLogin,
            child: Column(
              children: [
                const   SizedBox(
                  height: 250,
                ),

                const  Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.black),
                ),
                const  SizedBox(
                  height: 10,
                ),
                const   Text(
                  'You can find doctors, book an appointment from your home',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const   SizedBox(
                  height: 40,
                ),
                TextFieldComponent(
                  tap: (){},
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Email',
                  controller:cubit.emailForLoginController ,
                ),
                const   SizedBox(
                  height: 15,
                ),
                TextFieldComponent(
                  tap: (){},
                  textInputType: TextInputType.visiblePassword,
                  hintText: 'Password',
                  controller: cubit.passForLoginController,
                ),


                const   SizedBox(height: 150,),
                ActionButton(buttonText: 'Login', press: () {
                  cubit.login(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                }),
                const SizedBox(height: 10,),
                GestureDetector(
                    onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));}, child: const Text('Do not have an account ? Sign up', style: TextStyle(color: Colors.green),)),
              ],
            ),
          ),
        ),
      );
    },));

  }
}
