import 'package:chess/models/figure/figure-color.dart';
import 'package:chess/models/figure/figure-model.dart';

class Save {
  List<Figure> list;
  FigureColor status;
  List<Figure> copy () => list.map((el) => el).toList();
}