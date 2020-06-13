import 'package:flutter/material.dart';


class BottomBtn extends StatelessWidget {
  BottomBtn ({
    Key key,
    this.icon,
    this.onTap
  }) : super(key: key);
  
  final IconData icon;
  final Function onTap;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 1.0,
              spreadRadius: 0.3,
              offset: Offset(
                1.0,
                1.0,
              ),
            )
          ]
        ),
        child: Center(
          child: Icon(icon, color: Colors.black, size: 30.0,),
        ),
      ),
    );
  }
}
