import 'package:chess/models/board/boardController.dart';
import 'package:chess/models/figure/figure-model.dart';
import 'package:flutter/material.dart';

class GameAnim {
  Animation<Offset> _posAnim;
  AnimationController _posCont;
  AnimationStatus status () => _posCont.status;
  TickerProvider _provider;
  Function _update;
  Figure _figure;
  BoardController _boardController;

  void startAnim (Figure figure, {Offset begin, Offset end}) {
    _figure = figure;
    _posCont.reverse();
    _posAnim = Tween(
      begin: begin,
      end: end
    ).animate(_posCont)..addListener(() => _update());
    _posCont.forward();
  }


  Widget posAnimRender (double squareSize) => _posCont.status != AnimationStatus.dismissed ? Transform.translate(
    offset: Offset(_posAnim.value.dx - (squareSize * 0.8) / 2, _posAnim.value.dy - (squareSize * 0.8) / 2),
    child: Image.asset(
      _figure.style.imgUrl,
      height: squareSize * 0.8,
      width: squareSize * 0.8,
      fit: BoxFit.contain,
    ),
  ) : SizedBox ();

  void initial ({
    @required provider,
    @required update,
  }) {
    _update = update;
    _provider = provider;
    _posCont = AnimationController (
      vsync: _provider,
      duration: Duration (milliseconds: 400),
      reverseDuration: Duration(days: 0)
    );
  }
}