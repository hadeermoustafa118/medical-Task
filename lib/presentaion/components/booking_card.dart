import 'package:flutter/material.dart';
class BookingCard extends StatelessWidget {
  const BookingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          child: Row(children: [
            Image.asset(
              'assets/images/doc.jpg',
              height: 110,
              width: 100,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dr/ Ahmed Elmohamdy', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(height: 10,),
                Text('Eyes Doctor', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 16),),
                Row(

                  children: [
                    Text('Date: 3/5/2023'),
                    SizedBox(width: 70,),
                    ElevatedButton(onPressed: (){}, child: Text('Cancel'), style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),
                  ],)

              ],
            ),
          ],),

        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
