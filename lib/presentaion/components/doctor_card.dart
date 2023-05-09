import 'package:flutter/material.dart';
import 'package:doc/presentaion/screens/book_visit_screen.dart';
class DoctorCard extends StatelessWidget {
  const DoctorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Column(
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
                    Text('8 Years Experience'),
                    SizedBox(width: 60,),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingVisit()));
                    }, child: Text('Book'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),
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
