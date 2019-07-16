import 'package:flutter_study/commom_import.dart';

class HomeBannerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeBannerState();
  }
}

class HomeBannerState extends State<HomeBannerWidget> {
  List<BannerData> _bannerList = new List();

  @override
  void initState() {
    _bannerList.add(null);
    _getBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: _bannerList.length,
      autoplay: true,
      pagination: new SwiperPagination(),
      itemBuilder: (BuildContext context, int index) {
        if (_bannerList[index] == null ||
            _bannerList[index].imagePath == null) {
          return new Container(color: Colors.grey[100]);
        } else {
          return buildItemImageWidget(context, index);
        }
      },
    );
  }

  Future<Null> _getBanner() {
    ApiService().getBanner((BannerModel _bannerModel) {
      if (_bannerModel.data.length > 0) {
        _bannerList.clear();
        setState(() {
          _bannerList.addAll(_bannerModel.data);
        });
      }
    });
  }

  Widget buildItemImageWidget(BuildContext context, int index) {
    return new InkWell(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(
              title: _bannerList[index].title, url: _bannerList[index].url);
        }));
      },
      child: new Container(
        child: new Image.network(
          _bannerList[index].imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
