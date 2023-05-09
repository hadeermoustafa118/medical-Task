import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doc/presentaion/components/action_button.dart';
import 'package:doc/presentaion/components/visit_book_button.dart';
import 'package:doc/presentaion/controller/app_cubit.dart';

class BookingVisit extends StatelessWidget {
  const BookingVisit({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'Fill data to confirm booking',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    VisitBookButton(
                        buttonText: 'Pick a date',
                        press: () {
                          cubit.showMyDialogDateAndTime(context);
                        }),
                   const SizedBox(
                      height: 30,
                    ),
                    VisitBookButton(buttonText: 'Attach PDF', press: () {}),
                   const SizedBox(
                      height: 30,
                    ),
                    // TextFieldComponent(
                    //     textInputType: TextInputType.text,
                    //     hintText: 'Address',
                    //     tap: () {
                    //       cubit.pickFile(context);
                    //     }),

                    VisitBookButton(
                        buttonText: 'Pick A location', press: () {
                          cubit.getPer(context);
                          cubit.getLoc();
                    }),
                   const SizedBox(
                      height: 200,
                    ),
                    ActionButton(buttonText: 'Book', press: () {}),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
