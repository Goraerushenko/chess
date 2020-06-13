import 'package:chess/models/game/game-mode.dart';
import 'package:chess/pages/game-page.dart';
import 'package:chess/widgets/bottom-button.dart';
import 'package:chess/widgets/navigation-btn.dart';
import 'package:flutter/material.dart';

class PickPage extends StatefulWidget {
  @override
  _PickPageState createState() => _PickPageState();
}

class _PickPageState extends State<PickPage> {
  GameMode gameMode = GameMode.blackBot;

  void _onChange (GameMode mode) {
    setState(() =>  gameMode = mode);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'PICK YOUR SIDE',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0
                ),
              ),
              Row(
                children: <Widget>[
                  _whiteRadio(),
                  _blackRadio ()
                ],
              ),
              NavigationBtn (
                moveTo: GamePage(
                    gameMode: gameMode,
                    boardSize: MediaQuery.of(context).size.width * 0.90
                ),
                color: Colors.black,
                text: Text(
                  'CONTINUE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BottomBtn (
                    icon: Icons.home,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(width: 30.0,),
                  BottomBtn (
                    icon: Icons.settings,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _whiteRadio () => Column(
    children: <Widget>[
      Container (
        child: Image.asset(
          'assets/img/pick-pawns/white-pawn.png',
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.5,
          fit: BoxFit.contain,
        ),
      ),
      Radio(
        value: GameMode.blackBot,
        groupValue: gameMode,
        onChanged: (value) => _onChange(value),
        activeColor: Colors.black,
      ),
    ],
  );

  Widget _blackRadio () => Column(
    children: <Widget>[
      Container(
        child: Image.asset(
          'assets/img/pick-pawns/black-pawn.png',
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.5,
          fit: BoxFit.contain,
        ),
      ),
      Radio(
        value: GameMode.whiteBot,
        groupValue: gameMode,
        onChanged: (value) => _onChange(value),
        activeColor: Colors.black,
        autofocus: true,
      ),
    ],
  );
}
