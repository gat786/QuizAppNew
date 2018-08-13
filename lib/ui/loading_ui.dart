import 'package:flutter/material.dart';

class IsLoading extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return  Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black12,
          child: Center(
            child: CircularProgressIndicator(

            ),
          ),
      );
    }
}