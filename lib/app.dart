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
  int elevation = 4;

  var pages = <Widget>[
    HomePage(),
    KnowledgePage(),
    PublicPage(),
    NavigationPage(),
    ProjectPage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer: DrawPage(),
          appBar: AppBar(
            title: new Text(_appBarTitles[_selectedIndex]),
            bottom: null,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (context) {
                      return new SearchPage();
                    }));
                  })
            ],
          ),
          body: new IndexedStack(
            children: pages,
            index: _selectedIndex,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('首页')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment), title: Text('体系')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat), title: Text('公众号')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.navigation), title: Text('导航')),
              BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('项目'))
            ],
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTap,
          ),
        ));
  }

  Future<bool> _onWillPop() {
    return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
                  title: new Text("温馨提醒"),
                  content: new Text("确定退出应用吗？"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: new Text("在看一会")),
                    new FlatButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: new Text('退出'))
                  ],
                )) ??
        false;
  }

  void _onItemTap(int value) {
    setState(() {
      _selectedIndex = value;
      if (value == 2 || value == 4) {
        elevation = 0;
      } else {
        elevation = 4;
      }
    });
  }
}
