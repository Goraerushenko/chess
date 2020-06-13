import 'package:chess/models/alg-model.dart';
import 'package:chess/models/figure/figure-kind.dart';
import 'package:chess/models/figure/figure-model.dart';
import 'package:chess/models/figure/figures-model.dart';
import 'package:chess/models/square/squares-model.dart';
import 'package:chess/models/square/way-info-model.dart';

class GameRules {

  Figures _figures;

  GameRules (this._figures);

  List<int> _castling (Figure king) {
    if (!king.touched) {
      List<Figure> rooks = [];
      List<int> usedSides = [];
      [-1, 1].forEach((side) {
        Coord kingCoord = Alg.coordByPos(king.pos);
        for (int i = side; Alg.posVerif(Alg.posByCoord(kingCoord.plusX(i))); i += side) {
          Coord curCoord = kingCoord.plusX(i);
          Figure figure = _figures.findFigure(Alg.posByCoord(curCoord));
          bool verification = Alg.posVerif(Alg.posByCoord(curCoord.plusX(side)));
          if (verification && figure != null) {
            break;
          } else if (!verification) {
            Figure rook = _figures.findFigure(Alg.posByCoord(curCoord));
            if (rook != null && !rook.touched) {
              rooks.add(rook);
              usedSides.add(side);
            }
          }
        }
      });
      List<int> kingCanGo = [];
      Alg.lenToArray(usedSides.length).forEach((i) {
        kingCanGo.add(2 * usedSides[i]);
        if (Alg.coordByPos(rooks[i].pos).x != 0) kingCanGo.add(3 * usedSides[i]);
      });
      return kingCanGo;
    } else {
      return [];
    }
  }

  WayInfo _getWayByCoords (List<int> canGoCoords, Figure who) {
    WayInfo wayInfo = WayInfo();
    canGoCoords.forEach ((int by) {
      final int to = who.pos + by;
      if (Alg.posVerif(to)) {
        final Figure figure = _figures.findFigure(to);
        if (figure == null) {
          wayInfo.canGo.add (to);
        } else {
          if (figure.style.color != who.style.color)
            wayInfo.canBeat.add(to);
        }
      }
    });
    return wayInfo;
  }

  List<int> _extensionList (List<int> list, Figure who) {
    List<int> willReturn = [];
    Alg.addNegative(list).forEach((coord) {
      for (int i = 1; i < 8; i++) {
        Figure figure = _figures.findFigure(who.pos + coord*i);
        if (Alg.posVerif(who.pos + coord*i)) {
          if ( figure == null) {
            willReturn.add(coord*i);
          } else if (figure.style != who.style) {
            willReturn.add(coord*i);
            break;
          }
        } else {
          break;
        }
      }
    });
    return willReturn;
  }

  WayInfo _pawnWay (int side, Figure pawn) {
    WayInfo wayInfo = WayInfo();
    wayInfo.canGo = _getWayByCoords(
        pawn.initPos == pawn.pos ? [side, side * 2] : [side], pawn).canGo;
    wayInfo.canBeat =
        _getWayByCoords([ (0.9 * side).toInt(), (1.1 * side).toInt()], pawn)
            .canBeat;
    return wayInfo;
  }

  WayInfo horse (Figure horse) => _getWayByCoords(Alg.addNegative([19, 21, 8, 12]), horse);

  WayInfo queen (Figure queen) => _getWayByCoords(_extensionList([1, 10, 11, 9], queen), queen);

  WayInfo elephant (Figure elephant) => _getWayByCoords(_extensionList([11, 9], elephant), elephant);

  WayInfo rook (Figure rook) => _getWayByCoords(_extensionList([1, 10], rook), rook);

  WayInfo king (Figure king) => _getWayByCoords(_castling (king) + Alg.addNegative([1, 10, 11, 9]), king);

  WayInfo pawn (Figure pawn) => _pawnWay (pawn.initPos > 30 ? -10 : 10, pawn);

  WayInfo getWayByStyle (Figure figure) {

   WayInfo curWay;

   switch (figure.style.kind) {
     case FigureKind.horse: {
       curWay = horse(figure);
     }
     break;
     case FigureKind.elephant: {
       curWay = elephant(figure);
     }
     break;
     case FigureKind.king: {
       curWay = king(figure);
     }
     break;
     case FigureKind.pawn: {
       curWay = pawn(figure);
     }
     break;
     case FigureKind.rook: {
       curWay = rook(figure);
     }
     break;
     case FigureKind.queen: {
       curWay = queen(figure);
     }
     break;
   }
   return curWay;
 }
}


