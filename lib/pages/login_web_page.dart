import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:osc_flutter/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:osc_flutter/utils/data_utils.dart';
import 'package:osc_flutter/utils/net_utils.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听url变化
    _flutterWebviewPlugin.onUrlChanged.listen((url) {
      print('LoginWebPage url---->> $url');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      //https://www.baidu.com/?code=pgLb9e&state=
      if (url != null && url.length > 0 && url.contains('?code=')) {
        //登陆成功
        //截取code
        String code = url.split('?')[1].split('&')[0].split('=')[1];

        Map<String, dynamic> params = Map<String, dynamic>();
        params['client_id'] = AppInfos.CLIENT_ID;
        params['client_secret'] = AppInfos.CLIENT_SECRET;
        params['grant_type'] = 'authorization_code';
        params['redirect_uri'] = AppInfos.REDIRECT_URI;
        params['code'] = '$code';
        params['dataType'] = 'json';

        NetUtils.get(AppUrls.OAUTH2_TOKEN, params).then((data) {
          print(data);
          // {"access_token":"a48f013e-a9c1-4d88-b63c-57da0a5747b0",
          // "refresh_token":"13b54d9c-0c74-443c-9ae4-61610bd62c76",
          // "uid":3330277,
          // "token_type":"bearer",
          // "expires_in":604799}
          if (data != null) {
            Map<String ,dynamic> map=json.decode(data);
            if(map!=null&&map.isNotEmpty){
              //保存token
              DataUtils.saveLoginInfo(map);
              //弹出当前路由，并返回refresh 通知界面刷新数据
              Navigator.pop(context,'refresh');
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //authorize?response_type=code&client_id=s6BhdRkqt3&state=xyz&redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb

    List<Widget> _appBarTitle = [
      Text(
        '登录开源中国',
        style: TextStyle(color: Color(AppColors.COLOR_APPBAR)),
      ),
    ];

    if (isLoading) {
      _appBarTitle.add(SizedBox(
        width: 13.0,
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }

    return WebviewScaffold(
      url: AppUrls.OAUTH2_AUTHORIZE +
          '?response_type=code&client_id=' +
          AppInfos.CLIENT_ID +
          '&redirect_uri=' +
          AppInfos.REDIRECT_URI,
      appBar: AppBar(
        title: Row(
          children: _appBarTitle,
        ),
      ),
      withJavascript: true,
      //允许执行js
      withLocalStorage: true,
      //允许本地存储
      withZoom: true, //允许网页缩放
    );
  }
}
