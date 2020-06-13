import 'package:flutter/material.dart';
import '../alg-model.dart';

class Squares {
  List<List<GlobalKey>> squareKeys = [];

  GlobalKey findKey (int pos) => squareKeys[Alg.coordByPos(pos).y][Alg.coordByPos(pos).x];

  Widget keyRender (int pos) => Center(
    child: Container(
        height: 1,
        width: 1,
        key: findKey(pos)
    ),
  );

  void createKeys () {
    List(8).forEach((el) {
      squareKeys.add([]);
      List(8).forEach((el) {
        squareKeys.last.add(GlobalKey());
      });
    });
  }
}

class Coord {
  int x;
  int y;
  Coord plusX (int plusAt) => Coord(x + plusAt, y);
  Coord plusY (int plusAt) => Coord(x, y+ plusAt);
  Coord(this.x, this.y);
}