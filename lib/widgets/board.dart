import 'package:chess/models/alg-model.dart';
import 'package:chess/models/board/boardController.dart';
import 'package:chess/models/figure/figure-model.dart';
import 'package:chess/models/game/game-mode.dart';
import 'package:chess/models/game/gameController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  Board ({
    Key key,
    @required this.boardSize,
    @required this.gameMode,
    @required this.boardController,
    @required this.gameController
  }) : super (key: key);

  final BoardController boardController;
  final GameMode gameMode;
  final GameController gameController;
  final double boardSize;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> with TickerProviderStateMixin{

  void _onTapSquare (int pos) {
    widget.boardController.touch.touchOn(pos);
    print(pos);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            height: widget.boardSize,
            width: widget.boardSize,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 1.0, color: Colors.grey)
            ),
            child: Column(
                  children: Alg.lenToArray(8).map((column) => Row(
                    children: Alg.lenToArray(8).map((row) => _figure(
                      column: column,
                      row: row
                  )).toList(),
              )).toList(),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              widget.gameController.anim.posAnimRender((widget.boardSize - 2) / 8),
              GestureDetector (
                onTap: () => _onTapSquare (widget.boardController.touch.touchedSquare.pos),
                child: widget.boardController.touch.touchStatus ?
                widget.boardController.touch.canKillRender() : SizedBox(),
              ),

              widget.boardController.touch.touchStatus ?
                widget.boardController.touch.touchRender() : SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
  Widget _figure ({int column , int row}) {
    double squareSize = (widget.boardSize - 2) / 8;
    int pos = column * 10 + row;
    Figure figure = widget.boardController.figures.findFigure(pos);
    return GestureDetector(
      onTap: () => _onTapSquare (pos),
      child: Container(
          color: column % 2 == 0 ?
            row % 2 == 0 ? Colors.grey : Colors.white :
            row % 2 != 0 ? Colors.grey : Colors.white ,
          height: squareSize,
          width: squareSize,
          child: Stack(
            children: <Widget>[
              figure != null ? Center(
                child: Image.asset(
                  figure.style.imgUrl,
                  height: squareSize * 0.8,
                  width: squareSize * 0.8,
                  fit: BoxFit.contain,
                ),
              ) : SizedBox(),
              widget.boardController.squares.keyRender(pos),
              widget.boardController.touch.canGo(pos),
            ],
          )
      ),
    );
  }
}
