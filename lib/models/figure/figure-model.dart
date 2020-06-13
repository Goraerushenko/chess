import 'package:chess/models/figure/figure-style-model.dart';

class Figure {
  FigureStyle style;
  int pos;
  int initPos;
  bool touched;
  Figure({
    this.style,
    this.pos,
    this.initPos,
    this.touched = false
  });
}