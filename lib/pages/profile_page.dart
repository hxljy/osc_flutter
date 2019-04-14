import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:osc_flutter/common/event_bus.dart';
import 'package:osc_flutter/constants/constants.dart';
import 'package:osc_flutter/pages/about_page.dart';
import 'package:osc_flutter/pages/login_web_page.dart';
import 'package:osc_flutter/pages/my_message_page.dart';
import 'package:osc_flutter/pages/profile_detail_page.dart';
import 'package:osc_flutter/utils/data_utils.dart';
import 'package:osc_flutter/utils/net_utils.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTiles = ['我的消息', '阅读记录', '我的博客', '我的问答', '我的活动', '我的团队', '邀请好友'];
  List menuIcons = [
    Icons.message,
    Icons.chrome_reader_mode,
    Icons.book,
    Icons.question_answer,
    Icons.local_activity,
    Icons.wifi_tethering,
    Icons.child_friendly,
  ];
  String userAvatar;
  String userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //尝试现实用户信息
    _showUserInfo();

    eventBus.on<LoginEvent>().listen((event) {
      //获取用户信息
      _getUserInfo();
    });
    eventBus.on<LogoutEvent>().listen((event) {
      _showUserInfo();
    });
  }

  void _showUserInfo() {
    DataUtils.getUserInfo().then((user) {
      if (mounted) {
        setState(() {
          if (user != null) {
            print('获取用户信息成功');
            userAvatar = user.avatar;
            userName = user.name;
          } else {
            print('未登录');
            userAvatar = null;
            userName = null;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(userAvatar);
    print(userName);
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              color: Color(AppColors.COLOR_PRIMARY),
              height: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //头像
                  GestureDetector(
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          image: DecorationImage(
                            image: userAvatar == null
                                ? AssetImage(
                                    'assets/images/ic_avatar_default.png')
                                : NetworkImage(userAvatar),
                            fit: BoxFit.cover,
                          )),
                    ),
                    onTap: () {
                      DataUtils.isLogin().then((isLogin) {
                        if (isLogin) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProfileDetailPage();
                          }));
                        } else {
                          //执行登录
                          _login();
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    userName ??= '点击头像登录',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          }
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTiles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              DataUtils.isLogin().then((isLogin) {
                if (isLogin) {
                  switch (index) {
                    case 0:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyMessagePage()));
                      break;
                  }
                } else {
                  _login();
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0.5,
          );
        },
        itemCount: menuTiles.length + 1);
  }

  void _login() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));
    if (result != null && result == 'refresh') {
      //登陆成功
      print('登陆成功');
      eventBus.fire(LoginEvent());
    }
  }

  void _getUserInfo() {
    DataUtils.getAccessToken().then((token) {
      if (token == null || token.length == 0) {
        return;
      }

      Map<String, dynamic> params = Map<String, dynamic>();
      params['access_token'] = token;
      params['dataType'] = 'json';
      print('accessToken: $token');

      NetUtils.get(AppUrls.OPENAPI_USER, params).then((data) {
        print("userinfo::$data");

        Map<String, dynamic> map = json.decode(data);
        DataUtils.saveUserInfo(map);
        if (mounted) {
          setState(() {
            print('获取用户信息成功');
            userAvatar = map['avatar'];
            userName = map['name'];
            print(userName);
          });
        }
      });
    });
  }
}
