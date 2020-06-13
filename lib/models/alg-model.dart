import 'package:chess/models/square/squares-model.dart';

class Alg {

  static List<int> lenToArray (int length) {
    List<int> willReturn = [];
    for (int i = 0; i < length; i++) {
      willReturn.add(i);
    }
    return willReturn ;
  }

  static int posByCoord (Coord coord) => coord.y < 0 || coord.x < 0 ? -1 : int.parse ('${coord.y}${coord.x}');

  static Coord coordByPos (int pos) {
    int y = pos > 9 ? int.parse('$pos'[0]) : 0;
    int x = y == 0 ? int.parse('$pos'[0]) : int.parse('$pos'[1]);
    return Coord(x, y);
  }

  static List<int> addNegative (List<int> firstPath) => firstPath + firstPath.map((el) => -el).toList();

  static int toPositive (int curInt) => curInt < 0 ? curInt * -1 : curInt;

  static bool posVerif (int pos) => pos >= 0 ? coordByPos(pos).x < 8 && coordByPos(pos).y < 78 : false;

 }