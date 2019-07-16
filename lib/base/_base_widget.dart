import 'package:flutter_study/commom_import.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseWidget extends StatefulWidget {
  BaseWidgetState _state;

  @override
  BaseWidgetState createState() {
    _state = getState();
    return _state;
  }

  BaseWidgetState getState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T> {
  //对一些控件显示进行初始化管理
  bool _isShowAppBar = true; //导航栏是否需要显示

  bool _isShowLoadingWidget = false;

  //网络错误的展示
  bool _isShowErrorWidget = false;
  String _errorContentMessage = "网络请求失败，请检查您的网络";
  String _errorImgPath = "images/ic_error.png";

  //空界面的展示
  bool _isShowEmptyWidget = false;
  String _emptyContentMessage = "暂无数据哦～";
  String _emptyImgPath = "images/ic_empty.png";

  FontWeight _fontWeight = FontWeight.w600; //错误界面和空界面的信息字体大小

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getBaseAppBar(),
      body: Stack(
        children: <Widget>[
          getContentWidget(context),
          _getBaseErrorWidget(),
          _getBaseEmptyWidget(),
          _getBaseLoadingWidget()
        ],
      ),
    );
  }

  PreferredSizeWidget _getBaseAppBar() {
    return PreferredSize(
        child: Offstage(
          offstage: !_isShowAppBar,
          child: getAppBar(),
        ),
        preferredSize: Size.fromHeight(50));
  }

  AppBar getAppBar();

  Widget getContentWidget(BuildContext context);

  Widget _getBaseLoadingWidget() {
    return Offstage(
      offstage: !_isShowLoadingWidget,
      child: getLoadingWidget(),
    );
  }

  Widget _getBaseErrorWidget() {
    return Offstage(
      offstage: !_isShowErrorWidget,
      child: getErrorWidget(),
    );
  }

  Widget _getBaseEmptyWidget() {
    return Offstage(
      offstage: !_isShowEmptyWidget,
      child: getEmptyWidget(),
    );
  }

  Widget getLoadingWidget() {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 15, //值越大 加载图片越大
      ),
    );
  }

  Widget getEmptyWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(_emptyImgPath),
                width: 150,
                height: 150,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  _emptyContentMessage,
                  style: TextStyle(color: Colors.grey, fontWeight: _fontWeight),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getErrorWidget() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage(_errorImgPath), width: 120, height: 120),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  _errorContentMessage,
                  style: TextStyle(color: Colors.grey, fontWeight: _fontWeight),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: OutlineButton(
                  child: Text(
                    "重新加载",
                    style:
                        TextStyle(color: Colors.grey, fontWeight: _fontWeight),
                  ),
                  onPressed: () => {onClickErrorWidget()},
                ),
              )
            ],
          ),
        ));
  }

  void onClickErrorWidget(); //点击错误页面进行下一步操作

  void setAppBarVisible(bool isVisible) {
    setState(() {
      _isShowAppBar = isVisible;
    });
  }

  void showContent() {
    setState(() {
      _isShowEmptyWidget = false;
      _isShowErrorWidget = false;
      _isShowLoadingWidget = false;
    });
  }

  void showLoading() {
    setState(() {
      _isShowEmptyWidget = false;
      _isShowErrorWidget = false;
      _isShowLoadingWidget = true;
    });
  }

  void showEmpty() {
    setState(() {
      _isShowEmptyWidget = true;
      _isShowErrorWidget = false;
      _isShowLoadingWidget = false;
    });
  }

  void showError() {
    setState(() {
      _isShowEmptyWidget = false;
      _isShowErrorWidget = true;
      _isShowLoadingWidget = false;
    });
  }

  void setErrorMessage(String error) {
    if (error != null) {
      setState(() {
        _errorContentMessage = error;
      });
    }
  }

  void setErrorImage(String errorImage) {
    if (errorImage != null) {
      setState(() {
        _errorImgPath = errorImage;
      });
    }
  }

  void setEmptyMessage(String empty) {
    if (empty != null) {
      setState(() {
        _emptyContentMessage = empty;
      });
    }
  }

  void setEmptyImage(String emptyImage) {
    if (emptyImage != null) {
      setState(() {
        _emptyImgPath = emptyImage;
      });
    }
  }
}
