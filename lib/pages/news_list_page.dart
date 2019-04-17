import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:osc_flutter/common/event_bus.dart';
import 'package:osc_flutter/constants/constants.dart';
import 'package:osc_flutter/pages/login_web_page.dart';
import 'package:osc_flutter/utils/data_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:osc_flutter/utils/net_utils.dart';
import 'package:osc_flutter/widgets/NewsListItem.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => new _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {

  bool isLogin = false;
  int curPage = 1;
  List newsList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataUtils.isLogin().then((isLogin) {
      if (!mounted) {
        return;
      }
      setState(() {
        this.isLogin = isLogin;
      });
    });


    eventBus.on<LoginEvent>().listen((event) {
      setState(() {
        this.isLogin = true;
      });
      //获取新闻列表
      getNewsList(false);
    });

    eventBus.on<LogoutEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('需要登录才能获取资讯'),
            SizedBox(height: 12.0,),
            CupertinoButton(
                child: Text('去登录'),
                pressedOpacity: 0.7,
                color: Color(AppColors.COLOR_PRIMARY),
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginWebPage()));
                  if (result != null && result == 'refresh') {
                    //登陆成功，
                    eventBus.fire(LoginEvent());
                  }
                }),

          ],
        ),
      );
    }


    return RefreshIndicator(child: buildListView(), onRefresh: _pullToRefresh);
  }

  void getNewsList(bool isLoadMore) async {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((token) {
          if (token == null || token.length == 0) {
            return;
          }
          Map<String, dynamic> params = Map<String, dynamic>();
          params['access_token'] = token;
          params['catalog'] = 1;
          params['page'] = curPage;
          params['pageSize'] = 10;
          params['dataType'] = 'json';

          NetUtils.get(AppUrls.NEWS_LIST, params).then((data) {
            print('NEWS_LIST: $data');
            if (data != null && data.isNotEmpty) {
              Map<String, dynamic> map = json.decode(data);
              List _newsList = map['newslist'];
              if (!mounted) return;
              setState(() {
                if (isLoadMore) {
                  newsList.addAll(_newsList);
                } else {
                  newsList = _newsList;
                }
              });
            }
          }
          );
        });
      }
    });
  }

  Widget buildListView() {
    if (newsList == null) {
      getNewsList(false);
      return CupertinoActivityIndicator();
    }
    return ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return NewsListItem(newsList: newsList[index]);
        });
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }
}
