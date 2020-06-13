import 'package:chess/models/alg-model.dart';
import 'package:chess/models/figure/figure-color.dart';
import 'package:chess/models/figure/figure-kind.dart';
import 'package:chess/models/figure/figure-style-model.dart';

import 'figure-model.dart';

class Figures {
  String key = '';
  bool get hasData => figureList != null;

  List<Figure> figureList;

  Figures ({ this.figureList});

  Figures get clone  {
    final List<int> pos = figureList.map((e) => e.pos).toList();
    final List<FigureStyle> styles = figureList.map((e) => e.style).toList();
    final List<bool> touched = figureList.map((e) => e.touched).toList();
    final List<int> initPos = figureList.map((e) => e.initPos).toList();
    return Figures(
        figureList: Alg.lenToArray(pos.length).map((i) => Figure(
        pos: pos[i],
        style: styles[i],
        initPos: initPos[i],
        touched: touched[i]
    )).toList());
  }

  Figure findFigure (int pos) {
    List<int> posList = figureList.map((figure) => figure.pos).toList();
    return posList.indexOf(pos) == -1 ? null : figureList[posList.indexOf(pos)];
  }

  Figure findKing (FigureColor color) {
    for (var figure in  figureList) {
      if (figure.style.kind == FigureKind.king && figure.style.color == color)
        return figure;
    }
    return null;
  }

  FigureColor reverseColor (Figure figure) => figure.style.color == FigureColor.white ? FigureColor.black : FigureColor.white;

  List<Figure> oneType (FigureColor color) {
    List<Figure> oneTypeFigures = [];
    figureList.forEach((figure) => figure.style.color == color ? oneTypeFigures.add(figure) : null);
    return oneTypeFigures;
  }

  void switchPos (int who, int to) => figureList[findIndex(who)].pos = to;

  void remove (int pos) {
    figureList.removeAt(findIndex(pos));
    figureList = figureList.map((el) => el).toList();
  }

  int findIndex (int pos) {
    List<int> posList = figureList.map((figure) => figure.pos).toList();
    return posList.indexOf(pos);
  }

}


class CopiedFigures {
  String key = '';
  bool hasData () => figureList != null;

  List<Figure> figureList = [];

  Figure findFigure (int pos) {
    List<int> posList = figureList.map((figure) => figure.pos).toList();
    return posList.indexOf(pos) == -1 ? null : figureList[posList.indexOf(pos)];
  }

  Figure findKing (FigureColor color) {
    for (var figure in  figureList) {
      if (figure.style.kind == FigureKind.king && figure.style.color == color)
        return figure;
    }
    return null;
  }

  FigureColor reverseColor (Figure figure) => figure.style.color == FigureColor.white ? FigureColor.black : FigureColor.white;

  List<Figure> oneType (FigureColor color) {
    List<Figure> oneTypeFigures = [];
    figureList.forEach((figure) => figure.style.color == color ? oneTypeFigures.add(figure) : null);
    return oneTypeFigures;
  }

  List<Figure> copyList () => figureList.map((el) => el).toList();

  CopiedFigures copyModel () => CopiedFigures(
      figureList: figureList.map((el) => el).toList(),
      key: DateTime.now().microsecondsSinceEpoch.toString()
  );

  void switchPos (int who, int to) => figureList[findIndex(who)].pos = to;

  void remove (int pos) {
    figureList.removeAt(findIndex(pos));
    figureList = figureList.map((el) => el).toList();
  }

  int findIndex (int pos) {
    List<int> posList = figureList.map((figure) => figure.pos).toList();
    return posList.indexOf(pos);
  }
  Figures get toFigures => Figures(
      figureList: figureList.map((el) => el).toList(),
//      key: DateTime.now().microsecondsSinceEpoch.toString()
  );

  CopiedFigures({this.figureList,this.key});
}