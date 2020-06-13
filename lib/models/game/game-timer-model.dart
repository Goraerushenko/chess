import 'dart:async';
import 'package:chess/models/game/game-mode.dart';
import 'package:flutter/cupertino.dart';

class GameTimer {
  GameMode _gameMode;
  Duration gameTime;
  Duration topTimerDur = Duration.zero;
  Duration bottomTimerDur = Duration.zero;
  CurTimer curTimer = CurTimer.bottom;
  Timer time;

  bool get hasData => topUpdate != null;
  Function topUpdate;
  Function bottomUpdate;

  void timer () => time = Timer.periodic(
      Duration(milliseconds: 50),
      (timer) {
        curTimer == CurTimer.bottom ? bottomUpdate() : topUpdate ();
        curTimer == CurTimer.top ?
          topTimerDur = topTimerDur + Duration(milliseconds: 50) :
          bottomTimerDur = bottomTimerDur + Duration(milliseconds: 50);
        if (gameTime <= (curTimer == CurTimer.top ? topTimerDur : bottomTimerDur)) time.cancel();
}
  );
  void switchStatus () =>
      curTimer = curTimer == CurTimer.bottom ? CurTimer.top : CurTimer.bottom;

  void gameInit ({
    @required GameMode gameMode,
    @required Duration time,
  }) {
    gameTime = time;
    _gameMode = gameMode;
  }

}

enum CurTimer {
  top,
  bottom
}