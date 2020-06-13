import 'package:chess/models/board/boardController.dart';
import 'package:chess/models/figure/figure-model.dart';
import 'package:chess/models/game/gameController.dart';
import 'package:chess/models/square/touched-square-model.dart';
import 'package:chess/models/square/way-info-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Touch {

  TouchedSquare touchedSquare = TouchedSquare();
  WayInfo wayInfo = WayInfo ();
  bool touchStatus = false;
  double _squareSize;
  Animation<double> _choosingAnim;
  AnimationController _choosingCont;
  TickerProvider _provide;
  GameController _gameController;
  Function _update;
  Figure _figure;
  BoardController _boardController;

  Widget canGo (int pos) => wayInfo.canGo.indexOf(pos) != -1 ? Center (
    child: Container(
      height: _squareSize * 0.22 * _choosingAnim.value,
      width: _squareSize * 0.22 * _choosingAnim.value,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.yellow[200],
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
            )
          ]
      ),
    ),
  ) : SizedBox();

  Widget canKillRender () {
    List<Figure> figures = [];
    wayInfo.canBeat.forEach((pos) {
      final Figure figure = _boardController.figures.findFigure(pos);
      if (!figures.contains(figure)) figures.add(figure);
    });
    return Stack (
      children: figures.map((figure) => Transform.translate(
        offset: findTouch(_squareSize * _choosingAnim.value, _boardController.squares.findKey(figure.pos)),
        child: Container(
          height: _squareSize * _choosingAnim.value,
          width: _squareSize * _choosingAnim.value,
          decoration: BoxDecoration(
              color: Colors.red,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                )
              ]
          ),
          child: Center (
            child: Image.asset(
              figure.style.imgUrl,
              height: (_squareSize * 0.8) * _choosingAnim.value,
              width: (_squareSize * 0.8) * _choosingAnim.value,
              fit: BoxFit.contain,
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget touchRender () =>  Transform.translate(
    offset: findTouch(_squareSize * _choosingAnim.value, touchedSquare.key),
    child: Container(
      height: _squareSize * _choosingAnim.value,
      width: _squareSize * _choosingAnim.value,
      decoration: BoxDecoration(
        color: Colors.yellow[200],
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
          )
        ],
      ),
      child: Center (
        child: Image.asset(
          _figure.style.imgUrl,
          height: (_squareSize * 0.8) * _choosingAnim.value,
          width: (_squareSize * 0.8) * _choosingAnim.value,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );

  void touchOn (int pos) {
    final Figure figure = _boardController.figures.findFigure(pos);
    if (wayInfo.canBeat.indexOf(pos) != -1 || wayInfo.canGo.indexOf(pos) != -1) {
       _boardController.figures.figureList[_boardController.figures.findIndex(touchedSquare.pos)].touched = true;
//      RenderBox fBox = _boardController.squares.findKey(touchedSquare.pos).currentContext.findRenderObject();
//      RenderBox sBox = _boardController.squares.findKey(pos).currentContext.findRenderObject();
//      _gameController.anim.startAnim (
//          _boardController.figures.findFigure(touchedSquare.pos),
//          begin: fBox.localToGlobal(Offset.zero),
//          end: sBox.localToGlobal(Offset.zero)
//      );

      _gameController.move(touchedSquare.pos, pos);
      clear();
      _update();
    } else if(figure != null && _gameController.gameStatus.status == figure.style.color) {
      Figure king = _boardController.figures.findKing(figure.style.color);
      if (!_gameController.rescue.hasData) _gameController.setRescue(king);
      clear();
      wayInfo = _gameController.rescue.posList[_gameController.rescue.figures.findIndex(pos)] ?? WayInfo ();
      _choosingCont.forward();
      TouchedSquare pressedSquare = TouchedSquare (
          key: _boardController.squares.findKey(pos),
          pos: pos
      );
      _figure = figure;
      touchStatus = true;
      touchedSquare =  pressedSquare;
    }
    _update();
  }

  Offset findTouch (double squareSize, GlobalKey key) {
    RenderBox box = key.currentContext.findRenderObject();
    Offset pos = box.localToGlobal(Offset.zero);
    return Offset(pos.dx - squareSize / 2 , pos.dy - squareSize / 2);
  }


  void initial ({
    @required TickerProvider provide,
    @required double squareSize,
    @required Function update,
    @required BoardController boardController,
    @required GameController gameController
  }) {
    _gameController = gameController;
    _boardController = boardController;
    _provide = provide;
    _squareSize = squareSize;
    _update = update;
    _choosingCont = AnimationController (vsync: _provide, duration: Duration(milliseconds: 400), reverseDuration: Duration(days: 0));
    _choosingAnim =
      Tween(
          begin: 1.5,
          end: 1.0
      ).animate(_choosingCont)
        ..addListener(() => _update());
  }

  void clear () {
    _choosingCont.reverse();
    wayInfo = WayInfo();
    touchStatus = false;
    touchedSquare = TouchedSquare();

  }
}