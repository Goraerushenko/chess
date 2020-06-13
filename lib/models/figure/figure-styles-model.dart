import 'package:chess/models/figure/figure-color.dart';
import 'package:chess/models/figure/figure-kind.dart';
import 'package:chess/models/figure/figure-style-model.dart';

class FigureStyles {
  static final FigureStyle whiteHorse = FigureStyle(
    imgUrl: 'assets/img/figures/white-horse.png',
    color: FigureColor.white,
    kind: FigureKind.horse
  );
  static final FigureStyle blackHorse = FigureStyle(
    imgUrl: 'assets/img/figures/black-horse.png',
    color: FigureColor.black,
    kind: FigureKind.horse
  );
  static final FigureStyle blackElephant = FigureStyle(
    imgUrl: 'assets/img/figures/black-elephant.png',
    color: FigureColor.black,
    kind: FigureKind.elephant
  );
  static final FigureStyle whiteElephant = FigureStyle(
    imgUrl: 'assets/img/figures/white-elephant.png',
    color: FigureColor.white,
    kind: FigureKind.elephant
  );
  static final FigureStyle blackPawn = FigureStyle(
    imgUrl: 'assets/img/figures/black-pawn.png',
    color: FigureColor.black,
    kind: FigureKind.pawn
  );
  static final FigureStyle whitePawn = FigureStyle(
    imgUrl: 'assets/img/figures/white-pawn.png',
    color: FigureColor.white,
    kind: FigureKind.pawn
  );
  static final FigureStyle blackQueen = FigureStyle(
    imgUrl: 'assets/img/figures/black-queen.png',
    color: FigureColor.black,
    kind: FigureKind.queen
  );
  static final FigureStyle whiteQueen = FigureStyle(
      imgUrl: 'assets/img/figures/white-queen.png',
      color: FigureColor.white,
      kind: FigureKind.queen
  );
  static final FigureStyle blackKing = FigureStyle(
    imgUrl: 'assets/img/figures/black-king.png',
    color: FigureColor.black,
    kind: FigureKind.king
  );
  static final FigureStyle whiteKing = FigureStyle(
    imgUrl: 'assets/img/figures/white-king.png',
    color: FigureColor.white,
    kind: FigureKind.king
  );
  static final FigureStyle blackRook = FigureStyle(
    imgUrl: 'assets/img/figures/black-rook.png',
      color: FigureColor.black,
    kind: FigureKind.rook
  );
  static final FigureStyle whiteRook = FigureStyle(
    imgUrl: 'assets/img/figures/white-rook.png',
    color: FigureColor.white,
    kind: FigureKind.rook
  );
}