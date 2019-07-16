import 'commom_import.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoadingPageState();
  }
}

class LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    super.initState();
    //加载页面停留两秒
    new Future.delayed(Duration(seconds: 2), () {
      _getHasSkip();
    });
  }

  void _getHasSkip() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool hasSkip = sharedPreferences.getBool("hasSkip");
    if (hasSkip == null || !hasSkip) {
      Navigator.of(context).pushReplacementNamed("splash");
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => App()),
          (route) => route == null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Stack(
        children: <Widget>[
          Image.asset(
            "images/loading.png",
            fit: BoxFit.fill,
          )
        ],
      ),
    );
  }
}
