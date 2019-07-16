import 'package:flutter_study/commom_import.dart';

class WebViewPage extends StatefulWidget {
  String title;
  String url;

  WebViewPage({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  bool isLoad = true;
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: WebviewScaffold(
      url: widget.url,
      withJavascript: true,
      withLocalStorage: true,
      withZoom: false,
      appBar: AppBar(
        title: new Text(widget.title),
        elevation: 0.4,
        bottom: new PreferredSize(
            child: isLoad
                ? new LinearProgressIndicator()
                : new Divider(
                    height: 1.0,
                    color: ThemeUtil.currentThemtColor,
                  ),
            preferredSize: const Size.fromHeight(1.0)),
      ),
    ));
  }
}
