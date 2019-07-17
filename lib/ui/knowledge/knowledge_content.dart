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

class KnowledgeContentState extends State<KnowledgeContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
