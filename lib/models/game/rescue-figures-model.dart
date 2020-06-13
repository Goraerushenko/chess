import 'package:chess/models/figure/figure-model.dart';
import 'package:chess/models/figure/figures-model.dart';
import 'package:chess/models/square/way-info-model.dart';

class Rescue {

  bool get hasData =>  figures.figureList.length != 0;

  List<WayInfo> posList = [];

  Figures figures = Figures(figureList: []);

  void clear () {
    posList = [];
    figures = Figures(figureList: []);
  }

}