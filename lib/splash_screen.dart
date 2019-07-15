import 'commom_import.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
    slides.add(new Slide(
      title: "flutter page one",
      description:
          "Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。",
      styleDescription:
          TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
      marginDescription:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
      colorBegin: Color(0xffFFDAB9),
      colorEnd: Color(0xff40E0D0),
      directionColorBegin: Alignment.topLeft,
      directionColorEnd: Alignment.bottomRight,
    ));
    slides.add(new Slide(
      title: "flutter page two",
      description:
          "这是一款使用Flutter写的WanAndroid客户端应用，在Android和IOS都完美运行,可以用来入门Flutter，简单明了，适合初学者,项目完全开源，如果本项目确实能够帮助到你学习Flutter，谢谢start，有问题请提交Issues,我会及时回复。",
      styleDescription:
          TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
      marginDescription:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
      colorBegin: Color(0xffFFFACD),
      colorEnd: Color(0xffFF6347),
      directionColorBegin: Alignment.topLeft,
      directionColorEnd: Alignment.bottomRight,
    ));
    slides.add(new Slide(
      title: "Welcome",
      description: "赠人玫瑰，手有余香；\n分享技术，传递快乐。",
      styleDescription:
          TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
      marginDescription:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
      colorBegin: Color(0xffFFA500),
      colorEnd: Color(0xff7FFFD4),
      directionColorBegin: Alignment.topLeft,
      directionColorEnd: Alignment.bottomRight,
    ));
  }

  void onSkipPress() {
    //跳过 跳转至主界面
    _setHasSkip();
  }

  void onDonePress() {
    //完成 跳转至主界面
    _setHasSkip();
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      onSkipPress: this.onSkipPress,
      onDonePress: this.onDonePress,
      nameNextBtn: "下一页",
      nameSkipBtn: "跳过",
      namePrevBtn: "上一页",
      nameDoneBtn: "进入",
    );
  }

  void _setHasSkip() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool("hasSkip", true);
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => App()),
        (router) => router == null);
  }
}
