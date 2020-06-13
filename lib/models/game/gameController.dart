import 'package:chess/models/alg-model.dart';
import 'package:chess/models/board/boardController.dart';
import 'package:chess/models/figure/figure-kind.dart';
import 'package:chess/models/figure/figure-model.dart';
import 'package:chess/models/figure/figures-model.dart';
import 'package:chess/models/game/rescue-figures-model.dart';
import 'package:chess/models/square/squares-model.dart';
import 'package:chess/models/square/way-info-model.dart';
import 'package:flutter/cupertino.dart';
import 'game-rules-model.dart';
import 'game-anim-model.dart';
import 'game-status.dart';
import 'game-timer-model.dart';

class GameController {

  Rescue rescue = Rescue ();
  BoardController _boardController = BoardController ();
  GameRules gameRules;
  GameStatus gameStatus = GameStatus ();
  GameAnim anim = GameAnim ();
  GameTimer gameTimer = GameTimer ();
  void switchStatus () {
    gameTimer.switchStatus();
    gameStatus.switchStatus();
  }
  void move (int who, int to) {
    Figures figures = _boardController.figures;
    Figures exception = _exceptions(who, to);
    if (!exception.hasData) {
      if (figures.findFigure(to) != null) {
        figures.figureList.removeAt(figures.findIndex(to));
      }
      figures.figureList[figures.findIndex(who)].pos = to;
    }
    switchStatus ();
    rescue.clear ();
  }

  Figures moveImitation (int who, int to, Figures figures) {
    Figures exception = _exceptions(who, to, Lfigures: figures);
    if (!exception.hasData) {
      if (figures.findFigure(to) != null) {
        figures.figureList.removeAt(figures.findIndex(to));
      }
      figures.figureList[figures.findIndex(who)].pos = to;
    } else {
      figures = exception;
    }
    return figures;
  }

  void setRescue (Figure king) {
    _boardController.figures.clone.oneType(king.style.color).forEach(
      (figure) {
        rescue.figures.figureList.add(figure);

        WayInfo wayInfo = WayInfo();

        gameRules.getWayByStyle(figure).canGo.forEach((pos) {
          Figures imitation = moveImitation (figure.pos, pos, _boardController.figures.clone);
          bool kingKilled = canBeKilled (
              who: imitation.findKing(figure.style.color),
              Lfigures: imitation
          );
          if (!kingKilled) wayInfo.canGo.add(pos);
        });

        gameRules.getWayByStyle(figure).canBeat.forEach((pos) {
          Figures imitation = moveImitation (figure.pos, pos, _boardController.figures.clone);
          bool kingKilled = canBeKilled (
              who: imitation.findKing(figure.style.color),
              Lfigures: imitation
          );
          if (!kingKilled) wayInfo.canBeat.add(pos);
        });
        rescue.posList.add(wayInfo);
      }
    );
  }


  bool canBeKilled ({int pos, Figure who, Figures Lfigures}) {
    Figures figures = Lfigures == null ?  _boardController.figures : Lfigures.clone;
    Figure _figure = pos == null ? who : figures.findFigure(pos);
    for (var figure in figures.oneType(figures.reverseColor(_figure))) {
      GameRules _gameRules = GameRules(figures);
      if ( _gameRules.getWayByStyle(figure).canBeat.contains(_figure.pos)) return true;
    }
    return false;
  }

  Figures _exceptions (int who, int to, {Figures Lfigures}) {
    Figures figures = Lfigures == null ? _boardController.figures : Lfigures.clone;
    Figure figure = figures.findFigure(who);
    int posInt = Alg.toPositive(who - to);
    bool isCastling = figure.style.kind == FigureKind.king && posInt > 1 && posInt < 4;
    if (isCastling) {
      int shiftedTo = who - to;
      Coord rookCoord = Alg.coordByPos(figure.pos);
      rookCoord.x = shiftedTo < 0 ? 7 : 0;
      shiftedTo += shiftedTo > 0 ? -1 : 1;
      figures.switchPos(Alg.posByCoord(rookCoord), who + to - who + ((to - who) > 0 ? -1 : 1));
      figures.switchPos(who, to);
      return figures;
    } else {
      return Figures ();
    }
  }

  void initial ({
    @required boardController
  }) {
    _boardController = boardController;
  }
}
