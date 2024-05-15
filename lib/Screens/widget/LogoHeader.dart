import 'package:flutter/material.dart';
class LogoHeader extends StatelessWidget {
  LogoHeader(this.title, {super.key}) ;
  String title;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const SizedBox(height: 70,),
        Image.asset("assets/images/logo.png",width: 100,),

        Text(
          title,style: const TextStyle(
            fontSize: 35,fontWeight: FontWeight.bold,color: Color.fromRGBO(61, 102, 112, 1)),
        ),
      ],
    );
  }
}
