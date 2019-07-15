import 'package:flutter_study/commom_import.dart';

class ThemeUtil {
  //默认主题色
  static const Color defultThemtColor = Colors.blueAccent;

  //可支持的主题颜色
  static const List<Color> supportThemeColor = [
    const Color(0xFF5394FF),
    Colors.purple,
    Colors.orange,
    Colors.deepPurpleAccent,
    Colors.redAccent,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.lime,
    Colors.indigo,
    Colors.cyan,
    Colors.teal
  ];

  //当前主题颜色
  static const currentThemtColor = defultThemtColor;
}
