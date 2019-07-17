import 'package:dio/dio.dart';
import 'package:flutter_study/commom_import.dart';

class KnowledgePage extends BaseWidget {
  @override
  BaseWidgetState getState() {
    return KnowledgePageState();
  }
}

class KnowledgePageState extends BaseWidgetState {
  List<SystemTreeData> _knowledgeList = new List();

  ScrollController _controller = ScrollController();

  bool _isShowTopBtn = false;

  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("不显示"),
    );
  }

  @override
  void initState() {
    super.initState();
    setAppBarVisible(false);
    _getData();
    _controller.addListener(() {
      if (_controller.position.pixels >= 200 && _isShowTopBtn == false) {
        setState(() {
          _isShowTopBtn = true;
        });
      } else if (_controller.position.pixels < 200 && _isShowTopBtn) {
        setState(() {
          _isShowTopBtn = false;
        });
      }
    });
  }

  @override
  Widget getContentWidget(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: ListView.separated(
            itemBuilder: _renderRow,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 0.5,
                color: Colors.black54,
              );
            },
            itemCount: _knowledgeList.length,
            controller: _controller),
        onRefresh: _getData,
        displacement: 15,
      ),
      floatingActionButton: !_isShowTopBtn
          ? null
          : FloatingActionButton(
              onPressed: () {
                _controller.animateTo(0,
                    duration: Duration(microseconds: 200), curve: Curves.ease);
              },
              child: Icon(Icons.arrow_upward)),
    );
  }

  @override
  void onClickErrorWidget() {
    showLoading();
    _getData();
  }

  Future<Null> _getData() async {
    ApiService().getSystemTree((SystemTreeModel _systemTreeModel) {
      if (_systemTreeModel.errorCode == 0) {
        if (_systemTreeModel.data.length > 0) {
          showContent();
          setState(() {
            _knowledgeList.clear();
            _knowledgeList.addAll(_systemTreeModel.data);
          });
        } else {
          showEmpty();
        }
      } else {
        Fluttertoast.showToast(msg: _systemTreeModel.errorMsg);
      }
    }, (DioError error) {
      showError();
    });
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < _knowledgeList.length) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new KnowledgeContent(new ValueKey(_knowledgeList[index]));
          }));
        },
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Text(
                        _knowledgeList[index].name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF3D4E5F),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: _buildChildWidget(_knowledgeList[index].children),
                    )
                  ],
                ),
              )),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      );
    }
    return null;
  }

  Widget _buildChildWidget(List<SystemTreeChild> children) {
    List<Widget> tiles = List(); //先创建一个组件数组，用于存放子控件
    Widget content; //内容组件
    for (var item in children) {
      tiles.add(new Chip(
        label: new Text(item.name),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Utils.getChipBgColor(item.name),
      ));
    }
    content = Wrap(
      runSpacing: 12,
      spacing: 12,
      alignment: WrapAlignment.start,
      children: tiles,
    );
    return content;
  }
}
