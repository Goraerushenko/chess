import 'package:chess/models/board/boardController.dart';
import 'package:chess/models/figure/figure-model.dart';
import 'package:chess/models/figure/figure-styles-model.dart';
import 'package:chess/models/game/game-mode.dart';
import 'package:chess/models/game/game-rules-model.dart';
import 'package:chess/models/game/game-timer-model.dart';
import 'package:chess/models/game/gameController.dart';
import 'package:chess/widgets/board.dart';
import 'package:chess/widgets/game-timer.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget{
  GamePage ({
    Key key,
    @required this.gameMode,
    @required this.boardSize
  }) : super(key: key);

  final double boardSize;

  final GameMode gameMode;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {

  final BoardController boardController = BoardController();
  final GameController gameController = GameController();
  @override
  void initState() {

    gameController.gameRules = GameRules(boardController.figures);

    gameController.anim.initial(provider: this, update: () => setState(() {}));

    boardController.squares.createKeys();

    boardController.touch.initial(
        gameController: gameController,
        update: () => setState(() {}),
        provide: this,
        squareSize: (widget.boardSize - 2)  / 8,
        boardController: boardController
    );
    gameController.gameTimer.gameInit(
      gameMode: widget.gameMode,
      time: Duration(minutes: 2)
    );
    gameController.initial(boardController: boardController);

    boardController.figures.figureList = boardController.initialPos.getInitialPos (widget.gameMode);

    super.initState();
  }
  @override
  void dispose() {
    gameController.gameTimer.time.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Align (
              alignment: Alignment.topLeft,
              child: GameTime (gameController.gameTimer, CurTimer.top),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .05, right: MediaQuery.of(context).size.width * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _winInfo (-3),
                      Text(
                        widget.gameMode == GameMode.friends ? 'Player' : 'Bot',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: widget.boardSize,
                  width: widget.boardSize,
                ),

                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .05, right: MediaQuery.of(context).size.width * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Player',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      ),
                      _winInfo (3)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align (
            alignment: Alignment.bottomLeft,
            child:  GameTime (gameController.gameTimer, CurTimer.bottom),
          ),
          Board(
            gameController: gameController  ,
            boardController: boardController,
            boardSize: widget.boardSize,
            gameMode: widget.gameMode,
          ),
        ],
      ),
    );
  }


  Widget _winInfo (double side) => Container(
    height: 35,
    width: 35,
    decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: -1.0,
              blurRadius: 5.0,
              offset: Offset (side, 0 )
          )
        ]
    ),
  );
}
