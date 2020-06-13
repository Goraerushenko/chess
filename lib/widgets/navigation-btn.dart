import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBtn extends StatelessWidget {
  NavigationBtn({
    Key key,
    this.text,
    this.color,
    this.moveTo
  }) : super(key: key);
  final Widget text;
  final Color color;
  final Widget moveTo;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
            context,
            CupertinoPageRoute (
              builder: (cnt) => moveTo
            )
      ),
      child: Container(
        height: 35.0,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}
