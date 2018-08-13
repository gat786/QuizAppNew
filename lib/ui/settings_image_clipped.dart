import 'package:flutter/material.dart';

class ClippedPath extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Material(
          child: new Container(
            height: 280.0,
            child:new Stack(
              children: <Widget>[
                new ClipPath(
                  child: new Stack(
                    children: <Widget>[
                      new Container(
                        decoration:new BoxDecoration(
                        image: new DecorationImage(fit: BoxFit.fill,
                        image: AssetImage("assets/images/clipped.jpg")
                        )
                      ),
                      width: double.infinity,),
                      new Container(color: Colors.black54,)
                    ],
                  ),
                  clipper: BottomWaveClipper(),
                ),
              ],
            ),
          )
        );
    }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}