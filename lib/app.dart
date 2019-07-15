import 'commom_import.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int _selectedIndex = 0; //当前索引页面
  final _appBarTitles = ['Android', '体系', '公众号', '导航', '项目'];
  int evevation = 4;

  var pages = <Widget>[HomePage(),];

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
