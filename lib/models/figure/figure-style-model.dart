import 'package:chess/models/figure/figure-color.dart';
import 'package:chess/models/figure/figure-kind.dart';

class FigureStyle {
  final String imgUrl;
  final FigureColor color;
  final FigureKind kind;

  FigureStyle({
    this.kind,
    this.color,
    this.imgUrl
  });
}
