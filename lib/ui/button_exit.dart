import 'package:flutter/material.dart';

class ButtonYes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 50,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
            color: Colors.blueAccent,
      ),
      child: Text("Yes",style: TextStyle(color: Colors.white),),
    );
  }
}

class ButtonNo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      height: 30,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueAccent,
      ),
      child: Text("No",style: TextStyle(color: Colors.white),),
    );
  }
}

