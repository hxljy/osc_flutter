import 'package:flutter/material.dart';
import 'package:osc_flutter/pages/common_web_page.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  List<Map<String, IconData>> blocks = [
    {
      '开源众包': Icons.pageview,
      '开源软件': Icons.speaker_notes_off,
      '码云推荐': Icons.screen_share,
      '代码骗贷': Icons.assignment,
    },
    {
      '扫一扫': Icons.camera_alt,
      '摇一摇': Icons.camera,
    },
    {
      '码云封面人物': Icons.person,
      '线下活动': Icons.android,
    }
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: blocks.length,
        itemBuilder: (BuildContext context, int blockIndex) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                ),
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                ),
              ),
            ),
            child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _handleItemClick(
                          blocks[blockIndex].keys.elementAt(index));
                    },
                    child: Container(
                      height: 60.0,
                      child: ListTile(
                        leading: Icon(
                            blocks[blockIndex].values.elementAt(index)),
                        title: Text(blocks[blockIndex].keys.elementAt(index)),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, mapIndex) {
                  return Divider(
                    height: 1.0,
                    color: Colors.grey,
                  );
                },
                itemCount: blocks[blockIndex].length),
          );
        }
    );
  }

  void _handleItemClick(String title) {
    switch (title) {
      case '开源众包':
        _navToWebPage(title, 'https://zb.oschina.net/');
        break;
      case '扫一扫':
//        scan();
        break;
      case '摇一摇':
//        Navigator.of(context)
//            .push(MaterialPageRoute(builder: (context) => ShakePage()));
        break;
    }
  }

  void _navToWebPage(String title, String url) {
    if (title != null && url != null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CommonWebPage(title: title,url: url,)));
    }
  }

}
