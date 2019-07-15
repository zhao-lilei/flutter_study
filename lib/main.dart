import 'commom_import.dart';

void main() {
//  getLoginInfo();
  runApp(MyApp());
  if (Platform.isAndroid) {
    //以下两行 设置Android状态栏为透明沉浸。写在组件渲染之后，是为了在渲染之后进行set赋值，覆盖状态栏，如果写在渲染之前，则系统的MaterailApp组件会覆盖掉该值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

//Future<Null> getLoginInfo() async {}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Color themeColor = ThemeUtil.currentThemtColor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "玩转flutter",
      debugShowCheckedModeBanner: false,
      theme:
          new ThemeData(primaryColor: themeColor, brightness: Brightness.light),
      routes: <String, WidgetBuilder>{
        "app": (BuildContext context) => new App(),
        "splash": (BuildContext context) => new SplashScreen()
      },
      home: new LoadingPage(),
    );
  }
}
