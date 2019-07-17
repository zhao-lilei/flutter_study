import 'package:dio/dio.dart';
import 'package:flutter_study/commom_import.dart';

class NewsListPage extends BaseWidget {
  int _listIds;

  NewsListPage(this._listIds);

  @override
  BaseWidgetState<BaseWidget> getState() {
    return NewsListPageState();
  }
}

class NewsListPageState extends BaseWidgetState<NewsListPage> {
  int id;
  int _page = 0;
  ScrollController _scrollController = ScrollController();
  List<SystemTreeContentChild> _newListdatas = new List();

  @override
  void initState() {
    super.initState();
    this.id = widget._listIds;
    showLoading();
    setAppBarVisible(false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getNewsListMore();
      }
    });
    _getNewsList();
  }

  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("不显示"),
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    return RefreshIndicator(
        child: ListView.separated(
          itemBuilder: _renderRow,
          separatorBuilder: (BuildContext context, int index) {
//            return Container(
//              height: 0.5,
//              color: Colors.black26,
//              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
//            );
            return new Divider(
              height: 0.5,
              color: Colors.black26,
              indent: 15,
              endIndent: 15,
            );
          },
          itemCount: _newListdatas.length,
          controller: _scrollController,
          physics: new AlwaysScrollableScrollPhysics(),
        ),
        onRefresh: _getNewsList);
  }

  @override
  void onClickErrorWidget() {
    showLoading();
    _getNewsList();
  }

  Future<Null> _getNewsList() async {
    _page = 0;
    ApiService().getSystemTreeContent((SystemTreeContentModel model) {
      if (model.errorCode == 0) {
        if (model.data.datas.length > 0) {
          showContent();
          setState(() {
            _newListdatas.clear();
            _newListdatas.addAll(model.data.datas);
          });
        } else {
          showEmpty();
        }
      } else {
        Fluttertoast.showToast(msg: model.errorMsg);
      }
    }, (DioError error) {
      showError();
    }, _page, id);
  }

  Future<Null> _getNewsListMore() async {
    _page++;
    ApiService().getSystemTreeContent((SystemTreeContentModel model) {
      if (model.errorCode == 0) {
        if (model.data.datas.length > 0) {
          showContent();
          setState(() {
            _newListdatas.addAll(model.data.datas);
          });
        } else {
          Fluttertoast.showToast(msg: "没有更多数据了哦～");
        }
      } else {
        Fluttertoast.showToast(msg: model.errorMsg);
      }
    }, (DioError error) {
      Fluttertoast.showToast(msg: error.message);
    }, _page, id);
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < _newListdatas.length) {
      return new InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return new WebViewPage(
                title: _newListdatas[index].title,
                url: _newListdatas[index].link);
          }));
        },
        child: Container(
          child: _newsRow(_newListdatas[index]),
        ),
      );
    }
    return null;
  }

  Widget _newsRow(SystemTreeContentChild child) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  child.author,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.left,
                ),
                Expanded(
                    child: Text(
                  child.niceDate,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.right,
                )),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  child.title,
                  style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xFF3D4E5F),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Row(
              children: <Widget>[
                Text(
                  child.superChapterName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '/' + child.chapterName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.right,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
