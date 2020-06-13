import 'package:chess/models/game/game-timer-model.dart';
import 'package:flutter/material.dart';

class GameTime extends StatefulWidget {
  GameTime(this.gameTimer, this.curTimer);

  final GameTimer gameTimer;
  final CurTimer curTimer;

  @override
  _GameTimeState createState() => _GameTimeState();
}

class _GameTimeState extends State<GameTime> {

  int durToInt (Duration dur) => dur.inMilliseconds;

  @override
  void initState() {
    widget.curTimer == CurTimer.top ?
      widget.gameTimer.topUpdate = () => setState(() {}) :
      widget.gameTimer.bottomUpdate = () => setState(() {});
    if (widget.gameTimer.hasData) widget.gameTimer.timer();
    widget.gameTimer.switchStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Duration curDur = widget.curTimer == CurTimer.top ?
      widget.gameTimer.topTimerDur :
      widget.gameTimer.bottomTimerDur;
    final double perSent =  1 - durToInt(curDur) / durToInt(widget.gameTimer.gameTime);
    print (perSent);
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: 5,
      width: MediaQuery.of(context).size.width * perSent,
      color: widget.curTimer == widget.gameTimer.curTimer ? Colors.greenAccent : Colors.grey,
    );
  }
}
