import 'package:chess/models/game/game-mode.dart';
import 'package:chess/pages/game-page.dart';
import 'package:chess/pages/pick-page.dart';
import 'package:chess/widgets/navigation-btn.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _logo (),
            SizedBox ( height: 30.0,),
            Column(
              children: <Widget>[
                NavigationBtn(
                  color: Colors.black,
                  text: Text(
                    'SINGL PLAYER',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  moveTo: PickPage()
                ),
                SizedBox (height: 35.0,),
                NavigationBtn(
                  color: Colors.black,
                  text: Text(
                    'WITH A FRIENDS',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  moveTo: GamePage(
                      gameMode: GameMode.friends,
                      boardSize: MediaQuery.of(context).size.width * 0.95
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _logo () => Container(
    height: MediaQuery.of(context).size.height * 0.4,
    width: MediaQuery.of(context).size.width * 0.5,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/img/logo/logo-black.png'),
        fit: BoxFit.contain
      )
    ),
  );
}
//GamePage(
//gameMode: GameMode.whiteBot,
//boardSize: MediaQuery.of(context).size.width * 0.95
//),