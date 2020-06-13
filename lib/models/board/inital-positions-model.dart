import 'package:chess/models/figure/figure-color.dart';
import 'package:chess/models/figure/figure-model.dart';
import 'package:chess/models/figure/figure-style-model.dart';
import 'package:chess/models/figure/figure-styles-model.dart';

import '../game/game-mode.dart';

class InitialPositions {

  List<Figure> _initFigPos = [];

  void _pawnRow (int firstSquare, FigureColor color) {
    for (int i = 0; i < 8; i++) {
      _initFigPos.add(
          Figure(
              pos: firstSquare + i,
              style: color == FigureColor.black ? FigureStyles.blackPawn : FigureStyles.whitePawn,
              initPos: firstSquare + i
          )
      );
    }
  }

  void _mainRow (int firstSquare, FigureColor color, side) {
    final FigureStyle rook = color == FigureColor.black ? FigureStyles.blackRook : FigureStyles.whiteRook;
    final FigureStyle horse = color == FigureColor.black ? FigureStyles.blackHorse : FigureStyles.whiteHorse;
    final FigureStyle elephant = color == FigureColor.black ? FigureStyles.blackElephant : FigureStyles.whiteElephant;
    final List<FigureStyle> styles = [rook, horse, elephant];
    styles.forEach((style) {
      _initFigPos.add(
          Figure(
            pos: firstSquare,
            style: style,
          )
      );
      firstSquare += side;
    });

  }

  void _queenRow (int firstSquare, FigureColor color) {
    final FigureStyle king = color == FigureColor.black ? FigureStyles.blackKing : FigureStyles.whiteKing;
    final FigureStyle queen = color == FigureColor.black ? FigureStyles.blackQueen : FigureStyles.whiteQueen;
    _initFigPos.add (
        Figure(
            style: king,
            pos: firstSquare + 3
        )
    );
    _initFigPos.add (
        Figure(
            style: queen,
            pos: firstSquare + 4
        )
    );
  }

  List<Figure> getInitialPos (GameMode gameMode) {
    _initFigPos = [];
    FigureColor color = gameMode == GameMode.friends || gameMode == GameMode.blackBot
        ? FigureColor.white : FigureColor.black;
    [0, 10].forEach((i) {
      color = color == FigureColor.white ? FigureColor.black : FigureColor.white;
      _queenRow(i * 7, color);
      _mainRow (i * 7, color, 1);
      _mainRow (7 + 7 * i, color, -1);
      _pawnRow (10 + 5 * i, color);
    });
    return _initFigPos;
  }

}