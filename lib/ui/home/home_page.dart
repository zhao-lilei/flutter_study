import 'package:dio/dio.dart';
import 'package:flutter_study/commom_import.dart';

class HomePage extends BaseWidget {
  @override
  BaseWidgetState getState() {
    return HomePageState();
  }
}

class HomePageState extends BaseWidgetState<HomePage> {
  List<Article> _articleList = new List();
  ScrollController _scrollController = ScrollController();
  bool isShowTopBtn = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    setAppBarVisible(false);
    _getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getDataMore();
      }

      if (_scrollController.position.pixels >= 200 && isShowTopBtn == false) {
        setState(() {
          isShowTopBtn = true;
        });
      } else if (_scrollController.position.pixels < 200 && isShowTopBtn) {
        setState(() {
          isShowTopBtn = false;
        });
      }
    });
  }

  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("不显示"),
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getData,
        child: ListView.separated(
          itemBuilder: _renderRow,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 0.5,
              color: Colors.black26,
            );
          },
          itemCount: _articleList.length + 2,
          controller: _scrollController,
          physics: new AlwaysScrollableScrollPhysics(),
        ),
        displacement: 15,
      ),
      floatingActionButton: !isShowTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }),
    );
  }

  @override
  void onClickErrorWidget() {
    showLoading();
    _getData();
  }

  Future<Null> _getData() async {
    _page = 0;
    ApiService().getArticleList((ArticleModel _articleModel) {
      if (_articleModel.errorCode == 0) {
        if (_articleModel.data.datas.length > 0) {
          showContent();
          setState(() {
            _articleList.clear();
            _articleList.addAll(_articleModel.data.datas);
          });
        } else {
          setState(() {
            showEmpty();
          });
        }
      } else {
        Fluttertoast.showToast(
            msg: _articleModel.errorMsg, gravity: ToastGravity.CENTER);
      }
    }, (DioError erroe) {
      setState(() {
        showError();
      });
    }, _page);
  }

  Future<Null> _getDataMore() async {
    _page++;
    ApiService().getArticleList((ArticleModel _articleModel) {
      if (_articleModel.errorCode == 0) {
        if (_articleModel.data.datas.length > 0) {
          showContent();
          setState(() {
            _articleList.addAll(_articleModel.data.datas);
          });
        } else {
          Fluttertoast.showToast(msg: "没有更多数据了");
        }
      } else {
        Fluttertoast.showToast(msg: _articleModel.errorMsg);
      }
    }, (DioError error) {
      Fluttertoast.showToast(msg: error.message);
    }, _page);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Widget _renderRow(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        height: 200,
        color: Colors.green,
        child: new HomeBannerWidget(),
      );
    } else if (index < _articleList.length - 1) {
      return new InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new WebViewPage(
              title: _articleList[index - 1].title,
              url: _articleList[index - 1].link,
            );
          }));
        },
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: <Widget>[
                  Text(_articleList[index - 1].author,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left),
                  Expanded(
                      child: Text(
                    _articleList[index - 1].niceDate,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.right,
                  )),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    _articleList[index - 1].title,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3D4E5F),
                    ),
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    _articleList[index - 1].superChapterName,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            )
          ],
        ),
      );
    }
    return null;
  }
}
