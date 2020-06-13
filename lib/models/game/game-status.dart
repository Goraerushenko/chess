
import 'package:chess/models/figure/figure-color.dart';

class GameStatus {

  FigureColor status = FigureColor.white;

  void switchStatus () =>
      status = status == FigureColor.white ? FigureColor.black : FigureColor.white;
}