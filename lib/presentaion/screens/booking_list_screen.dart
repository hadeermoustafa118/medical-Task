import 'package:flutter/material.dart';
import 'package:doc/presentaion/components/booking_card.dart';
class BookingList extends StatelessWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking List'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(
                  height: 30,
                ),
                BookingCard(),
                BookingCard(),BookingCard(),BookingCard(),BookingCard(),BookingCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
