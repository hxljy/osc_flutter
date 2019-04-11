import 'package:flutter/material.dart';
import 'package:osc_flutter/common/event_bus.dart';
import 'package:osc_flutter/constants/constants.dart';
import 'package:osc_flutter/pages/login_web_page.dart';

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
      //TODO
    });
    eventBus.on<LogoutEvent>().listen((event) {
      //TODO
    });
  }

  void _showUserInfo() {}

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              color: Color(AppColors.COLOR_PRIMARY),
              height: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                            image: AssetImage(
                                'assets/images/ic_avatar_default.png'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    onTap: () {
                      //执行登录
                      _login();
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    '点击头像登录',
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
              //TODO
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
    final result = Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));
    if (result != null && result == 'refresh') {
      //登陆成功
      eventBus.fire(LoginEvent());
    }
  }
}
