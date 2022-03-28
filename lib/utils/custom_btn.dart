import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String buttonText;
  final Color btnColor;



  CustomButton({ required this.buttonText, this.btnColor = Colors.amber,});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print('Button was clicked');
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.all(8.0),
        width: 200.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: btnColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                blurRadius: 10.0,
                spreadRadius: 1,

              )
            ]
        ),
        child: Text(buttonText, style: TextStyle(color: Colors.white),),
      ),
    );
  }
}