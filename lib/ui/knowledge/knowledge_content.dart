import 'package:flutter_study/commom_import.dart';

class KnowledgeContent extends StatefulWidget {
  SystemTreeData _treeData;

  KnowledgeContent(ValueKey<SystemTreeData> key) : super(key: key) {
    this._treeData = key.value;
  }

  @override
  State<StatefulWidget> createState() {
    return KnowledgeContentState();
  }
}

class KnowledgeContentState extends State<KnowledgeContent>
    with TickerProviderStateMixin {
  SystemTreeData _datas;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    this._datas = widget._treeData;
  }

  @override
  Widget build(BuildContext context) {
    _tabController =
        new TabController(length: _datas.children.length, vsync: this);
    return Scaffold(
      appBar: new AppBar(
        title: new Text(_datas.name),
        bottom: new TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            isScrollable: true,
            tabs: _datas.children.map((SystemTreeChild item) {
              return Tab(
                text: item.name,
              );
            }).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _datas.children.map((item) {
          return new NewsListPage(item.id);
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
