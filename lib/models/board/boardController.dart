import 'package:chess/models/board/inital-positions-model.dart';
import 'package:chess/models/figure/figures-model.dart';
import 'package:chess/models/square/squares-model.dart';
import 'package:chess/models/square/touch-model.dart';

class BoardController {
  Figures figures = Figures(figureList: []);
  Squares squares = Squares();
  Touch touch = Touch();
  InitialPositions initialPos = InitialPositions ();

}

